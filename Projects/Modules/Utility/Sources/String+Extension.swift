//
//  String+Extension.swift
//  Utility
//
//  Created by 강민성 on 10/21/24.
//  Copyright © 2024 com.team.snaplog. All rights reserved.
//

extension String {
    public var isSingleEmoji: Bool { count == 1 && containsEmoji }
    public var containsEmoji: Bool { contains { $0.isEmoji } }
}
