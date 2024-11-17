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
import Domain

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
    private var selectedIndexPath: IndexPath?

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

    var selectTopicLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = Fonts.titleSmall.font
        label.textColor = DesignSystemAsset.NeutralColor.black.color
        label.text = "스냅 주제 선택"
        return label
    }()

    var topicsCollectionView: UICollectionView = {
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        var layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 12
        layout.itemSize = CGSize(width: 100, height: 124)
        collectionView.collectionViewLayout = layout
        collectionView.backgroundColor = .white
        collectionView.register(
            SelectTopicCollectionViewCell.self,
            forCellWithReuseIdentifier: SelectTopicCollectionViewCell.className)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false

        return collectionView
    }()

    var addSnapButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        button.isEnabled = false
        button.backgroundColor = DesignSystemAsset.NeutralColor.neutral300.color
        button.setTitleColor(DesignSystemAsset.NeutralColor.neutral500.color, for: .normal)
        button.setTitle("스냅 기록 완료", for: .normal)
        button.titleLabel?.font = Fonts.buttonMedium.font
        return button
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
        topicsCollectionView.delegate = self
        render()
    }

    public override func configureUI() {
        super.configureUI()

        let date = Date.now
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 M월 dd일"
        let text = dateFormatter.string(from: date)

        addNavigationTitleWithButton(text, UIImage(systemName: "chevron.down"))
        centerButton.tintColor = DesignSystemAsset.NeutralColor.neutral500.color
        centerLabel.textColor = DesignSystemAsset.NeutralColor.black.color
        centerLabel.font = Fonts.titleMedium.font

        centerButton.addTarget(self, action: #selector(presentDatePicker), for: .touchUpInside)

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
        view.addSubViews([photoCollectionView, selectTopicLabel, topicsCollectionView, addSnapButton])

        let screenWidth = UIScreen.main.bounds.width

        photoCollectionView.snp.makeConstraints { make in
            make.top.equalTo(navigationBarArea.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.size.equalTo(screenWidth)
        }

        selectTopicLabel.snp.makeConstraints { make in
            make.top.equalTo(photoCollectionView.snp.bottom).offset(42)
            make.leading.equalToSuperview().offset(20).priority(.high)
        }

        topicsCollectionView.snp.makeConstraints { make in
            make.top.equalTo(selectTopicLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(124)
        }

        addSnapButton.snp.makeConstraints { make in
//            make.top.equalTo(topicsCollectionView.snp.bottom).offset(51)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-32)
            make.height.equalTo(56)
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

    @objc private func presentDatePicker() {
        let datePickerViewController = ModalDatePickerViewController()
        datePickerViewController.modalPresentationStyle = .pageSheet
        datePickerViewController.view?.backgroundColor = UIColor.white.withAlphaComponent(1.0)

        let detent = UISheetPresentationController.Detent.custom(identifier: .medium) { _ in
            return 237
        }

        if let sheet = datePickerViewController.presentationController as? UISheetPresentationController {
            sheet.detents = [detent]
            sheet.prefersGrabberVisible = false
        }

        datePickerViewController.selectedDate = { [weak self] selectedDate in
            self?.reactor?.action.onNext(.didDateSelected(selectedDate))
        }

        present(datePickerViewController, animated: true, completion: nil)
    }

}

extension AddPhotosViewController {
    public func bind(reactor: AddPhotosReactor) {
        bindAction(reactor: reactor)
        bindState(reactor: reactor)
    }

    private func bindAction(reactor: AddPhotosReactor) {
        rx.viewWillAppear
            .map { Reactor.Action.viewWillAppear }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        addSnapButton.rx.tap
            .map { Reactor.Action.didTapAddSnapButton }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }

    private func bindState(reactor: AddPhotosReactor) {

        reactor.state.map { $0.topics }
            .distinctUntilChanged()
            .bind(to: topicsCollectionView.rx.items(
                cellIdentifier: SelectTopicCollectionViewCell.className,
                cellType: SelectTopicCollectionViewCell.self)
            ) { _, item, cell in
                let cellReactor = SelectTopicCollectionViewCellReactor(item: item)
                cell.reactor = cellReactor
            }
            .disposed(by: disposeBag)

        reactor.state.map { $0.isAddSnapEnabled }
            .distinctUntilChanged()
            .withUnretained(self)
            .bind(onNext: { viewController, isEnabled in
                if isEnabled {
                    viewController.addSnapButton.backgroundColor = DesignSystemAsset.AzureColor.azure500.color
                    viewController.addSnapButton.setTitleColor(.white, for: .normal)
                    viewController.addSnapButton.isEnabled = true
                } else {
                    viewController.addSnapButton.isEnabled = false
                    viewController.addSnapButton.backgroundColor = DesignSystemAsset.NeutralColor.neutral300.color
                    viewController.addSnapButton.setTitleColor(DesignSystemAsset.NeutralColor.neutral500.color, for: .normal)
                }
            })
            .disposed(by: disposeBag)

        reactor.state.map { $0.date }
            .distinctUntilChanged()
            .withUnretained(self)
            .bind(onNext: { viewController, date in
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy년 M월 dd일"
                let text = dateFormatter.string(from: date)
                viewController.centerLabel.text = text
            })
            .disposed(by: disposeBag)
    }
}

extension AddPhotosViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard collectionView == photoCollectionView else { return 0 }
        return assets.count + 1
    }

    public func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard collectionView == photoCollectionView else { return UICollectionViewCell() }
            if indexPath.item == 0 {
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: CameraCell.className,
                    for: indexPath) as? CameraCell else { return UICollectionViewCell() }
                return cell
            } else {
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

        if collectionView == photoCollectionView {
            if indexPath.item == 0 {
                openCamera()
            } else {
                if let cell = photoCollectionView.cellForItem(at: indexPath) as? PhotoCell,
                   let image = cell.imageView.image {
                    let isPhotoSelected = reactor?.currentState.photos.contains(image) ?? false

                    if isPhotoSelected {
                        reactor?.action.onNext(.deSelectImage(image))
                    } else {
                        reactor?.action.onNext(.selectImage(image))
                    }
                    cell.checkImageView.isHidden.toggle()
                }
            }
        } else {

            if let cell = topicsCollectionView.cellForItem(at: indexPath) as? SelectTopicCollectionViewCell,
               let topic = cell.reactor?.currentState.topic {
                self.reactor?.action.onNext(.didSelectTopic(topic))

                if let previousIndexPath = selectedIndexPath,
                   let previousCell = topicsCollectionView.cellForItem(at: previousIndexPath) as?
                    SelectTopicCollectionViewCell {
                    previousCell.topicEmojiLabel.layer.borderColor = UIColor.clear.cgColor
                }

                cell.topicEmojiLabel.layer.borderColor = DesignSystemAsset.AzureColor.azure500.color.cgColor

                selectedIndexPath = indexPath
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

extension AddPhotosViewController: UICollectionViewDelegateFlowLayout {
    public func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int) -> UIEdgeInsets {
            guard collectionView == topicsCollectionView else { return UIEdgeInsets() }
            return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
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
