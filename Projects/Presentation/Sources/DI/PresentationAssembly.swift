//
//  PresentationAssembly.swift
//  Presentation
//
//  Created by 강민성 on 8/28/24.
//  Copyright © 2024 com.team.snaplog. All rights reserved.
//

import Foundation
import Core
import Domain

import Swinject

public final class PresentationAssembly: Assembly {
    public init() {}

    public func assemble(container: Container) {
        container.register(HomeReactor.self) { resolver in
            HomeReactor()
        }
        
        container.register(HomeViewController.self) { resolver in
            HomeViewController(with: resolver.resolve(HomeReactor.self)!)
        }
        
        container.register(SignInReactor.self) { resolver in
            SignInReactor()
        }
        
        container.register(SignInViewController.self) { resolver in
            SignInViewController(with: resolver.resolve(SignInReactor.self)!)
        }

        container.register(OnBoardingReactor.self) { resolver in
            OnBoardingReactor()
        }

        container.register(OnBoardingViewController.self) { resolver in
            OnBoardingViewController(with: resolver.resolve(OnBoardingReactor.self)!)
        }

        container.register(AddTopicViewController.self) { resolver in
            AddTopicViewController(with: resolver.resolve(AddTopicReactor.self)!)
        }

        container.register(AddTopicReactor.self) { resolver in
            AddTopicReactor()
        }

        container.register(TopicCollectionViewCellReactor.self) { resolver in
            TopicCollectionViewCellReactor(item: resolver.resolve(TopicEntity.self)!, indexPath: IndexPath(item: 0, section: 0))
        }

        container.register(SnapPreviewTableViewCellReactor.self) { resolver in
            SnapPreviewTableViewCellReactor(item: resolver.resolve(SnapEntity.self)!)
        }

        container.register(SnapPreviewImageCollectionViewCellReactor.self) { resolver in
            SnapPreviewImageCollectionViewCellReactor(item: nil)
        }

        container.register(CompleteAddTopicReactor.self) { (resolver, title: String, emoji: String) in
            CompleteAddTopicReactor(title: title, emoji: emoji)
        }

        container.register(CompleteAddTopicViewController.self) { (resolver, title: String, emoji: String) in
            let reactor = resolver.resolve(CompleteAddTopicReactor.self, arguments: title, emoji)
            let completeAddTopicViewController = CompleteAddTopicViewController(with: reactor!)
            completeAddTopicViewController.reactor = reactor

            return completeAddTopicViewController
        }

        container.register(AddPhotosViewController.self) { resolver in
            AddPhotosViewController(with: resolver.resolve(AddPhotosReactor.self)!)
        }

        container.register(AddPhotosReactor.self) { resolver in
            AddPhotosReactor()
        }
    }
}
