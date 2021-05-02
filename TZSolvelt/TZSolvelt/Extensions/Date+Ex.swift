//
//  Date+Ex.swift
//  TZSolvelt
//
//  Created by Default User on 5/2/21.
//

import Foundation

extension Date {
    func isToday() -> Bool {
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter.string(from: now) == dateFormatter.string(from: self)
    }
}
