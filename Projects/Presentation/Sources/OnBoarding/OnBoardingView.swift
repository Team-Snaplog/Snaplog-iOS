//
//  OnBoardingView.swift
//  Presentation
//
//  Created by 강민성 on 9/8/24.
//  Copyright © 2024 com.team.snaplog. All rights reserved.
//

//import UIKit
//import DesignSystem
//import Utility
//
//import SnapKit
//
//public final class OnBoardingView: UIView {
//
//    let logoImageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.image = DesignSystemAsset.Image.logo.image
//        return imageView
//    }()
//
//    var googleButton: UIButton = {
//        var button = UIButton()
//        button.backgroundColor = .blue
//        return button
//    }()
//
//    var appleButton: UIButton = {
//        var button = UIButton()
//        button.backgroundColor = .red
//
//        return button
//    }()
//
//    var guestButton: UIButton = {
//        var button = UIButton()
//        button.setTitle("또는 게스트로 시작하기", for: .normal)
////        button.titleLabel?.font = Fonts.buttonMedium.font
//        button.setTitleColor(DesignSystemAsset.NeutralColor.neutral500.color, for: .normal)
//        return button
//    }()
//
//    public override init(frame: CGRect) {
//        super.init(frame: frame)
//        render()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    private func render() {
//        addSubViews([logoImageView, googleButton, appleButton, guestButton])
//
//        logoImageView.snp.makeConstraints { make in
//            make.top.equalToSuperview().offset(284)
//            make.bottom.equalToSuperview().offset(-454)
//            make.centerX.equalToSuperview()
//        }
//
//        googleButton.snp.makeConstraints { make in
//            make.top.equalTo(logoImageView.snp.bottom).offset(170)
//            make.centerX.equalToSuperview()
//        }
//
//        appleButton.snp.makeConstraints { make in
//            make.top.equalTo(googleButton.snp.bottom).offset(12)
//            make.centerX.equalToSuperview()
//        }
//
//        guestButton.snp.makeConstraints { make in
//            make.top.equalTo(appleButton.snp.bottom).offset(30)
//            make.width.equalTo(129)
//            make.height.equalTo(20)
//            make.bottom.equalToSuperview().offset(-78)
//            make.centerX.equalToSuperview()
//        }
//    }
//}
