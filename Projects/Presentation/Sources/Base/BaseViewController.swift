//
//  BaseViewController.swift
//  Presentation
//
//  Created by 강민성 on 8/28/24.
//  Copyright © 2024 com.team.snaplog. All rights reserved.
//

import UIKit
import Utility

import RxSwift
import RxCocoa
import SnapKit
import RxKeyboard
import ReactorKit

public class BaseViewController<Reactor: BaseReactor>: UIViewController {
    
    // MARK: - Properties
    
    public let reactor: Reactor
    
    private let keyboardHeight = BehaviorRelay<CGFloat>(value: 0)
    public var disposeBag = DisposeBag()
    
    // MARK: - UI Components
    
    public let navigationTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    
    public let navigationBarArea: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    public var backButton: UIButton = {
        let button = UIButton(type: .custom)
        return button
    }()
    
    public let keyboardWrapperView: PassThroughView = {
        let view = PassThroughView()
        view.isUserInteractionEnabled = false
        return view
    }()
    
    public let keyboardSafeAreaView: PassThroughView = {
        let view = PassThroughView()
        return view
    }()
    
    public init(_ reactor: Reactor) {
        self.reactor = reactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        configureUI()
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?){
        super.touchesEnded(touches, with: event)
        self.view.endEditing(true)
   }
    
    public func addNavigationTitleLabel(_ title: String? = nil) {
        self.navigationBarArea.addSubview(navigationTitleLabel)
        navigationTitleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-15)
        }
        if let title = title {
            navigationTitleLabel.text = title
        }
    }
    
    public func addBackButton() {
        self.navigationBarArea.addSubview(backButton)
        backButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.bottom.equalToSuperview().offset(-16)
        }
    }
    
    public func configureUI() {
        self.view.addSubViews([self.keyboardWrapperView, self.keyboardSafeAreaView])
        self.keyboardSafeAreaView.addSubview(self.navigationBarArea)
        self.navigationBarArea.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview()
            $0.height.equalTo(56 + view.getSafeArea().top).priority(.required)
        }
        
        RxKeyboard.instance.visibleHeight
            .asObservable()
            .filter { 0 <= $0 }
            .bind { [weak self] in self?.keyboardHeight.accept($0) }
            .disposed(by: disposeBag)
        
        self.keyboardWrapperView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(0).priority(.high)
        }
        
        self.keyboardSafeAreaView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(self.keyboardWrapperView.snp.top)
        }
        
        self.keyboardHeight
            .withUnretained(self)
            .bind(onNext: { ss, height in
                ss.updateKeyboardHeight(height)
                UIView.transition(
                    with: ss.keyboardWrapperView,
                    duration: 0.25,
                    options: .init(rawValue: 458752),
                    animations: ss.view.layoutIfNeeded
                )
            }).disposed(by: disposeBag)
    }
    
    // MARK: - Helpers
    
    private func updateKeyboardHeight(_ height: CGFloat) {
        self.keyboardWrapperView.snp.updateConstraints {
            $0.height.equalTo(self.keyboardHeight.value).priority(.high)
        }
    }
    
    func addBlurEffect() {
        let blurEffect = UIBlurEffect(style: .regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.tag = 0
        blurEffectView.frame = self.view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.addSubview(blurEffectView)
    }
    
    func removeBlurEffect() {
        self.view.viewWithTag(0)?.removeFromSuperview()
    }
    
    func showLoading() {
        // 최상단에 있는 window 객체 획득
        guard let window = UIApplication.shared.windows.last else { return }
        
        let loadingIndicatorView: UIActivityIndicatorView
        if let existedView = window.subviews.first(where: { $0 is UIActivityIndicatorView } ) as? UIActivityIndicatorView {
            loadingIndicatorView = existedView
        } else {
            loadingIndicatorView = UIActivityIndicatorView(style: .large)
            /// 다른 UI가 눌리지 않도록 indicatorView의 크기를 full로 할당
            loadingIndicatorView.frame = window.frame
            window.addSubview(loadingIndicatorView)
        }
        
        loadingIndicatorView.startAnimating()
    }
    
    func hideLoading() {
        guard let window = UIApplication.shared.windows.last else { return }
        window.subviews.filter({ $0 is UIActivityIndicatorView }).forEach { $0.removeFromSuperview() }
    }
}
