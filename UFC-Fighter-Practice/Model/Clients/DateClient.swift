//
//  DateClient.swift
//  UFC-Fighter-Practice
//
//  Created by Leandro Wauters on 12/15/18.
//  Copyright © 2018 Leandro Wauters. All rights reserved.
//

import EventKit
import UIKit
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
        dateFormatter.timeZone = TimeZone.current
        if let date2 = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = dateFormat
            dateToReturn = date2
        }
        return dateFormatter.string(from: dateToReturn)
    }
    
    static func createEvent (eventDate: String, endDate: String, eventTitle: String, eventDetails: String, vc: UIViewController) -> EKEventStore {
        var dateToSet = Date()
        var endDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.timeZone = TimeZone.current
        if let date = dateFormatter.date(from: eventDate) {
            dateToSet = date
        }
        if let date = dateFormatter.date(from: eventDate) {
            endDate = date
        }
        let eventStore : EKEventStore = EKEventStore()
        eventStore.requestAccess(to: .event, completion: {
            granted, error in
            if granted && error == nil {
                print("granted \(granted)")
                print(String(describing: error))
                
                let event:EKEvent = EKEvent(eventStore: eventStore)
                event.title = eventTitle
                event.startDate = dateToSet
                event.endDate = endDate
                event.notes = eventDetails
                event.calendar = eventStore.defaultCalendarForNewEvents
//                eventStore.save(event, span: .thisEvent)
                do {
                    try eventStore.save(event, span: .thisEvent)
                    print("Saved \(String(describing: event.title)) \(String(describing: event.location)) in \(event.calendar.title)")
                } catch {
                    print("failed to save event with error : \(error as NSError)")
                }
                print("Saved Event")
                let alert = UIAlertController(title: "Event Saved!", message: "\(eventTitle) scheduled for \(convertDateToLocalDate(str: eventDate, dateFormat: "MMM d, h:mm a")) successfully saved in \(event.calendar.title)", preferredStyle: .alert)
                let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(OKAction)
                vc.present(alert, animated: true, completion: nil)
                
            }
        })
        return eventStore
    }
    
}

