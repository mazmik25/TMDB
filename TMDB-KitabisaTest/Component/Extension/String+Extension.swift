//
//  String+Extension.swift
//  TMDB-KitabisaTest
//
//  Created by Azmi Muhammad on 22/02/20.
//  Copyright © 2020 Azmi Muhammad. All rights reserved.
//

import Foundation
enum DateFormat: String {
    case ISO = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    case monthFullName = "dd MMMM yyyy"
    case dayAndMonthFullName = "dd MMMM"
    case monthInitial = "dd MMM yyyy"
    case monthInitialReversed = "yyyy MMM dd"
    case dateWithoutStrip = "dd MM yyyy"
    case dateWithoutStripReversed = "yyyy MM dd"
    case dateWithStrip = "dd-MM-yyyy"
    case dateWithStripReversed = "yyyy-MM-dd"
    case monthAndYearStripReversed = "yyyy-MM"
}

extension String {
    func isEmpty() -> Bool {
        return trimmingCharacters(in: .whitespacesAndNewlines) == "" || isEmpty
    }
    
    func stringToDate(format: DateFormat) -> Date? {
        let formatter: DateFormatter = DateFormatter()
        formatter.locale = Locale(identifier: "ID")
        formatter.dateFormat = format.rawValue
        return formatter.date(from: self)
    }
    
    func reformatString(from format: DateFormat, to target: DateFormat) -> String {
        guard let originalDate: Date = stringToDate(format: format) else {return self}
        return originalDate.dateToString(withFormat: target)
    }
}
