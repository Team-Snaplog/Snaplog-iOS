//
//  Reactive+.swift
//  Utility
//
//  Created by 강민성 on 10/6/24.
//  Copyright © 2024 com.team.snaplog. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa
import PhotosUI

extension Reactive where Base: UIViewController {
    public var viewDidLoad: Observable<Void> {
        return methodInvoked(#selector(UIViewController.viewDidLoad))
            .map { _ in }
    }

    public var viewWillAppear: Observable<Void> {
        return methodInvoked(#selector(UIViewController.viewWillAppear))
            .map { _ in }
    }

    public var viewDidAppear: Observable<Void> {
        return methodInvoked(#selector(UIViewController.viewDidAppear))
            .map { _ in }
    }

    public var viewWillDisappear: Observable<Void> {
        return methodInvoked(#selector(UIViewController.viewWillDisappear))
            .map { _ in }
    }

    public var viewDidDisappear: Observable<Void> {
        return methodInvoked(#selector(UIViewController.viewDidDisappear))
            .map { _ in }
    }
}
