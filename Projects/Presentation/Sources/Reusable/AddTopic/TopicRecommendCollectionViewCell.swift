//
//  TopicRecommendCollectionViewCell.swift
//  Presentation
//
//  Created by 강민성 on 10/19/24.
//  Copyright © 2024 com.team.snaplog. All rights reserved.
//

import UIKit
import Domain
import DesignSystem

import RxSwift
import RxCocoa
import ReactorKit
import SnapKit

public final class TopicRecommendCollectionViewCell: UICollectionViewCell, ReactorKit.View {

    public typealias Reactor = TopicRecommendCollectionViewCellReactor
    public var disposeBag: DisposeBag = DisposeBag()

    var emojiLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()

    var topicTitleLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Fonts.labelMedium.font
        label.numberOfLines = 1
        label.textColor = DesignSystemAsset.NeutralColor.black.color
        label.textAlignment = .center
        return label
    }()

    public override init(frame: CGRect) {
        super.init(frame: .zero)
        layer.cornerRadius = 17
        layer.borderWidth = 1
        layer.borderColor = DesignSystemAsset.AzureColor.azure100.color.cgColor
//        layer.borderColor = DesignSystemAsset.AzureColor.azure50.color.cgColor
        backgroundColor = .white
        render()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func render() {
        contentView.addSubViews([emojiLabel, topicTitleLabel])

        emojiLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.height.equalTo(24)
            make.width.equalTo(24)
            make.leading.equalToSuperview().offset(10)
        }

        topicTitleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.height.equalTo(16)
            make.leading.equalTo(emojiLabel.snp.trailing).offset(5)
            make.trailing.equalToSuperview().offset(-10)
        }
    }
}

extension TopicRecommendCollectionViewCell {
    public func bind(reactor: TopicRecommendCollectionViewCellReactor) {
        reactor.state.map { $0.emoji }
            .distinctUntilChanged()
            .withUnretained(self)
            .bind(onNext: { cell, emoji in
                cell.emojiLabel.text = emoji
            })
            .disposed(by: disposeBag)

        reactor.state.map { $0.title }
            .distinctUntilChanged()
            .withUnretained(self)
            .bind(onNext: { cell, title in
                cell.topicTitleLabel.text = title
            })
            .disposed(by: disposeBag)
    }
}
