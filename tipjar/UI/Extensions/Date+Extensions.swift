//
//  Date+Extensions.swift
//  tipjar
//
//  Created by Victor Idongesit on 12/06/2022.
//

import Foundation

extension Date {
    var formatted: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MMMM d"
        return formatter.string(from: self)
    }
}
