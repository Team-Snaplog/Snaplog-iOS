//
//  AddPhotosViewController.swift
//  Presentation
//
//  Created by 강민성 on 10/29/24.
//  Copyright © 2024 com.team.snaplog. All rights reserved.
//

import UIKit
import DesignSystem
import Utility
import Photos

import RxSwift
import RxCocoa
import RxFlow
import ReactorKit
import SnapKit

public final class AddPhotosViewController: BaseViewController<AddPhotosReactor>, ReactorKit.View {

    public typealias Reactor = AddPhotosReactor

    private var assets: [PHAsset] = []
    private var album: PHFetchResult<PHAsset>?
    private var currentIndex = 0
    private var isFetching = false

    var photoCollectionView: UICollectionView = {
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        var layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let screenWidth = UIScreen.main.bounds.width
        layout.itemSize = CGSize(width: screenWidth / 3, height: screenWidth / 3)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        collectionView.showsVerticalScrollIndicator = false
        collectionView.collectionViewLayout = layout
        collectionView.backgroundColor = .white
        collectionView.register(CameraCell.self, forCellWithReuseIdentifier: CameraCell.className)
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.className)
        return collectionView
    }()

    lazy var cameraPickerController: UIImagePickerController = {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.allowsEditing = true
        pickerController.sourceType = .camera
        return pickerController
    }()

    public init(with reactor: Reactor) {
        super.init(nibName: nil, bundle: nil)
        self.reactor = reactor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        fetchAlbum()
        photoCollectionView.delegate = self
        photoCollectionView.dataSource = self
        render()
    }

    public override func configureUI() {
        super.configureUI()

        let date = Date.now
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 M월 dd일"
        let text = dateFormatter.string(from: date)

        addNavigationTitleLabel(text)
        navigationTitleLabel.textColor = DesignSystemAsset.NeutralColor.black.color
        navigationTitleLabel.font = Fonts.titleMedium.font

        addBackButton()
        backButton.setImage(nil, for: .normal)
        backButton.setTitle("닫기", for: .normal)

        backButton.snp.updateConstraints { make in
            make.bottom.equalToSuperview().offset(-12)
            make.leading.equalToSuperview().offset(16)
        }

        backButton.setTitleColor(DesignSystemAsset.NeutralColor.neutral500.color, for: .normal)
        backButton.titleLabel?.font = Fonts.bodyMedium.font

        addRightButton()
        rightButton.setTitle("건너뛰기", for: .normal)
        rightButton.setTitleColor(DesignSystemAsset.NeutralColor.neutral500.color, for: .normal)
        rightButton.titleLabel?.font = Fonts.bodyMedium.font

    }

    private func render() {
        view.addSubViews([photoCollectionView])

        let screenWidth = UIScreen.main.bounds.width

        photoCollectionView.snp.makeConstraints { make in
            make.top.equalTo(navigationBarArea.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.size.equalTo(screenWidth)
        }
    }

    private func fetchAlbum() {
        let options = PHFetchOptions()
        options.includeHiddenAssets = false
        options.includeAssetSourceTypes = [.typeUserLibrary]
        options.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        album = PHAsset.fetchAssets(with: .image, options: options)
        continueFetch()
    }

    private func continueFetch() {
        guard let album = album else { return }
        guard !isFetching else { return }
        isFetching = true

        let endIndex = min(currentIndex + 50, album.count)

        if currentIndex < endIndex {
            let newAsset = (currentIndex..<endIndex).compactMap { album.object(at: $0) }
            assets.append(contentsOf: newAsset)
            currentIndex = endIndex

            DispatchQueue.main.async {
                self.photoCollectionView.reloadData()
                self.isFetching = false
            }
        } else {
            isFetching = false
        }
    }

    private func openCamera() {
        AVCaptureDevice.requestAccess(for: .video) { [weak self] isGranted in
            if isGranted {
                DispatchQueue.main.async {
                    self!.present(self!.cameraPickerController, animated: true)
                }
            } else {
                DispatchQueue.main.async {
                    self?.presentActionSheet(type: "카메라")
                }
            }
        }
    }

    private func presentActionSheet(type: String) {
            let alert = UIAlertController(
                title: "\(type) 접근권한 없음",
                message: "권한 필요하기떄문에 설정으로 이동시킬건데 어케할꺼임?",
                preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .default, handler: { _ in
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }))
            alert.addAction(UIAlertAction(title: "허용 안함", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }

}

extension AddPhotosViewController {
    public func bind(reactor: AddPhotosReactor) {
        bindAction(reactor: reactor)
        bindState(reactor: reactor)
    }

    private func bindAction(reactor: AddPhotosReactor) {
        photoCollectionView.rx.itemSelected
            .map { Reactor.Action.didTapPhoto($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }

    private func bindState(reactor: AddPhotosReactor) {
//        reactor.state.map { $0.isSelected }
//            .bind(to: photoCollectionView.rx.items(
//                cellIdentifier: PhotoCell.className,
//                cellType: PhotoCell.self)
//            ) { index, item, cell in
//                let cellReactor = PhotoCellReactor(item: item, indexPath: IndexPath(item: index, section: 0))
//                cell.reactor = cellReactor
//            }
//            .disposed(by: disposeBag)
    }
}

extension AddPhotosViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return assets.count + 1
    }
    
    public func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CameraCell.className,
                for: indexPath) as? CameraCell else { return UICollectionViewCell() }
            return cell
        }
        else {
            guard let cell = photoCollectionView.dequeueReusableCell(
                withReuseIdentifier: PhotoCell.className,
                for: indexPath) as? PhotoCell else { return UICollectionViewCell() }
            let asset = assets[indexPath.item - 1]

            let imageManager = PHImageManager.default()
            let options = PHImageRequestOptions()
            let screenWidth = UIScreen.main.bounds.width
            let targetSize = CGSize(width: screenWidth / 3, height: screenWidth / 3)

            imageManager.requestImage(for: asset,
                                      targetSize: targetSize,
                                      contentMode: .aspectFill,
                                      options: options) { (image, _) in
                cell.imageView.image = image
            }
            return cell
        }
    }

    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == 0 {
            openCamera()
        } else {
            if let cell = photoCollectionView.cellForItem(at: indexPath) as? PhotoCell {
                cell.imageView.isHidden = true
            }
        }
    }
}

extension AddPhotosViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    public func imagePickerController(_ picker: UIImagePickerController,
                                      didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        dismiss(animated: true, completion: nil)

        if let image = info[.originalImage] as? UIImage {
            var placeHolderAsset: PHObjectPlaceholder?

            PHPhotoLibrary.shared().performChanges({
                let request = PHAssetChangeRequest.creationRequestForAsset(from: image)
                placeHolderAsset = request.placeholderForCreatedAsset
            }) { success, error in
                if success, let assetId = placeHolderAsset?.localIdentifier {
                    let fetchResult = PHAsset.fetchAssets(withLocalIdentifiers: [assetId], options: nil)

                    if let newAsset = fetchResult.firstObject {
                        DispatchQueue.main.async {
                            self.assets.insert(newAsset, at: 0)
                            self.photoCollectionView.insertItems(at: [IndexPath(item: 1, section: 0)])
                        }
                    }
                } else if let error = error {
                    fatalError()
                }
            }
        }
    }
}

extension AddPhotosViewController: UIScrollViewDelegate {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        let screenWidth = UIScreen.main.bounds.width

        if offsetY > contentHeight - height - (screenWidth / 3) {
            continueFetch()
        }
    }
}
