//
//  TopicCollectionViewCell.swift
//  Presentation
//
//  Created by 강민성 on 9/19/24.
//  Copyright © 2024 com.team.snaplog. All rights reserved.
//

import UIKit
import DesignSystem

import RxSwift
import RxCocoa
import RxFlow
import RxRelay
import ReactorKit
import SnapKit

public final class TopicCollectionViewCell: UICollectionViewCell, ReactorKit.View {

    public typealias Reactor = TopicCollectionViewCellReactor
    public var disposeBag: DisposeBag = DisposeBag()

    var topicEmojiLabel: UILabel = {
        var label = UILabel()
        label.clipsToBounds = true
        label.backgroundColor = DesignSystemAsset.NeutralColor.neutral100.color
        label.layer.cornerRadius = 30
        label.layer.borderWidth = 2
        label.layer.borderColor = UIColor.clear.cgColor
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 30)
        label.textColor = DesignSystemAsset.NeutralColor.neutral500.color
        return label
    }()

    var titleLabel: UILabel = {
        var label = UILabel()
        label.font = Fonts.labelMedium.font
        label.textColor = DesignSystemAsset.NeutralColor.neutral500.color
        label.textAlignment = .center
        return label
    }()

    public override init(frame: CGRect) {
        super.init(frame: .zero)
        render()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func render() {
        addSubViews([topicEmojiLabel, titleLabel])

        topicEmojiLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.size.equalTo(60)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(topicEmojiLabel.snp.bottom).offset(4)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension TopicCollectionViewCell {
    public func bind(reactor: TopicCollectionViewCellReactor) {
        bindAction(reactor: reactor)
        bindState(reactor: reactor)
    }

    private func bindAction(reactor: TopicCollectionViewCellReactor) {

    }

    private func bindState(reactor: TopicCollectionViewCellReactor) {
        reactor.state.map { $0.emoji }
            .distinctUntilChanged()
            .withUnretained(self)
            .bind(onNext: { cell, emoji in
                cell.topicEmojiLabel.text = emoji
            })
            .disposed(by: disposeBag)

        reactor.state.map { $0.title }
            .distinctUntilChanged()
            .withUnretained(self)
            .bind(onNext: { cell, title in
                cell.titleLabel.text = title
            })
            .disposed(by: disposeBag)
    }
}
