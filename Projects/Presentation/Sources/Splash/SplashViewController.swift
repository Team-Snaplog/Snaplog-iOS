//
//  SplashViewController.swift
//  Presentation
//
//  Created by 강민성 on 9/8/24.
//  Copyright © 2024 com.team.snaplog. All rights reserved.
//

import UIKit
import DesignSystem

import ReactorKit
import SnapKit

public final class SplashViewController: BaseViewController<SplashReactor>, ReactorKit.View {

    public typealias Reactor = SplashReactor

    let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = DesignSystemAsset.Image.logo.image
        return imageView
    }()

    public override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubViews([logoImageView])

        logoImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(284)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(454)
            make.centerX.equalToSuperview()
        }
    }

    public override func configureUI() {
        super.configureUI()
    }
}

extension SplashViewController {
    public func bind(reactor: SplashReactor) {

    }
}
