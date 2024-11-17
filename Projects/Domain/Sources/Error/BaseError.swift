//
//  BaseError.swift
//  Domain
//
//  Created by 강민성 on 11/3/24.
//  Copyright © 2024 com.team.snaplog. All rights reserved.
//

import Foundation

public enum BaseError: Error {
    // 400

    // 401

    // 403

    // 404

    // 406

    // 409

    // 500
    case serverError

    // unknown
    case error(message: String = "에러가 발생하였습니다.", errorBody: [String: Any] = [:])
}

extension BaseError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .serverError:
            return "서버가 불안정 합니다. 잠시 후 다시 시도해주세요."
        case .error(message: let message, errorBody: let errorBody):
            return "에러가 발생하였습니다."
        }
    }
}
