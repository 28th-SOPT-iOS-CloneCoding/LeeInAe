//
//  Date+Extension.swift
//  cgv-iOS-clone
//
//  Created by inae Lee on 2021/05/12.
//

import Foundation

extension Date {
    func getStringToDate(format: String = "yyyy-MM-dd", date: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format

        return dateFormatter.date(from: date) ?? Date()
    }

    func getDateToString(format: String = "yyyy.MM.dd", date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format

        return dateFormatter.string(from: date)
    }
}
