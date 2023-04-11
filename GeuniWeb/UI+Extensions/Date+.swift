//
//  Date+.swift
//  GeuniWeb
//
//  Created by 60157085 on 2023/04/07.
//

import Foundation

public extension Date {
    func getComponent(_ comp: Calendar.Component) -> Int {
        return Calendar.shared.component(comp, from: self)
    }

    func toString(format: String = "yyyy-MM-dd HH:mm:ss") -> String {
        let dateFormatter = DateFormatter.shared
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }

    func withoutTime() -> Date? {
        let components: DateComponents = Calendar.shared.dateComponents([.year, .month, .day], from: self)
        let start: Date? = Calendar.shared.date(from: components)
        return start
    }

    func getStartDayOfMonth() -> Date {
        let component = Calendar.current.dateComponents([.year, .month], from: self)
        return Calendar.current.date(from: component) ?? Date()
    }

    func getNextMonth(of givenDate: Date = Date()) -> Date {
        return Calendar.current.date(
            byAdding: .month,
            value: 1,
            to: givenDate
        ) ?? Date()
    }

    func getPreviousMonth(of givenDate: Date = Date()) -> Date {
        return Calendar.current.date(
            byAdding: .month,
            value: -1,
            to: givenDate
        ) ?? Date()
    }

    var year: Int {
        return Calendar.shared.component(.year, from: self)
    }

    var month: Int {
        return Calendar.shared.component(.month, from: self)
    }

    var day: Int {
        return Calendar.shared.component(.day, from: self)
    }

    var hour: Int {
        return Calendar.shared.component(.hour, from: self)
    }

    var minute: Int {
        return Calendar.shared.component(.minute, from: self)
    }

    var second: Int {
        return Calendar.shared.component(.second, from: self)
    }
}
