//
//  Date+Extension.swift
//  pencake-iOS-clone
//
//  Created by inae Lee on 2021/06/03.
//

import Foundation

extension Date {
    func getStringToDate(format: String = "yyyy-MM-dd", date: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = .init(identifier: "ko_KR")
        dateFormatter.dateFormat = format

        return dateFormatter.date(from: date) ?? Date()
    }

    func getDateToString(format: String = "yyyy.MM.dd", date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = .init(identifier: "ko_KR")
        dateFormatter.dateFormat = format

        return dateFormatter.string(from: date)
    }
}
