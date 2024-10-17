//
//  CalendarView.swift
//  Presentation
//
//  Created by 강민성 on 9/10/24.
//  Copyright © 2024 com.team.snaplog. All rights reserved.
//

import UIKit
import DesignSystem
import Domain

import SnapKit
import RxSwift
import RxCocoa
import RxRelay

public protocol CalendarViewDelegate: AnyObject {
    func didSelect(_ date: Date)
}

public final class CalendarView: UIView {

    var disposeBag: DisposeBag = DisposeBag()

    public weak var delegate: CalendarViewDelegate?

    public var itemHeight: CGFloat = 44 {
        didSet {
            calendarCollectionView.reloadData()
            updateCalendarCollectionView()
        }
    }

    public var itemSpacing: CGFloat = 7 {
        didSet {
            calendarCollectionView.reloadData()
            updateCalendarCollectionView()
        }
    }

    public var lineSpacing: CGFloat = 12 {
        didSet {
            calendarCollectionView.reloadData()
            updateCalendarCollectionView()
        }
    }

    public var initialDate: Date {
        didSet {
            self.dataSource = dataSource(from: initialDate, to: endDate)
        }
    }

    public var endDate: Date {
        didSet {
            self.dataSource = dataSource(from: initialDate, to: endDate)
        }
    }

    var selectedDate: Date?

//    private var calendarSize: CGSize {
//        print(itemHeight * 7 + itemSpacing * 6)
//        return CGSize(width: itemHeight * 7 + itemSpacing * 6 - 2, height: itemHeight * 5 + lineSpacing * 4)
//    }

    private var weekLabelSpacing: CGFloat {
        return itemHeight + itemSpacing - 48
        // 60 - ? = 12
    }

    private var dataSource = [[CalendarDate]]() {
        didSet {
            calendarCollectionView.reloadData()
        }
    }

    private var selectedCell: CalendarCell?

    var headerView = CalendarHeaderView(text: "2024년 12월")
    var weekDayView = WeekdayView(spacing: 12)
    var calendarCollectionView: UICollectionView = {
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0

        collectionView.register(CalendarCell.self, forCellWithReuseIdentifier: CalendarCell.className)
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.collectionViewLayout = layout
        collectionView.backgroundColor = .white

        return collectionView
    }()

    public init(initialDate: Date, endDate: Date? = nil) {
        self.initialDate = initialDate
        self.endDate = endDate ?? (Calendar.current.date(byAdding: .year, value: 1, to: initialDate) ?? initialDate)
        super.init(frame: .zero)
        backgroundColor = .white

        calendarCollectionView.delegate = self
        calendarCollectionView.dataSource = self

        setUp()

        self.dataSource = dataSource(from: initialDate, to: self.endDate)
    }

    public convenience init(selectedDate: Date, initialDate: Date, endDate: Date? = nil) {
        self.init(initialDate: initialDate, endDate: endDate)
        self.selectedDate = selectedDate
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUp() {
        weekDayView.spacing = weekLabelSpacing
        let initialDate = CalendarDate(date: initialDate)
        let endDate = CalendarDate(date: Calendar.current.date(byAdding: .year, value:0, to: Date.now)!)

        headerView.text = "\(endDate.year)년 \(endDate.month)월"

        self.addSubViews([headerView, weekDayView, calendarCollectionView])

        headerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(80)
            make.trailing.equalToSuperview().offset(-80)
            make.height.equalTo(24)
        }

        weekDayView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(18)
            make.leading.equalToSuperview().offset(4)
            //            make.leading.equalToSuperview().offset(itemHeight / 2 - 7)
            make.trailing.equalToSuperview().offset(-4)
            make.height.equalTo(20)
        }

        calendarCollectionView.snp.makeConstraints { make in
            make.top.equalTo(weekDayView.snp.bottom).offset(10)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }

        self.isUserInteractionEnabled = true
        calendarCollectionView.isUserInteractionEnabled = true

        DispatchQueue.main.async {
                    let indexPath = IndexPath(item: 12, section: 0)
                    self.calendarCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
                }

    }

}

extension CalendarView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarCell.className, for: indexPath) as? CalendarCell else {
            return UICollectionViewCell()
        }

        cell.configure(dataSource[indexPath.row], itemHeight: itemHeight, itemSpacing: itemSpacing, lineSpacing: lineSpacing)

        if let selectedDate = selectedDate {
            let calendarDate = CalendarDate(date: selectedDate)
            cell.selectedDate = calendarDate
        }

        cell.selectedDateRelay
            .bind(with: self) { owner, calendarDate in
                owner.selectedDate = calendarDate.date
                owner.delegate?.didSelect(calendarDate.date)
                if let selectedCell = owner.selectedCell, selectedCell !== cell {
                    selectedCell.deselectAllCell()
                }
                owner.selectedCell = cell
            }
            .disposed(by: disposeBag)

        return cell
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
}

extension CalendarView {
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
        if page == 0 {
            headerView.previousDisabled = true
        }
        else if page == dataSource.count {
            headerView.nextDisabled = true
        }
        else {
            headerView.previousDisabled = false
            headerView.nextDisabled = false
        }

        if let date = dataSource[page].first {
            setHeaderViewTitle(date)
        }
    }

    func updateCalendarCollectionView() {
//        calendarCollectionView.snp.updateConstraints {
//            $0.size.equalTo(calendarSize)
//        }
    }

    func setHeaderViewTitle(_ date: CalendarDate) {
        headerView.text = "\(date.year)년 \(date.month)월"
    }

    func dataSource(from startDate: Date, to endDate: Date) -> [[CalendarDate]] {
        var dataSource = [[CalendarDate]]()

        let startCalendarDate = CalendarDate(date: startDate)
        let endCalendarDate = CalendarDate(date: endDate)

        var currentCalendarDate = startCalendarDate
        let todayDate = currentCalendarDate.today()
        currentCalendarDate.day = 1
        var lastMonthCalendarDate = startCalendarDate.previousMonth()

        while currentCalendarDate.compareYearAndMonth(with: endCalendarDate) {
            var daysOfMonth = [CalendarDate]()

            let firstDayOfWeek = currentCalendarDate.startDayOfWeek()
            let totalDays = currentCalendarDate.daysOfMonth()
            let lastMonthTotalDays = lastMonthCalendarDate.daysOfMonth()

            // 첫 주의 빈 공간을 저번달로 채웁니다.
            for count in (0..<firstDayOfWeek) {
                var calendarDate = currentCalendarDate
                calendarDate.day = lastMonthTotalDays - firstDayOfWeek + count + 1
                calendarDate.type = .isDisabled

                daysOfMonth.append(calendarDate)
            }

            // 이번달을 채웁니다.
            var calendarDate = currentCalendarDate
            calendarDate.day = 1
            for _ in (0..<totalDays) {
                if calendarDate == todayDate {
                    calendarDate.type = .isToday
                } else {
                    if calendarDate < startCalendarDate {
                        calendarDate.type = .isDisabled
                    }
                    else if calendarDate == startCalendarDate {
                        calendarDate.type = .isDefault
                    }
                    else if calendarDate >= endCalendarDate {
                        calendarDate.type = .isDisabled
                    } else {
                        calendarDate.type = .isDefault
                    }
                }

                daysOfMonth.append(calendarDate)

                calendarDate = calendarDate.nextDay()
            }

            lastMonthCalendarDate = currentCalendarDate
            currentCalendarDate = currentCalendarDate.nextMonth()
            currentCalendarDate.day = 1

            // 마지막 주 빈 공간을 다음달로 채웁니다.
            calendarDate = currentCalendarDate
            calendarDate.type = .isDisabled
            while daysOfMonth.count < 35 {
                daysOfMonth.append(calendarDate)
                calendarDate = calendarDate.nextDay()
            }

            dataSource.append(daysOfMonth)
        }

        return dataSource
    }
}
