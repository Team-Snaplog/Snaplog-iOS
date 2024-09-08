//
//  OnBoardingViewController.swift
//  Presentation
//
//  Created by 강민성 on 8/28/24.
//  Copyright © 2024 com.team.snaplog. All rights reserved.
//

import UIKit
import DesignSystem

import ReactorKit

public final class OnBoardingViewController: BaseViewController<OnBoardingReactor>, ReactorKit.View {
    
    public typealias Reactor = OnBoardingReactor

    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = DesignSystemAsset.AzureColor.azure500.color

        // Do any additional setup after loading the view.
    }

    public override func configureUI() {
        super.configureUI()
    }
}

extension OnBoardingViewController {
    public func bind(reactor: OnBoardingReactor) {
        
    }
}
