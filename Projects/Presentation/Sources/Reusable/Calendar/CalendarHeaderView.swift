//
//  CalendarHeaderView.swift
//  Presentation
//
//  Created by 강민성 on 9/27/24.
//  Copyright © 2024 com.team.snaplog. All rights reserved.
//

import UIKit
import DesignSystem

import SnapKit

public final class CalendarHeaderView: UIStackView {

    var text: String = "2024년 12월" {
        didSet {
            headerTitle.text = text
        }
    }

    var previousDisabled: Bool = false {
        didSet {
            let image = previousDisabled ? DesignSystemAsset.Image.frame56.image : DesignSystemAsset.Image.arrowLeft.image
            self.previousMonthButton.setImage(image, for: .normal)
        }
    }

    var nextDisabled: Bool = false {
        didSet {
            let image = previousDisabled ? DesignSystemAsset.Image.frame56.image : DesignSystemAsset.Image.arrowRight.image
            self.nextMonthButton.setImage(image, for: .normal)
        }
    }

    var headerTitle: UILabel = {
        var label = UILabel()
        label.font = Fonts.buttonLarge.font
        label.textColor = DesignSystemAsset.NeutralColor.black.color
        label.text = "2024년 12월"
        return label
    }()

    var previousMonthButton: UIButton = {
        var button = UIButton()
        button.setImage(DesignSystemAsset.Image.arrowLeft.image, for: .normal)
        return button
    }()

    var nextMonthButton: UIButton = {
        var button = UIButton()
        button.setImage(DesignSystemAsset.Image.arrowRight.image, for: .normal)
        return button
    }()

    public init(text: String) {
        self.headerTitle.text = text
        super.init(frame: .zero)
        self.distribution = .equalSpacing
        axis = .horizontal
        render()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    private func render() {
        [previousMonthButton, headerTitle, nextMonthButton].forEach {
            addArrangedSubview($0)
        }

        previousMonthButton.snp.makeConstraints { make in
            make.size.equalTo(16)
        }

        nextMonthButton.snp.makeConstraints { make in
            make.size.equalTo(16)
        }


        setCustomSpacing(30, after: previousMonthButton)
        setCustomSpacing(30, after: headerTitle)
    }
}
