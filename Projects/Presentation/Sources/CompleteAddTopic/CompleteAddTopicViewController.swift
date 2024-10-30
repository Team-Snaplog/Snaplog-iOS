//
//  CompleteAddTopicViewController.swift
//  Presentation
//
//  Created by 강민성 on 10/24/24.
//  Copyright © 2024 com.team.snaplog. All rights reserved.
//

import UIKit
import Domain
import DesignSystem
import Utility
import AVFoundation
import PhotosUI

import RxSwift
import RxCocoa
import ReactorKit
import SnapKit

public final class CompleteAddTopicViewController: BaseViewController<CompleteAddTopicReactor>, ReactorKit.View {

    public typealias Reactor = CompleteAddTopicReactor

    var headerLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "짝짝짝! 👏"
        label.font = Fonts.titleLarge.font
        label.numberOfLines = 2
        label.textColor = DesignSystemAsset.NeutralColor.black.color
        label.textAlignment = .center
        label.backgroundColor = .clear
        return label
    }()

    var emojiLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.text = "🚯"
        label.font = .systemFont(ofSize: 78)
        label.backgroundColor = DesignSystemAsset.NeutralColor.neutral100.color
        label.layer.cornerRadius = 80
        label.textAlignment = .center
        return label
    }()

    var titleLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Fonts.buttonMedium.font
        label.text = "text"
        label.textColor = DesignSystemAsset.NeutralColor.black.color
        label.textAlignment = .center
        label.backgroundColor = .clear
        return label
    }()

    var takePhotoButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.setTitle("사진으로 기록하기", for: .normal)
        button.titleLabel?.font = Fonts.buttonMedium.font
        button.setTitleColor(DesignSystemAsset.AzureColor.azure500.color, for: .normal)
        button.backgroundColor = .white
        button.layer.borderColor = DesignSystemAsset.AzureColor.azure500.color.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 10
        button.isHidden = true
        button.isEnabled = false
        button.alpha = 0.0
        return button
    }()

    var goToAlbumButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.setTitle("앨범에서 기록하기", for: .normal)
        button.titleLabel?.font = Fonts.buttonMedium.font
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = DesignSystemAsset.AzureColor.azure500.color
        button.layer.cornerRadius = 10
        button.isHidden = true
        button.isEnabled = false
        button.alpha = 0.0
        return button
    }()

    var laterButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("나중에 기록할게요.", for: .normal)
        button.setTitleColor(DesignSystemAsset.NeutralColor.neutral500.color, for: .normal)
        button.titleLabel?.font = UIFont(name: "Pretendard-Regular", size: 14)
        button.backgroundColor = .clear
        button.isHidden = true
        button.isEnabled = false
        button.alpha = 0.0
        return button
    }()

    lazy var cameraPickerController: UIImagePickerController = {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.allowsEditing = true
        pickerController.sourceType = .camera
        return pickerController
    }()

    lazy var albumPickerController: PHPickerViewController = {
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 3
        configuration.filter = .images
        let pickerController = PHPickerViewController(configuration: configuration)
        pickerController.delegate = self
        return pickerController
    }()

    public init(with reactor: CompleteAddTopicReactor) {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        render()
        setRx()
    }

    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            self.animate()
        }
    }

    public override func configureUI() {
        super.configureUI()
    }

    private func render() {
        view.addSubViews([headerLabel, emojiLabel, titleLabel, takePhotoButton, goToAlbumButton, laterButton])

        headerLabel.snp.makeConstraints { make in
            make.top.equalTo(navigationBarArea.snp.bottom).offset(94)
            make.centerX.equalToSuperview()
            make.height.equalTo(28)
            make.width.equalTo(98)
        }

        emojiLabel.snp.makeConstraints { make in
            make.top.equalTo(headerLabel.snp.top).offset(96)
            make.centerX.equalToSuperview()
            make.size.equalTo(160)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(emojiLabel.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
            make.height.equalTo(32)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(20)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-20)
        }

        laterButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
            make.height.equalTo(20)
            make.centerX.equalToSuperview()
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(20)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-20)
        }

        goToAlbumButton.snp.makeConstraints { make in
            make.bottom.equalTo(laterButton.snp.top).offset(-16)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(20)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-20)
            make.height.equalTo(56)
            make.centerX.equalToSuperview()
        }

        takePhotoButton.snp.makeConstraints { make in
            make.bottom.equalTo(goToAlbumButton.snp.top).offset(-12)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(20)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-20)
            make.height.equalTo(56)
            make.centerX.equalToSuperview()
        }
    }

    private func setRx() {
        takePhotoButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                self?.openCamera()
            })
            .disposed(by: disposeBag)

        goToAlbumButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                self?.openAlbum()
            })
            .disposed(by: disposeBag)
    }

    private func animate() {
        UIView.animate(withDuration: 0.4, animations: {
            self.headerLabel.alpha = 0.0
        }) { _ in
            self.headerLabel.snp.updateConstraints { make in
                make.width.equalTo(188)
                make.height.equalTo(56)
            }
            self.headerLabel.text = "주제를 생성했어요!\n첫 기록을 남겨보세요."
            self.laterButton.isHidden = false
            self.takePhotoButton.isHidden = false
            self.goToAlbumButton.isHidden = false

            UIView.animate(withDuration: 0.4) {
                self.headerLabel.alpha = 1.0
                self.laterButton.alpha = 1.0
                self.takePhotoButton.alpha = 1.0
                self.goToAlbumButton.alpha = 1.0
            }

            self.laterButton.isEnabled = true
            self.takePhotoButton.isEnabled = true
            self.goToAlbumButton.isEnabled = true
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

    private func openAlbum() {
        PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
            switch status {
            case .authorized:
                self.reactor?.action.onNext(.didTapGoToAlbumButton)

            default:
                DispatchQueue.main.async {
                    self.presentActionSheet(type: "앨범")
                }
            }
        }
    }

    private func presentActionSheet(type: String) {
            let alert = UIAlertController(title: "\(type) 접근권한 없음", message: "권한 필요하기떄문에 설정으로 이동시킬건데 어케할꺼임?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .default, handler: { _ in
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }))
            alert.addAction(UIAlertAction(title: "허용 안함", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
}

extension CompleteAddTopicViewController {
    public func bind(reactor: CompleteAddTopicReactor) {
        bindAction(reactor: reactor)
        bindState(reactor: reactor)
    }

    private func bindAction(reactor: CompleteAddTopicReactor) {
        laterButton.rx.tap
            .map { Reactor.Action.didTapLaterButton }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }

    private func bindState(reactor: CompleteAddTopicReactor) {

        reactor.state.map { $0.title }
            .distinctUntilChanged()
            .withUnretained(self)
            .bind(onNext: { viewController, title in
                viewController.titleLabel.text = title
            })
            .disposed(by: disposeBag)

        reactor.state.map { $0.emoji }
            .distinctUntilChanged()
            .withUnretained(self)
            .bind(onNext: { viewController, emoji in
                viewController.emojiLabel.text = emoji
            })
            .disposed(by: disposeBag)
    }
}

extension CompleteAddTopicViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    public func imagePickerController(_ picker: UIImagePickerController,
                                      didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        let imageData = NSData(data: image.jpegData(compressionQuality: 1)!)
        let imageSize: Int = imageData.count
        print(imageSize)
    }
}

extension CompleteAddTopicViewController: PHPickerViewControllerDelegate {
    public func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        let itemProvider = results[0].itemProvider
        if itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { image, error in
                if let image = image as? UIImage {
                    let imageData = NSData(data: image.jpegData(compressionQuality: 1)!)

                    var imageSize: Int = imageData.count
                    print(imageSize)
                }
            }
        }
    }
}
