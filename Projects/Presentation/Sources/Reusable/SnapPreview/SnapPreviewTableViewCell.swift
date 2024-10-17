//
//  SnapPreviewTableViewCell.swift
//  Presentation
//
//  Created by 강민성 on 10/1/24.
//  Copyright © 2024 com.team.snaplog. All rights reserved.
//

import UIKit
import DesignSystem
import Utility

import RxSwift
import RxCocoa
import SnapKit
import ReactorKit

public final class SnapPreviewTableViewCell: UITableViewCell, ReactorKit.View {

    public typealias Reactor = SnapPreviewTableViewCellReactor
    public var disposeBag: DisposeBag = DisposeBag()

    var dateLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = DesignSystemAsset.NeutralColor.black.color
        label.font = UIFont(name: "Pretendard-Bold", size: 12)
        return label
    }()

    var bodyLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = DesignSystemAsset.NeutralColor.black.color
        label.font = UIFont(name: "Pretendard-Regular", size: 14)
        label.numberOfLines = 2
        return label
    }()

    var imageCollectionView: UICollectionView = {
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(SnapPreviewImageCollectionViewCell.self, forCellWithReuseIdentifier: SnapPreviewImageCollectionViewCell.className)
        collectionView.isScrollEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .white

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 108, height: 108)
        layout.minimumLineSpacing = 6
        layout.minimumInteritemSpacing = 6

        collectionView.collectionViewLayout = layout
        return collectionView
    }()

    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white
        render()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func render() {
        contentView.addSubViews([dateLabel, bodyLabel, imageCollectionView])

        dateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(20).priority(.high)
            make.trailing.equalToSuperview().priority(.low)
            make.height.equalTo(16)
        }

//        bodyLabel.snp.makeConstraints { make in
//            make.top.equalTo(dateLabel.snp.bottom).offset(8)
//            make.leading.equalToSuperview().offset(20)
//            make.trailing.equalToSuperview().offset(-20)
//            make.height.equalTo(40)
//        }

//        imageCollectionView.snp.makeConstraints { make in
//            make.top.equalTo(bodyLabel.snp.bottom).offset(8)
//            make.bottom.equalToSuperview().offset(-34)
//            make.leading.equalToSuperview().offset(20)
//            make.trailing.equalToSuperview()
//        }
    }
}

extension SnapPreviewTableViewCell {
    public func bind(reactor: SnapPreviewTableViewCellReactor) {
        bindAction(reactor: reactor)
        bindState(reactor: reactor)
    }

    private func bindAction(reactor: SnapPreviewTableViewCellReactor) {
        
    }

    private func bindState(reactor: SnapPreviewTableViewCellReactor) {
        reactor.state.map { $0.date }
            .distinctUntilChanged()
            .withUnretained(self)
            .bind(onNext: { cell, date in
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy년 MM월 dd일"
                cell.dateLabel.text = dateFormatter.string(from: date)
            })
            .disposed(by: disposeBag)

        reactor.state.map { $0.body }
            .distinctUntilChanged()
            .withUnretained(self)
            .bind(onNext: { cell, body in
                if let bodyText = body {
                    cell.bodyLabel.isHidden = false
                    cell.bodyLabel.text = body

//                    cell.dateLabel.snp.remakeConstraints { make in
//                        make.bottom.equalTo(cell.bodyLabel.snp.top).offset(-8)
//                    }

                    cell.bodyLabel.snp.remakeConstraints { make in
                        make.top.equalTo(cell.dateLabel.snp.bottom).offset(8)
                        make.leading.equalToSuperview().offset(20)
                        make.trailing.equalToSuperview().offset(-20)
                        make.bottom.equalTo(cell.imageCollectionView.snp.top).offset(-8)
                        make.height.equalTo(48)
                    }

                    cell.imageCollectionView.snp.remakeConstraints { make in
                        make.top.equalTo(cell.bodyLabel.snp.bottom).offset(8)
                        make.leading.equalToSuperview().offset(20)
                        make.trailing.equalToSuperview().offset(-20)
                        make.bottom.equalToSuperview().offset(-34)
                        make.height.equalTo(108)
                    }
                } else {
                    cell.bodyLabel.isHidden = true

                    cell.dateLabel.snp.remakeConstraints { make in
                        make.top.equalToSuperview().offset(20)
                        make.leading.equalToSuperview().offset(20).priority(.high)
                        make.trailing.equalToSuperview().priority(.low)
                        make.height.equalTo(16)
                        make.bottom.equalTo(cell.imageCollectionView.snp.top).offset(-8)
                    }

                    cell.imageCollectionView.snp.remakeConstraints { make in
                        make.top.equalTo(cell.dateLabel.snp.bottom).offset(8)
                        make.leading.equalToSuperview().offset(20)
                        make.trailing.equalToSuperview().offset(-20)
                        make.bottom.equalToSuperview().offset(-34)
                        make.height.equalTo(108)
                    }
                }
            })
            .disposed(by: disposeBag)

        reactor.state.map { $0.photos }
            .distinctUntilChanged()
            .bind(to: imageCollectionView.rx.items(
                cellIdentifier: SnapPreviewImageCollectionViewCell.className,
                cellType: SnapPreviewImageCollectionViewCell.self)) { indexPath, item, cell in
                    let cellReactor = SnapPreviewImageCollectionViewCellReactor(item: item)
                    cell.reactor = cellReactor
                    //                let cellReactor = SnapPreviewImageCollectionViewCellReactor(item: item)
                    //                cell.reactor = cellReactor
                }
                .disposed(by: disposeBag)
    }
}
