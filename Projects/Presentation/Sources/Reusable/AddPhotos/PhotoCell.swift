//
//  PhotoCell.swift
//  Presentation
//
//  Created by 강민성 on 10/29/24.
//  Copyright © 2024 com.team.snaplog. All rights reserved.
//

import UIKit
import DesignSystem

import RxSwift
import RxCocoa
import ReactorKit
import SnapKit

public final class PhotoCell: UICollectionViewCell, ReactorKit.View {

    public typealias Reactor = PhotoCellReactor
    public var disposeBag: DisposeBag = DisposeBag()

    public var imageView: UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    public var checkImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(systemName: "checkmark.circle.fill")
        return imageView
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
        contentView.addSubViews([imageView])
//        imageView.addSubViews([checkImageView])

        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(1.5)
            make.leading.equalToSuperview().offset(1.5)
            make.trailing.equalToSuperview().offset(-1.5)
            make.bottom.equalToSuperview().offset(-1.5)
        }
    }
}

extension PhotoCell {
    public func bind(reactor: PhotoCellReactor) {

    }
}
