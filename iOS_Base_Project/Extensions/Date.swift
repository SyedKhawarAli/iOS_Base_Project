//
//  NSDate.swift
//  MyLifeMatters
//
//  Created by Thanh-Tam Le on 11/24/16.
//  Copyright © 2016 Thanh-Tam Le. All rights reserved.
//

import Foundation

extension Date {
    static var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: UserDefaultsManager.appLanguage ?? "en")
        formatter.dateStyle = .full
        formatter.timeStyle = .none
        return formatter
    }()
    
    static var timeWithAmPmFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
    
    static var timeWithOutAmPmFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm"
        return formatter
    }()
    
    static var timeAmPmFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        return formatter
    }()
    
    static var dateWithDayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: UserDefaultsManager.appLanguage ?? "en")
        formatter.dateFormat = "E, dd.MM.yyyy"
        return formatter
    }()
    
    static var dateWithDotsFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: UserDefaultsManager.appLanguage ?? "en")
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter
    }()
    
    static var monthAndYearFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: UserDefaultsManager.appLanguage ?? "en")
        formatter.dateFormat = "MMMM yyyy"
        return formatter
    }()
    
    static var fullMonthNameFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM"
        return formatter
    }()
    
    static var backendDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSSSSS"
        return formatter
    }()
    
    static var backendDateForViewFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        return formatter
    }()
    
    static var backendOnlyDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    func getDateComponent() -> String? {
        return Date.backendOnlyDateFormatter.string(from: self)
    }
    
    static var getDateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        return formatter
    }()
    
    var startOfMonth: Date? {
        let components = Calendar.current.dateComponents([.year, .month], from: self)
        return Calendar.current.date(from: components)
    }
    
    var lastDayOfWeek: Date? {
        let startOfWeek = firstDayOfWeek()
        let end = Calendar.current.date(byAdding: DateComponents(day: 6), to: startOfWeek)
        return end
    }
    
    static func dates(from fromDate: Date, to toDate: Date) -> [Date] {
        var dates: [Date] = []
        var date = fromDate
        
        while date <= toDate {
            dates.append(date)
            guard let newDate = Calendar.current.date(byAdding: .day, value: 1, to: date) else { break }
            date = newDate
        }
        return dates
    }
    
    var dateStringWithDots: String { return Date.dateWithDotsFormat.string(from: self) }
    
    func firstDayOfWeek() -> Date {
        let c = Calendar(identifier: .iso8601)
        let date = c.date(from: c.dateComponents([.weekOfYear, .yearForWeekOfYear], from: self)) ?? Date()
        return date
    }
    
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }
    
    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
    
    func isSameDay(date: Date?) -> Bool {
        let diff = Calendar.current.dateComponents([.day], from: self, to: date ?? Date())
        if diff.day == 0 {
            return true
        } else {
            return false
        }
    }
    
    func isGreaterThanDate(dateToCompare: Date) -> Bool {
        //Declare Variables
        var isGreater = false
        
        //Compare Values
        if self.compare(dateToCompare as Date) == ComparisonResult.orderedDescending {
            isGreater = true
        }
        
        //Return Result
        return isGreater
    }
    
    func isLessThanDate(dateToCompare: Date) -> Bool {
        //Declare Variables
        var isLess = false
        
        //Compare Values
        if self.compare(dateToCompare as Date) == ComparisonResult.orderedAscending {
            isLess = true
        }
        
        //Return Result
        return isLess
    }
    
    func equalToDate(dateToCompare: Date) -> Bool {
        //Declare Variables
        var isEqualTo = false
        
        //Compare Values
        if self.compare(dateToCompare as Date) == ComparisonResult.orderedSame {
            isEqualTo = true
        }
        
        //Return Result
        return isEqualTo
    }
    
    var iso8601: String { return Formatter.iso8601.string(from: self) }
    
    var dateString: String { return Formatter.dateFormat.string(from: self) }
    
    var timeString: String { return Formatter.timeFormat.string(from: self) }
    
    var ticks: UInt64 {
        return UInt64((self.timeIntervalSince1970 + 62_135_596_800) * 10_000_000)
    }
    
    init(ticks: UInt64) {
        self.init(timeIntervalSince1970: Double(ticks)/10_000_000 - 62_135_596_800)
    }
    
    func daysInBetween(_ date: Date) -> Double {
        var diff = self.timeIntervalSinceNow - date.timeIntervalSinceNow
        diff = fabs(diff/86400)
        return diff
    }
    
    func hoursInBetween(_ date: Date) -> Double {
        var diff = self.timeIntervalSinceNow - date.timeIntervalSinceNow
        diff = fabs(diff/3600)
        return diff
    }
    
    func minutesInBetween(_ date: Date) -> Double {
        var diff = self.timeIntervalSinceNow - date.timeIntervalSinceNow
        diff = fabs(diff/60)
        return diff
    }
    
    func secondsInBetween(_ date: Date) -> Double {
        var diff = self.timeIntervalSinceNow - date.timeIntervalSinceNow
        diff = fabs(diff)
        return diff
    }
}

struct Formatter {
    static let iso8601: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: Calendar.Identifier.iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
        return formatter
    }()
    
    static let dateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter
    }()
    
    static let timeFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm:ss a"
        return formatter
    }()
}
