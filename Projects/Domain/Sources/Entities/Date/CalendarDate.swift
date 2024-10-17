//
//  CalendarDate.swift
//  Domain
//
//  Created by 강민성 on 9/27/24.
//  Copyright © 2024 com.team.snaplog. All rights reserved.
//

import Foundation

public struct CalendarDate {
    public var year: Int
    public var month: Int
    public var day: Int
    public var type: DateType

    public var date: Date {
        let string = "\(year)-\(month)-\(day)"
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")

        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: string) ?? .now
        return date
    }
}
extension CalendarDate {
    public init(date: Date) {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)

        self.year = components.year ?? 0
        self.month = components.month ?? 0
        self.day = components.day ?? 0
        self.type = .isDefault
    }
}

// MARK: - Methods
extension CalendarDate {
    public func today() -> CalendarDate {
        let date = Date()
        let today = Calendar.current.dateComponents([.year, .month, .day], from: date)
        return CalendarDate(year: today.year!, month: today.month!, day: today.day!, type: type)
    }

    /// 다음날짜의 `CalendarDate`를 리턴합니다.
    public func nextDay() -> CalendarDate {
        if day == self.daysOfMonth() {
            return nextMonth()
        } else {
            return CalendarDate(year: year, month: month, day: day + 1, type: type)
        }
    }

    /// 다음달의 `CalendarDate`를 리턴합니다.
    public func nextMonth() -> CalendarDate {
        if month == 12 {
            return CalendarDate(year: year + 1, month: 1, day: day, type: type)
        } else {
            return CalendarDate(year: year, month: month + 1, day: day, type: type)
        }
    }

    /// 이전달의 `CalendarDate`를 리턴합니다.
    public func previousMonth() -> CalendarDate {
        if month == 1 {
            return CalendarDate(year: year - 1, month: 12, day: day, type: type)
        } else {
            return CalendarDate(year: year, month: month - 1, day: day, type: type)
        }
    }

    /// 현재 `Date`가 paramter의 `date`보다 더 작다면 true를 리턴합니다.
    public func compareYearAndMonth(with date: CalendarDate) -> Bool {
        if year < date.year {
            return true
        } else if year == date.year && month <= date.month {
            return true
        } else {
            return false
        }
    }

    /// `year`, `month`의 첫번째 요일을 정수형으로 리턴합니다.
    public func startDayOfWeek() -> Int {
        let calendar = Calendar.current
        let components = DateComponents(year: year, month: month)
        let date = calendar.date(from: components) ?? Date()

        return calendar.component(.weekday, from: date) - 1
    }

    /// `year`, `month`의 총 날짜 수를 리턴합니다.
    public func daysOfMonth() -> Int {
        let calendar = Calendar.current
        let components = DateComponents(year: year, month: month)
        let date = calendar.date(from: components) ?? Date()

        return calendar.range(of: .day, in: .month, for: date)?.count ?? 0
    }
}

// MARK: - Comparable
extension CalendarDate: Comparable {
    public static func < (lhs: CalendarDate, rhs: CalendarDate) -> Bool {
        if lhs.year != rhs.year {
            return lhs.year < rhs.year
        } else if lhs.month != rhs.month {
            return lhs.month < rhs.month
        } else {
            return lhs.day < rhs.day
        }
    }

    public static func == (lhs: CalendarDate, rhs: CalendarDate) -> Bool {
        return lhs.year == rhs.year && lhs.month == rhs.month && lhs.day == rhs.day
    }
}
