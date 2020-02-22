//
//  Date+Extension.swift
//  TMDB-KitabisaTest
//
//  Created by Azmi Muhammad on 22/02/20.
//  Copyright © 2020 Azmi Muhammad. All rights reserved.
//

import Foundation
extension Date {
    func dateToString(withFormat formatDate: DateFormat) -> String {
        let dateFormat = DateFormatter()
        dateFormat.locale = Locale(identifier: "ID")
        dateFormat.dateFormat = formatDate.rawValue
        return dateFormat.string(from: self)
    }
}
