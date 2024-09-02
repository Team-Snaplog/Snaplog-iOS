//
//  HomeViewController.swift
//  Presentation
//
//  Created by 강민성 on 8/28/24.
//  Copyright © 2024 com.team.snaplog. All rights reserved.
//

import UIKit

import ReactorKit

public final class HomeViewController: BaseViewController<HomeReactor>, ReactorKit.View {
    
    public typealias Reactor = HomeReactor

    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        // Do any additional setup after loading the view.
    }

    public override func configureUI() {
        super.configureUI()
    }
}

extension HomeViewController {
    public func bind(reactor: HomeReactor) {
        
    }
}
