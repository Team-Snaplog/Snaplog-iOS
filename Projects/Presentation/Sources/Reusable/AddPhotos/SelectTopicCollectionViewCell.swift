//
//  SelectTopicCollectionViewCell.swift
//  Presentation
//
//  Created by 강민성 on 11/12/24.
//  Copyright © 2024 com.team.snaplog. All rights reserved.
//

import UIKit
import DesignSystem

import RxSwift
import RxCocoa
import ReactorKit
import SnapKit

public final class SelectTopicCollectionViewCell: UICollectionViewCell, ReactorKit.View {

    public typealias Reactor = SelectTopicCollectionViewCellReactor
    public var disposeBag: DisposeBag = DisposeBag()

    var topicEmojiLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.font = .systemFont(ofSize: 50)
        label.backgroundColor = DesignSystemAsset.NeutralColor.neutral100.color
        label.layer.cornerRadius = 50
        label.layer.borderWidth = 2
        label.layer.borderColor = UIColor.clear.cgColor
        label.textAlignment = .center
        return label
    }()

    var titleLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Fonts.labelMedium.font
        label.textColor = DesignSystemAsset.NeutralColor.black.color
        label.textAlignment = .center
        return label
    }()

    public override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = .white
        render()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func render() {
        contentView.addSubViews([topicEmojiLabel, titleLabel])

        topicEmojiLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(topicEmojiLabel.snp.bottom).offset(8)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension SelectTopicCollectionViewCell {
    public func bind(reactor: SelectTopicCollectionViewCellReactor) {
        reactor.state.map { $0.title }
            .distinctUntilChanged()
            .withUnretained(self)
            .bind(onNext: { cell, title in
                cell.titleLabel.text = title
            })
            .disposed(by: disposeBag)

        reactor.state.map { $0.emoji }
            .distinctUntilChanged()
            .withUnretained(self)
            .bind(onNext: { cell, emoji in
                cell.topicEmojiLabel.text = emoji
            })
            .disposed(by: disposeBag)
    }
}
