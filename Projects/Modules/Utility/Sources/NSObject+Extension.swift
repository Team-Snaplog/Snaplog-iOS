//
//  NSObject+Extension.swift
//  Utility
//
//  Created by 강민성 on 9/19/24.
//  Copyright © 2024 com.team.snaplog. All rights reserved.
//

import Foundation

public extension NSObject {
    static var className: String {
        return String(describing: self)
    }
}
