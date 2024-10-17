//
//  CalendarViewDayCell.swift
//  Presentation
//
//  Created by 강민성 on 9/27/24.
//  Copyright © 2024 com.team.snaplog. All rights reserved.
//

import UIKit
import DesignSystem
import Domain

import SnapKit

public final class CalendarViewDayCell: UICollectionViewCell {

    private var dateType: DateType = .isDefault

    var backgroundImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
//        imageView.image = DesignSystemAsset.Image.frame56.image

        return imageView
    }()

    var dateLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Pretendard-SemiBold", size: 18)
        label.textAlignment = .center
        label.layer.cornerRadius = 15
        label.layer.borderWidth = 1
        return label
    }()

    override public var isSelected: Bool {
        didSet {
            self.setUp(for: dateType, isSelected: isSelected)
        }
    }

    public override init(frame: CGRect) {
        super.init(frame: .zero)
//        dateLabel.layer.borderColor = UIColor.red.cgColor
//        dateLabel.layer.borderWidth = 4
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(_ day: String, type: DateType) {
        self.dateLabel.text = day
        self.dateType = type

        switch type {
        case .isDisabled:
            self.isUserInteractionEnabled = false

        default:
            self.isUserInteractionEnabled = true
        }

        setUp(for: type, isSelected: isSelected)
    }
}

extension CalendarViewDayCell {
    func setUp(for type: DateType, isSelected: Bool) {
        contentView.addSubViews([backgroundImageView])
        backgroundImageView.addSubViews([dateLabel])

        backgroundImageView.layer.cornerRadius = 6
        backgroundImageView.layer.borderWidth = 2
        backgroundImageView.layer.borderColor = UIColor.red.cgColor

        dateLabel.textColor = textColor(for: type, isSelected: isSelected)
        dateLabel.layer.borderColor = borderColor(for: type, isSelected: isSelected)
        backgroundImageView.layer.borderColor = borderColor(for: type, isSelected: isSelected)

        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        dateLabel.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
            make.size.equalTo(30)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }

    func textColor(for type: DateType, isSelected: Bool) -> UIColor {
        switch type {
        case .isWritten:
            return .white

        case .isDefault, .isToday:
            return DesignSystemAsset.NeutralColor.black.color

        case .isDisabled:
            return .gray
        }
    }

    func borderColor(for type: DateType, isSelected: Bool) -> CGColor {
        switch type {
        case .isToday:
            return DesignSystemAsset.AzureColor.azure500.color.cgColor

        case .isWritten:
            return isSelected ? DesignSystemAsset.NeutralColor.neutral500.color.cgColor : UIColor.clear.cgColor

        case .isDefault, .isDisabled:
            return UIColor.clear.cgColor
        }
    }
}
