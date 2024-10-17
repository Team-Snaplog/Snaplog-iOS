//
//  WeekdayView.swift
//  Presentation
//
//  Created by 강민성 on 9/27/24.
//  Copyright © 2024 com.team.snaplog. All rights reserved.
//

import UIKit
import DesignSystem

import SnapKit

public final class WeekdayView: UIStackView {

//    private var weeks = ["일", "월", "화", "수", "목", "금", "토"]

//    private func makeLabel(_ text: String) -> UILabel {
//        var label = UILabel()
//        label.text = text
//        label.font = UIFont(name: "Pretendard-SemiBold", size: 10)
//        label.textAlignment = .center
//        label.textColor = DesignSystemAsset.NeutralColor.neutral400.color
//        return label
//    }

    var label1: UILabel = {
        var label = UILabel()
        label.text = "일"
        label.font = UIFont(name: "Pretendard-SemiBold", size: 10)
        label.textAlignment = .center
        label.textColor = DesignSystemAsset.NeutralColor.neutral400.color

        return label
    }()

    var label2: UILabel = {
        var label = UILabel()
        label.text = "월"
        label.font = UIFont(name: "Pretendard-SemiBold", size: 10)
        label.textAlignment = .center
        label.textColor = DesignSystemAsset.NeutralColor.neutral400.color

        return label
    }()

    var label3: UILabel = {
        var label = UILabel()
        label.text = "화"
        label.font = UIFont(name: "Pretendard-SemiBold", size: 10)
        label.textAlignment = .center
        label.textColor = DesignSystemAsset.NeutralColor.neutral400.color

        return label
    }()

    var label4: UILabel = {
        var label = UILabel()
        label.text = "수"
        label.font = UIFont(name: "Pretendard-SemiBold", size: 10)
        label.textAlignment = .center
        label.textColor = DesignSystemAsset.NeutralColor.neutral400.color

        return label
    }()

    var label5: UILabel = {
        var label = UILabel()
        label.text = "목"
        label.font = UIFont(name: "Pretendard-SemiBold", size: 10)
        label.textAlignment = .center
        label.textColor = DesignSystemAsset.NeutralColor.neutral400.color

        return label
    }()

    var label6: UILabel = {
        var label = UILabel()
        label.text = "금"
        label.font = UIFont(name: "Pretendard-SemiBold", size: 10)
        label.textAlignment = .center
        label.textColor = DesignSystemAsset.NeutralColor.neutral400.color

        return label
    }()

    var label7: UILabel = {
        var label = UILabel()
        label.text = "토"
        label.font = UIFont(name: "Pretendard-SemiBold", size: 10)
        label.textAlignment = .center
        label.textColor = DesignSystemAsset.NeutralColor.neutral400.color

        return label
    }()


    public init(spacing: CGFloat = 12) {
        super.init(frame: .zero)
        axis = .horizontal
        distribution = .fillEqually
        self.spacing = 12
        render()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func render() {
        [label1, label2, label3, label4, label5, label6, label7].forEach {
            addArrangedSubview($0)
        }

//        self.arrangedSubviews.forEach {
//            $0.snp.makeConstraints { make in
//                make.width.equalTo(39)
//            }
//        }

//        setCustomSpacing(12, after: label1)
//        setCustomSpacing(12, after: label2)
//        setCustomSpacing(12, after: label3)
//        setCustomSpacing(12, after: label4)
//        setCustomSpacing(12, after: label5)
//        setCustomSpacing(12, after: label6)
    }
}
