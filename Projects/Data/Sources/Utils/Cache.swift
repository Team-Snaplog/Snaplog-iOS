//
//  Cache.swift
//  Data
//
//  Created by 강민성 on 11/3/24.
//  Copyright © 2024 com.team.snaplog. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

public final class Cache<T: Equatable> {
    typealias FetchDataType = () -> Single<T>
    private var fetchLocalData: (FetchDataType)!
    private var fetchRemoteData: (FetchDataType)!
    private var isNeedRefresh: (_ localData: T, _ remoteData: T) -> Bool = { $0 != $1 }
    private var refreshLocalData: ((_ remoteData: T) -> Void)!

    func localData(fetchLocalData: @escaping FetchDataType) -> Self {
        self.fetchLocalData = fetchLocalData
        return self
    }

    func remoteData(fetchRemoteData: @escaping FetchDataType) -> Self {
        self.fetchRemoteData = fetchRemoteData
        return self
    }

    func compareData(isNeedRefresh: @escaping (_ localData: T, _ remoteData: T) -> Bool) -> Self {
        self.isNeedRefresh = isNeedRefresh
        return self
    }

    func doOnNeedRefresh(refreshLocalData: @escaping (_ remoteData: T) -> Void) -> Self {
        self.refreshLocalData = refreshLocalData
        return self
    }

    func createObservable() -> Observable<T> {
        let local = fetchLocalData()
            .asObservable()
            .map { Optional($0) }
            .catchAndReturn(nil)
        let remote = fetchRemoteData()
            .asObservable()
            .map { Optional($0) }
        return local.concat(remote)
            .enumerated()
            .scan(into: (index: -1, element: nil)) { (prev, new) in
                if prev.index != -1 {
                    if prev.element  == nil || self.isNeedRefresh(prev.element!, new.element!) {
                        self.refreshLocalData(new.element!)
                        prev = new
                    }
                } else {
                    prev = new
                }
            }
            .map(\.element)
            .compactMap { $0 }
    }
}
