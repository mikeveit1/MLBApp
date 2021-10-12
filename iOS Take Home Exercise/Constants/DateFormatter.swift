//
//  DateFormatter.swift
//  iOS Take Home Exercise
//
//  Created by Michael Veit on 10/9/21.
//  Copyright © 2021 Lewanda, David. All rights reserved.
//

import Foundation
import UIKit

internal var dateFormatter = DateFormatter()
internal var gameDateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
internal var officialDateFormat = "yyyy-MM-dd"
internal var timeFormat = "h:mm a"
internal var dayOfWeekFormat = "EEEE"
internal var monthDayFormat = "MMMM d"
internal var monthDayYearFormat = "MMMM d, yyyy"

internal func getCurrentDateString(date: Date, format: String ) -> String {
    dateFormatter.dateFormat = format
    return dateFormatter.string(from: date)
}

internal func getCurrentDate(date: String, format: String ) -> Date {
    dateFormatter.dateFormat = format
    return dateFormatter.date(from: date)!
}

