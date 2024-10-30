//
//  AddTopicViewController.swift
//  Presentation
//
//  Created by 강민성 on 10/17/24.
//  Copyright © 2024 com.team.snaplog. All rights reserved.
//

import UIKit
import DesignSystem
import Utility

import RxSwift
import RxCocoa
import RxFlow
import ReactorKit
import SnapKit

public final class AddTopicViewController: BaseViewController<AddTopicReactor>, ReactorKit.View {

    public typealias Reactor = AddTopicReactor

    var headerLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "추가하고 싶은\n 주제를 입력해 주세요."
        label.textAlignment = .center
        label.font = Fonts.titleLarge.font
        label.textColor = DesignSystemAsset.NeutralColor.black.color
        label.numberOfLines = 2
        return label
    }()

    var emojiTextField: UITextField = {
        var textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.clipsToBounds = true
        textField.layer.cornerRadius = 80
        textField.backgroundColor = DesignSystemAsset.NeutralColor.neutral100.color
        //        textField.placeholder = "❓"
        textField.text = "❓"
        textField.textAlignment = .center
        textField.font = .systemFont(ofSize: 78)
        return textField
    }()

    var emojiDescriptionLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "이모지를 눌러 원하는 이모지로 변경하세요."
        label.font = UIFont(name: "Pretendard-Regular", size: 12)
        label.textColor = DesignSystemAsset.NeutralColor.neutral500.color
        label.numberOfLines = 1
        return label
    }()

    var topicTitleView: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        view.backgroundColor = DesignSystemAsset.NeutralColor.neutral100.color
        return view
    }()

    var topicTitleTextField: UITextField = {
        var textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "주제 입력하기"
        textField.font = UIFont(name: "Pretendard-Regular", size: 16)
        textField.textColor = DesignSystemAsset.NeutralColor.black.color
        textField.backgroundColor = .clear
        return textField
    }()

    var topicTitleCountLabal: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0/20"
        label.font = UIFont(name: "Pretendard-Regular", size: 12)
        label.textColor = DesignSystemAsset.NeutralColor.neutral500.color
        return label
    }()

    var topicTitleWarningLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "주제를 입력해 주세요."
        label.textColor = UIColor(red: 0.92, green: 0.26, blue: 0.21, alpha: 1.0)
        label.font = UIFont(name: "Pretendard-Regular", size: 14)
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()

    var topicRecommendHeaderLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "이런 주제는 어때요?"
        label.font = Fonts.titleSmall.font
        label.textColor = DesignSystemAsset.NeutralColor.black.color
        return label
    }()

    var topicRecommendCollectionView: UICollectionView = {
        var collectionview = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        collectionview.backgroundColor = .white

        let layout = UICollectionViewFlowLayout()
        collectionview.register(
            TopicRecommendCollectionViewCell.self,
            forCellWithReuseIdentifier: TopicRecommendCollectionViewCell.className)
        layout.scrollDirection = .horizontal
        layout.itemSize = UICollectionViewFlowLayout.automaticSize
        layout.estimatedItemSize = CGSize(width: 90, height: 34)
        collectionview.collectionViewLayout = layout

        return collectionview
    }()

    var addTopicButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.setTitle("추가 완료", for: .normal)
        button.titleLabel?.font = Fonts.buttonMedium.font
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = DesignSystemAsset.AzureColor.azure500.color
        button.layer.cornerRadius = 10
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
        render()
        emojiTextField.delegate = self
        topicTitleTextField.delegate = self
    }

    public override func configureUI() {
        super.configureUI()
        addNavigationTitleLabel()
        addBackButton()
    }

    private func render() {
        topicTitleTextField.attributedPlaceholder = NSAttributedString(
            string: "주제 입력하기",
            attributes: [NSAttributedString.Key.foregroundColor: DesignSystemAsset.NeutralColor.neutral500.color])

        topicTitleView.addSubViews([topicTitleTextField, topicTitleCountLabal])

        view.addSubViews([
            headerLabel,
            emojiTextField,
            emojiDescriptionLabel,
            topicTitleView,
            topicTitleWarningLabel,
            topicRecommendHeaderLabel,
            topicRecommendCollectionView,
            addTopicButton
        ])

        headerLabel.snp.makeConstraints { make in
            make.top.equalTo(navigationBarArea.snp.bottom).offset(18)
            make.centerX.equalToSuperview()
            make.height.equalTo(56)
        }

        emojiTextField.snp.makeConstraints { make in
            make.top.equalTo(headerLabel.snp.bottom).offset(22)
            make.centerX.equalToSuperview()
            make.size.equalTo(160)
        }

        emojiDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(emojiTextField.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
        }

        topicTitleView.snp.makeConstraints { make in
            make.top.equalTo(emojiDescriptionLabel.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }

        topicTitleCountLabal.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-16)
            make.width.equalTo(34)
        }

        topicTitleTextField.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalTo(topicTitleCountLabal.snp.leading)
        }

        topicTitleWarningLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(topicTitleView.snp.bottom).offset(4)
            make.height.equalTo(20)
        }

        topicRecommendHeaderLabel.snp.makeConstraints { make in
            make.top.equalTo(topicTitleWarningLabel.snp.bottom).offset(19)
            make.centerX.equalToSuperview()
            make.height.equalTo(20)
        }

        topicRecommendCollectionView.snp.makeConstraints { make in
            make.top.equalTo(topicRecommendHeaderLabel.snp.bottom).offset(14)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(132) // 레이아웃 다시 잡기
        }

        addTopicButton.snp.makeConstraints { make in
            make.height.equalTo(56)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-32)
        }
    }
}

extension AddTopicViewController {
    public func bind(reactor: AddTopicReactor) {
        bindAction(reactor: reactor)
        bindState(reactor: reactor)
    }

    private func bindAction(reactor: AddTopicReactor) {
        rx.viewWillAppear
            .map { Reactor.Action.viewWillAppear }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        emojiTextField.rx.text
            .orEmpty
            .distinctUntilChanged()
            .map { Reactor.Action.didWriteEmoji($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        topicTitleTextField.rx.text
            .orEmpty
            .distinctUntilChanged()
            .map { Reactor.Action.didWriteTitle($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        topicRecommendCollectionView.rx.itemSelected
            .map { [weak self] indexPath -> (String, String)? in
                guard let cell = self?.topicRecommendCollectionView.cellForItem(at: indexPath) as? TopicRecommendCollectionViewCell else { return nil }
                let emoji = cell.emojiLabel.text ?? ""
                let title = cell.topicTitleLabel.text ?? ""
                return (emoji, title)
            }
            .compactMap { $0 }
            .map { Reactor.Action.didTapRecommendTopic($0.0, $0.1)}
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        backButton.rx.tap
            .map { Reactor.Action.didTapBackButton }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        addTopicButton.rx.tap
            .map { Reactor.Action.didTapAddTopicButton }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }

    private func bindState(reactor: AddTopicReactor) {
        reactor.state.map { $0.emoji }
            .distinctUntilChanged()
            .withUnretained(self)
            .bind(onNext: { viewController, emoji in
                viewController.emojiTextField.text = emoji
            })
            .disposed(by: disposeBag)

        reactor.state.map { $0.recommendTopics }
            .distinctUntilChanged()
            .bind(to: topicRecommendCollectionView.rx.items(
                cellIdentifier: TopicRecommendCollectionViewCell.className,
                cellType: TopicRecommendCollectionViewCell.self)
            ) { index, item, cell in
                let cellReactor = TopicRecommendCollectionViewCellReactor(item: item)
                cell.reactor = cellReactor

                self.topicRecommendCollectionView.invalidateIntrinsicContentSize()
            }
            .disposed(by: disposeBag)

        reactor.state.map { $0.emojiError }
            .distinctUntilChanged()
            .withUnretained(self)
            .bind(onNext: { viewController, error in
                viewController.emojiDescriptionLabel.text = error ? "이모지만 입력 가능합니다." : "이모지를 눌러 원하는 이모지로 변경하세요."
                viewController.emojiDescriptionLabel.textColor = error ?
                UIColor(red: 0.92, green: 0.26, blue: 0.21, alpha: 1.0) : DesignSystemAsset.NeutralColor.neutral500.color
                viewController.emojiTextField.layer.borderWidth = error ? 1 : 0
                viewController.emojiTextField.layer.borderColor =
                error ? UIColor(red: 0.92, green: 0.26, blue: 0.21, alpha: 1.0).cgColor : UIColor.clear.cgColor
            })
            .disposed(by: disposeBag)

        reactor.state.map { $0.emptyEmojiError }
            .distinctUntilChanged()
            .withUnretained(self)
            .bind(onNext: { viewController, error in
                viewController.emojiDescriptionLabel.text = error ? "이모지를 입력해 주세요." : "이모지를 눌러 원하는 이모지로 변경하세요."
                viewController.emojiDescriptionLabel.textColor = error ?
                UIColor(red: 0.92, green: 0.26, blue: 0.21, alpha: 1.0) : DesignSystemAsset.NeutralColor.neutral500.color
                viewController.emojiTextField.layer.borderWidth = error ? 1 : 0
                viewController.emojiTextField.layer.borderColor =
                error ? UIColor(red: 0.92, green: 0.26, blue: 0.21, alpha: 1.0).cgColor : UIColor.clear.cgColor
            })
            .disposed(by: disposeBag)

        reactor.state.map { $0.isAddTopicEnable }
            .distinctUntilChanged()
            .withUnretained(self)
            .bind(onNext: { viewController, isEnable in
                viewController.addTopicButton.isEnabled = isEnable
                viewController.addTopicButton.backgroundColor = isEnable ?
                DesignSystemAsset.AzureColor.azure500.color : DesignSystemAsset.NeutralColor.neutral300.color
                if isEnable {
                    viewController.addTopicButton.setTitleColor(.white, for: .normal)
                } else {
                    viewController.addTopicButton
                        .setTitleColor(DesignSystemAsset.NeutralColor.neutral500.color, for: .normal)
                }
            })
            .disposed(by: disposeBag)

        reactor.state.map { $0.title }
            .distinctUntilChanged()
            .withUnretained(self)
            .bind(onNext: { viewController, title in
                viewController.topicTitleTextField.text = title
            })
            .disposed(by: disposeBag)

        reactor.state.compactMap { $0.titleCount }
            .distinctUntilChanged()
            .withUnretained(self)
            .bind(onNext: { viewController, count in
                let string = String(count)
                viewController.topicTitleCountLabal.text = "\(string)/20"

                if count == 0 {
                    viewController.topicTitleWarningLabel.isHidden = false
                    viewController.topicTitleView.layer.borderColor = UIColor(red: 0.92, green: 0.26, blue: 0.21, alpha: 1.0).cgColor
                    viewController.topicTitleView.layer.borderWidth = 1
                } else {
                    viewController.topicTitleWarningLabel.isHidden = true
                    viewController.topicTitleView.layer.borderColor = UIColor.clear.cgColor
                    viewController.topicTitleView.layer.borderWidth = 0
                }
            })
            .disposed(by: disposeBag)

    }
}

extension AddTopicViewController: UITextFieldDelegate {
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = textField.text else { return true }

        let newLength = currentText.count + string.count - range.length

        if textField == emojiTextField {
            return newLength <= 1
        } else if textField == topicTitleTextField {
            return newLength <= 20
        }
        return true
    }
}

//private class RecommendCollectionViewFlowLayout: UICollectionViewFlowLayout {
//
//    // 셀 크기와 스페이싱 설정
//    let cellSize = CGSize(width: 90, height: 34)
//    let lineSpacing: CGFloat = 12
//    let itemSpacing: CGFloat = 10
//
//    override func prepare() {
//        super.prepare()
//
//        // 스크롤 방향을 수평으로 설정
//        self.scrollDirection = .horizontal
//        self.minimumLineSpacing = lineSpacing
//        self.minimumInteritemSpacing = itemSpacing
//    }
//
//    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
//        guard let collectionView = collectionView else { return nil }
//
//        var layoutAttributes: [UICollectionViewLayoutAttributes] = []
//
//        // 전체 아이템 개수를 구함
//        let totalItems = collectionView.numberOfItems(inSection: 0)
//
//        // 각 셀의 레이아웃 속성을 설정
//        for item in 0..<totalItems {
//            let indexPath = IndexPath(item: item, section: 0)
//            if let attributes = layoutAttributesForItem(at: indexPath) {
//                layoutAttributes.append(attributes)
//            }
//        }
//
//        return layoutAttributes
//    }
//
//    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
//        guard let collectionView = collectionView else { return nil }
//
//        // 아이템에 대한 기본 속성 가져오기
//        let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
//
//        // 총 아이템 개수
//        let totalItems = collectionView.numberOfItems(inSection: 0)
//
//        // 줄에 따라 셀을 배치할 위치를 계산 (몫과 나머지를 기준으로)
//        let (row, column) = calculateRowAndColumn(for: indexPath.item, totalItems: totalItems)
//
//        // 셀의 위치 계산
//        var xOffset: CGFloat = CGFloat(column) * (cellSize.width + itemSpacing)
//        var yOffset: CGFloat = 0
//
//        // 줄에 따른 Y 위치 및 X 오프셋 설정
//        switch row {
//        case 0:
//            yOffset = 0 // 첫 번째 줄
//            xOffset += 15 // 첫 번째 줄의 leading 오프셋
//        case 1:
//            yOffset = cellSize.height + lineSpacing // 두 번째 줄
//            xOffset += 30 // 두 번째 줄의 leading 오프셋
//        case 2:
//            yOffset = 2 * (cellSize.height + lineSpacing) // 세 번째 줄
//            xOffset += 15 // 세 번째 줄의 leading 오프셋
//        default:
//            break
//        }
//
//        // 셀 프레임 설정
//        attributes.frame = CGRect(x: xOffset, y: yOffset, width: cellSize.width, height: cellSize.height)
//        return attributes
//    }
//
//    // 콘텐츠 크기 설정
//    override var collectionViewContentSize: CGSize {
//        guard let collectionView = collectionView else { return .zero }
//
//        // 총 아이템 개수
//        let totalItems = collectionView.numberOfItems(inSection: 0)
//        let (itemsPerRow, rows) = calculateItemsPerRowAndRows(totalItems: totalItems)
//
//        // 세로 3줄이므로 3줄에 맞는 높이 계산
//        let contentHeight = (cellSize.height * CGFloat(rows)) + (lineSpacing * CGFloat(rows - 1))
//
//        // 가로 콘텐츠 길이 계산
//        let contentWidth = CGFloat(itemsPerRow) * (cellSize.width + itemSpacing)
//
//        return CGSize(width: contentWidth, height: contentHeight)
//    }
//
//    // 줄(row)과 열(column)을 계산하는 함수
//    private func calculateRowAndColumn(for item: Int, totalItems: Int) -> (row: Int, column: Int) {
//        let itemsPerRow = Int(ceil(Double(totalItems) / 3.0)) // 한 줄에 들어갈 최대 셀 수
//        let row = item / itemsPerRow
//        let column = item % itemsPerRow
//
//        return (row, column)
//    }
//
//    // 줄(row) 수와 각 줄에 들어가는 셀 수를 계산하는 함수
//    private func calculateItemsPerRowAndRows(totalItems: Int) -> (itemsPerRow: Int, rows: Int) {
//        let itemsPerRow = Int(ceil(Double(totalItems) / 3.0)) // 한 줄에 들어갈 최대 셀 수
//        let rows = min(3, totalItems) // 최대 3줄이므로, 데이터 수가 3개 이하면 그만큼만 줄을 생성
//
//        return (itemsPerRow, rows)
//    }
//}
