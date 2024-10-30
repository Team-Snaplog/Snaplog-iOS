//
//  CameraCell.swift
//  Presentation
//
//  Created by 강민성 on 10/29/24.
//  Copyright © 2024 com.team.snaplog. All rights reserved.
//

import UIKit
import DesignSystem

import SnapKit

public final class CameraCell: UICollectionViewCell {

    let cameraImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "camera")

        return imageView
    }()

    public override init(frame: CGRect) {
        super.init(frame: .zero)
        render()
        backgroundColor = DesignSystemAsset.NeutralColor.neutral100.color
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func render() {
        contentView.addSubViews([cameraImage])

        cameraImage.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(38)
        }
    }
}
