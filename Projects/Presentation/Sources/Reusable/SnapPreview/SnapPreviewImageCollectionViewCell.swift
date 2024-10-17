//
//  SnapPreviewImageCollectionViewCell.swift
//  Presentation
//
//  Created by 강민성 on 10/1/24.
//  Copyright © 2024 com.team.snaplog. All rights reserved.
//

import UIKit
import DesignSystem

import RxSwift
import RxCocoa
import SnapKit
import ReactorKit

public final class SnapPreviewImageCollectionViewCell: UICollectionViewCell, ReactorKit.View {

    public typealias Reactor = SnapPreviewImageCollectionViewCellReactor
    public var disposeBag: DisposeBag = DisposeBag()

    var imageView: UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    public override init(frame: CGRect) {
        super.init(frame: .zero)
        layer.cornerRadius = 6
        backgroundColor = .white
        render()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func render() {
        addSubViews([imageView])
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension SnapPreviewImageCollectionViewCell {
    public func bind(reactor: SnapPreviewImageCollectionViewCellReactor) {
        reactor.state.map { $0.photos }
            .distinctUntilChanged()
            .withUnretained(self)
            .bind(onNext: { view, photos in
                view.imageView.image = photos
            })
            .disposed(by: disposeBag)


    }
}
