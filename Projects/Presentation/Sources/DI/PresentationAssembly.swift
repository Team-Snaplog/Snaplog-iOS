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

//        container.register(TopicCollectionViewCellReactor.self) { resolver in
//            TopicCollectionViewCellReactor(item: resolver.resolve(TopicEntity.self)!, indexPath: IndexPath(item: 0, section: 0))
//        }
//
//        container.register(SnapPreviewTableViewCellReactor.self) { resolver in
//            SnapPreviewTableViewCellReactor(item: resolver.resolve(SnapEntity.self)!)
//        }
//
//        container.register(SnapPreviewImageCollectionViewCellReactor.self) { resolver in
//            SnapPreviewImageCollectionViewCellReactor(item: nil)
//        }

//        container.register(OnBoardingCalendarView.self) { resolver in
//            OnBoardingCalendarView()
//        }
    }
}
