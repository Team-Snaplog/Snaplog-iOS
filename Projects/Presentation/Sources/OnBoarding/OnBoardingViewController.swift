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

    let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = DesignSystemAsset.Image.logo.image
        return imageView
    }()

    var googleButton: UIButton = {
        var button = UIButton()
        button.backgroundColor = .blue
        return button
    }()

    var appleButton: UIButton = {
        var button = UIButton()
        button.backgroundColor = .red
        return button
    }()

    var guestButton: UIButton = {
        var button = UIButton()
        button.setTitle("또는 게스트로 시작하기", for: .normal)
        button.titleLabel?.font = Fonts.labelMedium.font
        button.setTitleColor(DesignSystemAsset.NeutralColor.neutral500.color, for: .normal)
        return button
    }()

    public override func viewDidLoad() {
        super.viewDidLoad()
        render()
    }

    public override func configureUI() {
        super.configureUI()
//        addNavigationTitleLabel()
    }

    private func render() {
        view.addSubViews([logoImageView, googleButton, appleButton, guestButton])

        logoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(284).priority(.high)
            make.height.equalTo(28)
            make.centerX.equalToSuperview()
        }

        googleButton.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(170)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(20)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-20)
            make.height.equalTo(56)
            make.centerX.equalToSuperview()
        }

        appleButton.snp.makeConstraints { make in
            make.top.equalTo(googleButton.snp.bottom).offset(12)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(20)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-20)
            make.height.equalTo(56)
            make.centerX.equalToSuperview()
        }

        guestButton.snp.makeConstraints { make in
            make.top.equalTo(appleButton.snp.bottom).offset(30)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            make.height.equalTo(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-78)
            make.centerX.equalToSuperview()
        }
    }
}

extension OnBoardingViewController {
    public func bind(reactor: OnBoardingReactor) {
        
    }
}
