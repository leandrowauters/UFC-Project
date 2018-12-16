//
//  DateClient.swift
//  UFC-Fighter-Practice
//
//  Created by Leandro Wauters on 12/15/18.
//  Copyright © 2018 Leandro Wauters. All rights reserved.
//

import Foundation

class DateClient {
    static func getDatesAsyyyyMMdd(date: String) -> String {
        let date = date.components(separatedBy: "T")
        return date[0]// USE THE DATE NOTES SEE MEDIUM ARTICLE
    }
   static func getToday() -> String {
        let isoDateFormatter = ISO8601DateFormatter()
        isoDateFormatter.formatOptions = [.withInternetDateTime,
                                          .withDashSeparatorInDate,
                                          .withFullDate,
                                          .withColonSeparatorInTimeZone]
        isoDateFormatter.timeZone = TimeZone.init(abbreviation: "EST")
        let date1 = isoDateFormatter.string(from: Date())
        return date1
    
}
    
    static func convertDateToLocalDate(str: String, dateFormat: String) -> String {
        // Making a Date from a String
        let dateString = str
        var dateToReturn = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
//        dateFormatter.timeZone = T
        if let date2 = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = dateFormat
            dateToReturn = date2
        }
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter.string(from: dateToReturn)
    }
    
}

