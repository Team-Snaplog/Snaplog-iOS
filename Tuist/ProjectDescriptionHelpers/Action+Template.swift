//
//  Action+Template.swift
//  ProjectDescriptionHelpers
//
//  Created by 강민성 on 8/27/24.
//

import ProjectDescription

public extension TargetScript {
    static let swiftLint = TargetScript.pre(
        path: Path.relativeToRoot("Scripts/SwiftLintRunScript.sh"),
        name: "SwiftLint",
        basedOnDependencyAnalysis: false
    )
    
//    static let googleInfoPlistScripts = TargetScript.pre(
//        script: """
//                case "${CONFIGURATION}" in
//                    "DEV" )
//                        cp -r "$SRCROOT/Resources/Firebase/GoogleService-Dev-Info.plist" "${BUILT_PRODUCTS_DIR}/${PRODUCT_NAME}.app/GoogleService-Info.plist" ;;
//                    "STAGE" )
//                        cp -r "$SRCROOT/Resources/Firebase/GoogleService-Stage-Info.plist" "${BUILT_PRODUCTS_DIR}/${PRODUCT_NAME}.app/GoogleService-Info.plist" ;;
//                    "PROD" )
//                        cp -r "$SRCROOT/Resources/Firebase/GoogleService-Prod-Info.plist" "${BUILT_PRODUCTS_DIR}/${PRODUCT_NAME}.app/GoogleService-Info.plist" ;;
//                    *)
//                    ;;
//                esac
//                """,
//        name: "GoogleService-Info.plist",
//        basedOnDependencyAnalysis: false
//    )
}
