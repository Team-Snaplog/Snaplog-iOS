//
//  SnapPreviewImageCollectionViewCellReactor.swift
//  Presentation
//
//  Created by 강민성 on 10/7/24.
//  Copyright © 2024 com.team.snaplog. All rights reserved.
//

import Foundation
import UIKit

import RxSwift
import RxCocoa
import RxFlow
import RxRelay
import ReactorKit

public final class SnapPreviewImageCollectionViewCellReactor: ReactorKit.Reactor {

    public let initialState: State
    public let disposeBag: DisposeBag = DisposeBag()

    public init(item: UIImage?) {
        self.initialState = State(photos: item)
    }

    public typealias Action = NoAction

    public struct State {
        var photos: UIImage?
    }
}
