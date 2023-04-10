//
//  DateFormatter+.swift
//  GeuniWeb
//
//  Created by 60157085 on 2023/04/07.
//

import Foundation

public extension DateFormatter {
    static var shared: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar.shared
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Seoul")
        dateFormatter.locale = Locale(identifier: "ko_KR")
        return dateFormatter
    }()
}
