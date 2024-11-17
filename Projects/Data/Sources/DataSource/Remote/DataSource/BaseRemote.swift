//
//  BaseRemote.swift
//  Data
//
//  Created by 강민성 on 11/3/24.
//  Copyright © 2024 com.team.snaplog. All rights reserved.
//

import Foundation
import Domain
import AppNetwork
import Core

import Alamofire
import Moya
import RxSwift
import RxMoya

public class BaseRemote<API: BaseAPI> {
    private let keychain: any Keychain

    private let provider: MoyaProvider<API>

    init(keychain: any Keychain) {
        self.keychain = keychain
        self.provider = MoyaProvider<API>(plugins: [JWTPlugin(keychain: keychain)])
    }

    func request(_ api: API) -> Single<Response> {
        return .create { single in
            var disposables: [Disposable] = []
            if self.isNeedAccessToken(api) {
                disposables.append(
                    self.requestWithAccessToken(api)
                        .subscribe(
                            onSuccess: { single(.success($0)) },
                            onFailure: { single(.failure($0)) }
                        )
                )
            } else {
                disposables.append(
                    self.defaultRequest(api)
                        .subscribe(
                            onSuccess: { single(.success($0)) },
                            onFailure: { single(.failure($0)) }
                        )
                )
            }
            return Disposables.create(disposables)
        }
    }
}

private extension BaseRemote {
    func isNeedAccessToken(_ api: API) -> Bool {
        return api.jwtTokenType == .accessToken
    }

    func checkTokenIsValid() -> Bool {
        let expiredDate = keychain.load(type: .accessTokenExpriedAt).getDate()
        return Date() < expiredDate
    }

    func defaultRequest(_ api: API) -> Single<Response> {
        return provider.rx
            .request(api)
            .timeout(.seconds(200), scheduler: MainScheduler.asyncInstance)
            .catch { error in
                guard let statusCode = (error as? MoyaError)?.response?.statusCode else {
                    return .error(error)
                }
                return .error(
                    api.errorMapper?[statusCode] ??
                    BaseError.error(
                        message: (try? (error as? MoyaError)?
                            .response?
                            .mapJSON() as? NSDictionary)?["message"] as? String ?? "",
                        errorBody: [:]
                    )
                )
            }
    }

    func requestWithAccessToken(_ api: API) -> Single<Response> {
        return .deferred {
            if self.checkTokenIsValid() {
                return self.defaultRequest(api)
            } else {
                return .error(TokenError.expired)
            }
        }
        .retry(when: { (errorObservable: Observable<TokenError>) in
            return errorObservable
                .flatMap { error -> Observable<Void> in
                    switch error {
                    case .expired:
                        return self.reissueToken()
                            .andThen(.just(()))

                    default:
                        return .empty()
                    }
                }
        })
    }

    func reissueToken() -> Completable {
        return AuthRemote(keychain: keychain).refresh()
    }
}

extension String {
    func getDate() -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.date(from: self) ?? .init()
    }
}
