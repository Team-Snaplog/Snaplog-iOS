//
//  CalendarCell.swift
//  Presentation
//
//  Created by 강민성 on 9/28/24.
//  Copyright © 2024 com.team.snaplog. All rights reserved.
//

import UIKit
import DesignSystem
import Domain

import RxSwift
import RxRelay
import RxCocoa
import SnapKit

public final class CalendarCell: UICollectionViewCell {

    private var itemHeight: CGFloat = 0
    private var itemSpacing: CGFloat = 0
    private var lineSpacing: CGFloat = 0

    private var dataSource: [CalendarDate] = [] {
        didSet {
            monthCollectionView.reloadData()
        }
    }

    var selectedDate: CalendarDate?
    var selectedDateRelay = PublishRelay<CalendarDate>()

    private let monthCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout.init())
        collectionView.register(CalendarViewDayCell.self, forCellWithReuseIdentifier: CalendarViewDayCell.className)
        collectionView.isScrollEnabled = false
        collectionView.backgroundColor = .white

        return collectionView
    }()

    public override init(frame: CGRect) {
        super.init(frame: frame)
        monthCollectionView.delegate = self
        monthCollectionView.dataSource = self
        backgroundColor = .white
        render()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func configure(_ dataSource: [CalendarDate], itemHeight: CGFloat, itemSpacing: CGFloat, lineSpacing: CGFloat) {
        self.dataSource = dataSource
        self.itemHeight = itemHeight
        self.itemSpacing = itemSpacing
        self.lineSpacing = lineSpacing

        monthCollectionView.collectionViewLayout = collectionViewLayout()
    }

    private func render() {
        contentView.addSubViews([monthCollectionView])

        monthCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension CalendarCell: UICollectionViewDelegate, UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }

    public func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CalendarViewDayCell.className, for: indexPath)
                as? CalendarViewDayCell else { return UICollectionViewCell() }

        let calendarDate = dataSource[indexPath.row]
        cell.configure("\(calendarDate.day)", type: calendarDate.type)

        if calendarDate == selectedDate {
            collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .init())
            cell.isSelected = true
        }
        return cell
    }

    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedDateRelay.accept(dataSource[indexPath.row + 1])
    }

    public func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        guard let cell = collectionView.cellForItem(at: indexPath) else { return false }

        return !cell.isSelected
    }
}

extension CalendarCell {
    public func deselectAllCell() {
        let count = monthCollectionView.visibleCells.count

        for row in (0..<count) {
            let indexPath = IndexPath(row: row, section: 0)

            if let cell = monthCollectionView.cellForItem(at: indexPath) {
                monthCollectionView.deselectItem(at: indexPath, animated: false)
                cell.isSelected = false
            }

        }
    }
}

private extension CalendarCell {
    func collectionViewLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .absolute(itemHeight),
            heightDimension: .fractionalHeight(1)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(itemHeight)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(itemSpacing)

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = lineSpacing

        return UICollectionViewCompositionalLayout(section: section)
    }
}
