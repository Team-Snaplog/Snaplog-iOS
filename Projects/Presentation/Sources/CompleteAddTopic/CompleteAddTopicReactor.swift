//
//  CompleteAddTopicReactor.swift
//  Presentation
//
//  Created by 강민성 on 10/24/24.
//  Copyright © 2024 com.team.snaplog. All rights reserved.
//

import Foundation
import Domain
import Core
import Photos

import RxSwift
import RxCocoa
import RxFlow
import ReactorKit

public final class CompleteAddTopicReactor: BaseReactor {

    public var steps = PublishRelay<Step>()
    public let initialState: State
    private let disposeBag: DisposeBag = DisposeBag()

    public var title: String
    public var emoji: String

    public enum Action {
        case viewWillAppear
        case didTapTakePhotoButton
        case didTapGoToAlbumButton
        case didTapLaterButton
        case setCameraAuthType(CameraAuthType)
        case setPhotoAuthType(PhotoAuthType)
    }

    public enum Mutation {
        case setEmoji
        case setTitle
    }

    public struct State {
        var title: String
        var emoji: String
        var cameraAuthType: CameraAuthType = .unknown
    }

    public init(title: String, emoji: String) {
        self.initialState = State(title: title, emoji: emoji)
        self.title = title
        self.emoji = emoji
    }

    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .didTapTakePhotoButton:
            requestCameraAuthorization()
            return .empty()

        case .didTapGoToAlbumButton:
            steps.accept(CompleteAddTopicStep.addPhotosViewIsRequired)
            return .empty()

        case .setCameraAuthType(let type):
//            if type == .authorized {
//                self.steps.accept(AddTopicStep.cameraViewIsRequired)
//                return .empty()
//            } else {
//                self.steps.accept(AddTopicStep.presentDeniedAlert(target: "카메라"))
//                return .empty()
//            }
            return .empty()

        default:
            return .empty()
        }
    }

//    public func reduce(state: State, mutation: Mutation) -> State {
//        var state = state
//
//        switch mutation {
//        case .setEmoji:
//            state.emoji = currentState.emoji
//
//        case .setTitle:
//            state.title = currentState.title
//        }
//
//        return state
//    }
    public func requestCameraAuthorization() {
        DispatchQueue.main.async {
            switch AVCaptureDevice.authorizationStatus(for: .video) {
            case .authorized:
                self.action.onNext(.setCameraAuthType(.authorized))
            case .denied:
                self.action.onNext(.setCameraAuthType(.denied))
            case .notDetermined:
                AVCaptureDevice.requestAccess(for: .video) { granted in
                    if granted{
                        self.action.onNext(.setCameraAuthType(.authorized))
                    }
                    else{
                        self.action.onNext(.setCameraAuthType(.denied))
                    }
                }
            default:
                break
            }
        }
    }

    private func checkPhotoAuth(completion: (() -> Void)?) {
        let status = PHPhotoLibrary.authorizationStatus()

        switch status {
        case .notDetermined:
            requestPhotoAuth(completion: completion)

        case .denied, .restricted:
//            self.moveToConfig.onNext(())
            break

        case .authorized:
            completion?()

        case .limited:
            break

        @unknown default:
            break
        }
    }

    private func requestPhotoAuth(completion: (() -> Void)?) {
        PHPhotoLibrary.requestAuthorization(for: .readWrite, handler: { [weak self] status in

            switch status {
            case .authorized:
                completion?()

            case .denied, .restricted, .notDetermined, .limited:
                break

            @unknown default:
                break
            }
        })
    }


    public func requestPhotoLibraryAuthorization() {
        let status = PHPhotoLibrary.authorizationStatus(for: .readWrite)

        switch status {
        case .authorized:
            self.action.onNext(.setPhotoAuthType(.authorized))

        case .limited:
            self.action.onNext(.setPhotoAuthType(.limited))

        case .denied:
            self.action.onNext(.setPhotoAuthType(.denied))

        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { newStatus in
                if newStatus == .authorized{
                    self.action.onNext(.setPhotoAuthType(.authorized))
                }
                if newStatus == .limited {
                    self.action.onNext(.setPhotoAuthType(.limited))
                }
                else if newStatus == .denied{
                    self.action.onNext(.setPhotoAuthType(.denied))
                }
                else{
                    self.action.onNext(.setPhotoAuthType(.unknown))
                }
            }
        default:
            self.action.onNext(.setPhotoAuthType(.unknown))
        }
    }
}
