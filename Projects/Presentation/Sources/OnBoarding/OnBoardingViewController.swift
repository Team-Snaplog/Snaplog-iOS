//
//  OnBoardingViewController.swift
//  Presentation
//
//  Created by 강민성 on 9/10/24.
//  Copyright © 2024 com.team.snaplog. All rights reserved.
//

import UIKit
import DesignSystem

import RxSwift
import RxCocoa
import ReactorKit
import SnapKit
//import FSCalendar
import RxGesture

public final class OnBoardingViewController: BaseViewController<OnBoardingReactor>, ReactorKit.View {

    public typealias Reactor = OnBoardingReactor

    var scrollView: UIScrollView = {
        var scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isScrollEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = .white
        return scrollView
    }()

    var contentView: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()

    var onBoardingHeaderView = OnBoardingHeaderView()

    let calendarView = CalendarView(initialDate: Calendar.current.date(byAdding: .year, value: -1, to: Date.now)!)

    let snapPreviewView: UITableView = {
        var tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(SnapPreviewTableViewCell.self, forCellReuseIdentifier: SnapPreviewTableViewCell.className)
        tableView.isScrollEnabled = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 226
        tableView.backgroundColor = .white
        return tableView
    }()

    let addSnapButton: UIButton = {
        let button = UIButton()
        button.setTitle("스냅 추가", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = DesignSystemAsset.AzureColor.azure500.color
        button.layer.cornerRadius = 10
        return button
    }()

    private lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = "yyyy년 M월"
        return dateFormatter
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
        calendarView.delegate = self
        render()
    }

    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        onBoardingHeaderView.topicCollectionView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
    }


    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }

    public override func configureUI() {
        super.configureUI()
    }

    private func render() {
        view.addSubViews([scrollView, addSnapButton])
        scrollView.addSubViews([contentView])
        contentView.addSubViews([onBoardingHeaderView, calendarView, snapPreviewView])

        scrollView.snp.makeConstraints { make in
            make.top.equalTo(navigationBarArea.snp.top)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
        }

        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(scrollView.snp.width) // scrollView와 같은 너비로 설정
        }

        onBoardingHeaderView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(80)
        }

        calendarView.snp.makeConstraints { make in
            make.top.equalTo(onBoardingHeaderView.snp.bottom).offset(36)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(332)
        }

        calendarView.calendarCollectionView.snp.updateConstraints { make in
            make.leading.equalToSuperview().offset(4)
            make.trailing.equalToSuperview().offset(-4)
        }

        snapPreviewView.snp.makeConstraints { make in
            make.top.equalTo(calendarView.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(snapPreviewView.contentSize.height)
            make.bottom.equalTo(contentView.snp.bottom).priority(.low)
        }

        contentView.snp.makeConstraints { make in
            make.bottom.equalTo(snapPreviewView.snp.bottom)
        }

        addSnapButton.snp.makeConstraints { make in
            make.height.equalTo(56)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-32)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(20)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-20)
        }

        scrollView.snp.makeConstraints { make in
            make.bottom.equalTo(addSnapButton.snp.top)
        }

        snapPreviewView.rx.contentOffset
            .subscribe(onNext: { [weak self]_ in
                self?.updateHeight()
            })
            .disposed(by: disposeBag)
    }

    private func updateHeight() {
        snapPreviewView.snp.updateConstraints { make in
            make.height.equalTo(snapPreviewView.contentSize.height)
        }
        contentView.layoutIfNeeded()
    }
}

extension OnBoardingViewController: CalendarViewDelegate {
    public func didSelect(_ date: Date) {
        print("date \(date)")
    }
}

/*
 func setCalendar() {
 calendarView.calendarView.delegate = self
 calendarView.headerTitle.text = self.dateFormatter.string(from: calendarView.currentPage!)
 }

 public func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
 calendarView.headerTitle.text = self.dateFormatter.string(from: calendar.currentPage)
 }

 private func updateTitleLabel(for date: Date) {
 let dateFormatter = DateFormatter()
 dateFormatter.locale = Locale(identifier: "ko_KR")
 dateFormatter.dateFormat = "yyyy년 M월"
 calendarView.headerTitle.text = dateFormatter.string(from: date)
 }
 */

extension OnBoardingViewController {
    public func bind(reactor: OnBoardingReactor) {
        bindAction(reactor: reactor)
        bindState(reactor: reactor)
    }

    private func bindAction(reactor: OnBoardingReactor) {
        rx.viewWillAppear
            .map { Reactor.Action.viewWillAppear }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        //        calendarView.previousMonthButton.rx.tap
        //            .map { Reactor.Action.didTapPreviousMonthButton }
        //            .bind(to: reactor.action)
        //            .disposed(by: disposeBag)
        //
//        calendarView.headerView.nextMonthButton.rx.tap
//                    .map { Reactor.Action.didTapNextMonthButton }
//                    .bind(to: reactor.action)
//                    .disposed(by: disposeBag)

        onBoardingHeaderView.topicCollectionView.rx.itemSelected
            .map { Reactor.Action.didTapTopicHeaderCell($0)}
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

//            .subscribe(onNext: { [weak self] indexPath in
//                guard let self = self else { return }
//
//            })
    }

    private func bindState(reactor: OnBoardingReactor) {
        reactor.state.compactMap { $0.topics }
            .bind(to: onBoardingHeaderView.topicCollectionView.rx
                .items(
                    cellIdentifier: TopicCollectionViewCell.className,
                    cellType: TopicCollectionViewCell.self
                )
            ) { index, item, cell in
                let cellReactor = TopicCollectionViewCellReactor(item: item, indexPath: IndexPath(item: index, section: 0))
                cell.reactor = cellReactor
            }
            .disposed(by: disposeBag)

        reactor.state.map { $0.snaps }
            .distinctUntilChanged()
            .bind(to: snapPreviewView.rx
                .items(
                    cellIdentifier: SnapPreviewTableViewCell.className,
                    cellType: SnapPreviewTableViewCell.self
                )
            ) { index, item, cell in
                let cellReactor = SnapPreviewTableViewCellReactor(item: item)
                cell.reactor = cellReactor
                //                self.snapPreviewView.reloadData()
                self.snapPreviewView.invalidateIntrinsicContentSize()
            }
            .disposed(by: disposeBag)

        //        reactor.state.map { $0.currentPage }
        //            .distinctUntilChanged()
        //            .withUnretained(self)
        //            .bind { viewController, currentPage in
        //                viewController.calendarView.calendarView.setCurrentPage(currentPage, animated: true)
        //                viewController.updateTitleLabel(for: currentPage)
        //            }
        //            .disposed(by: disposeBag)
    }
}

