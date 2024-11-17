//
//  BaseAPI.swift
//  AppNetwork
//
//  Created by 강민성 on 11/5/24.
//  Copyright © 2024 com.team.snaplog. All rights reserved.
//

import Foundation

import Moya

public protocol BaseAPI: TargetType, JWTTokenAuthorizable {
    associatedtype ErrorType: Error
    var domain: BaseDomain { get }
    var urlPath: String { get }
    var errorMapper: [Int: ErrorType]? { get }
}

extension BaseAPI {
    public var baseURL: URL {
        return URL(
            string: Bundle.main.object(forInfoDictionaryKey: "API_BASE_URL") as? String ?? ""
        ) ?? URL(string: "https://www.apple.com")!
    }

    public var path: String {
        return domain.url + urlPath
    }

    public var validationType: ValidationType {
        return .successCodes
    }

    public var headers: [String: String]? {
        switch self {
        default:
            return ["Content-Type": "application/json"]
        }
    }
}

public enum BaseDomain: String {
    case auth
    case topic
}

extension BaseDomain {
    var url: String {
        return "/\(self.rawValue)"
    }
}
