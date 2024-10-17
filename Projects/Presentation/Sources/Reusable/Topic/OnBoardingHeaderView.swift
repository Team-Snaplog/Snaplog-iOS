//
//  OnBoardingHeaderView.swift
//  Presentation
//
//  Created by 강민성 on 9/19/24.
//  Copyright © 2024 com.team.snaplog. All rights reserved.
//

import UIKit
import DesignSystem
import Utility

import SnapKit

public final class OnBoardingHeaderView: UIStackView {

    var topicCollectionView: UICollectionView = {
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(
            TopicCollectionViewCell.self,
            forCellWithReuseIdentifier: TopicCollectionViewCell.className)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.semanticContentAttribute = .forceRightToLeft
        collectionView.backgroundColor = .white

        var layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 60, height: 80)
        layout.minimumInteritemSpacing = 12
        layout.minimumLineSpacing = 12
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)

        collectionView.collectionViewLayout = layout
        return collectionView
    }()

    let separatorLine: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = DesignSystemAsset.NeutralColor.neutral200.color
        return view
    }()

    var settingButton: UIButton = {
        var config = UIButton.Configuration.plain()

        var title = AttributedString.init("설정")
        title.font = Fonts.labelMedium.font

        config.attributedTitle = title
        config.image = DesignSystemAsset.Image.frame173.image
        config.baseForegroundColor = DesignSystemAsset.NeutralColor.black.color
        config.imagePadding = 4
        config.imagePlacement = .top
        config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 20)
        var button = UIButton(configuration: config)
        return button
    }()

//    func makeTrailingBorder(color: UIColor?, borderWidth: CGFloat) {
//        // 셀기준 탑 12 바텀 32
//        // 이모지기준 탑 12 바텀 12
//        // 두께 1
//        let border = UIView()
//        border.backgroundColor = color
//        border.autoresizingMask = [.flexibleHeight, .flexibleLeftMargin]
//        border.frame = CGRect(x: frame.width - borderWidth, y: 12, width: borderWidth, height: frame.height - 32)
//        topicCollectionView.addSubview(border)
//    }

    public override init(frame: CGRect) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        axis = .horizontal
        backgroundColor = .white
        render()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    private func render() {
//        makeTrailingBorder(color: DesignSystemAsset.NeutralColor.neutral200.color, borderWidth: 1)

        [topicCollectionView, separatorLine, settingButton].forEach {
            addArrangedSubview($0)
        }

        setCustomSpacing(0, after: topicCollectionView)
        setCustomSpacing(19, after: separatorLine)

        separatorLine.snp.makeConstraints { make in
            make.width.equalTo(1)
            make.height.equalToSuperview()
        }
//        setCustomSpacing(12, after: topicCollectionView)

//        topicCollectionView.snp.makeConstraints { make in
//            make.top.bottom.equalToSuperview()
//            make.leading.equalToSuperview().offset(20)
//        }
//
//        settingButton.snp.makeConstraints { make in
//            make.top.bottom.equalToSuperview()
//            make.leading
//        }

    }
}
