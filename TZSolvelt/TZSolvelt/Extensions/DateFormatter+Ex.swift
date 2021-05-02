//
//  DateFormatter+Ex.swift
//  TZSolvelt
//
//  Created by Default User on 5/2/21.
//

import Foundation

extension DateFormatter {
    func preferredFormatString(from date: Date?) -> String {
        guard  let date = date else {
            return ""
        }
        self.dateFormat = "dd.MM.yyyy"
        return self.string(from: date)
    }
}
