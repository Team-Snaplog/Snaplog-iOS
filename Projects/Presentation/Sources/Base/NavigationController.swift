//
//  NavigationController.swift
//  Presentation
//
//  Created by 강민성 on 9/2/24.
//  Copyright © 2024 com.team.snaplog. All rights reserved.
//

import UIKit

public class NavigationController: UINavigationController, UIGestureRecognizerDelegate {

    /// Custom back buttons disable the interactive pop animation
    /// To enable it back we set the recognizer to `self`
    public override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }

}
