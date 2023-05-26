import Foundation
import SwiftUI
import UserNotifications

public class Utils {
    
    var isAppInForeground: Bool = true
    static let dailyUsageTimeInSec = 30 * 60
    
    func startTracking() -> Date {
        return Date()
    }
    
    func calculateTimeSpent(from startTime: Date) -> TimeInterval {
        return Date().timeIntervalSince(startTime)
    }
    
    func saveTimeSpent(_ timeSpent: TimeInterval, for url: URL) {
        let urlString = urlStringToAlphabeticString(url: url)
        var timeData = UserDefaults.standard.dictionary(forKey: urlString) as? [String: Double] ?? [String: Double]()
        let dateKey = getStingFromDate()
        let previousTime = timeData[dateKey] ?? 0
        timeData[dateKey] = previousTime + timeSpent/3600
        UserDefaults.standard.setValue(timeData, forKey: urlString)
        
        var urlsList = UserDefaults.standard.array(forKey: "appsWithTimeData") as? [String] ?? [String]()
        
        UserDefaults.standard.set(urlString, forKey: "lastUpdatedTimeDataAppkey")
        
        if !urlsList.contains(urlString) {
            urlsList.append(urlString)
            UserDefaults.standard.set(urlsList, forKey: "appsWithTimeData")
        }
        
        createTestData()
        
    }
    
    public func fillMissingDates() {
        if let appsWithTimeData = UserDefaults.standard.array(forKey: "appsWithTimeData") as? [String] {
            for app in appsWithTimeData {
                if var timeData = UserDefaults.standard.dictionary(forKey: app) as? [String: Double] {
                    
                    let sortedDates = timeData.keys.sorted()
                    guard let lastSavedDate = sortedDates.last else { continue }
                    
                    var currentDate = Calendar.current.date(byAdding: .day, value: 0, to: Date())!  
                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyy-MM-dd"
                    while formatter.string(from: currentDate) > lastSavedDate {
                        let dateKey = formatter.string(from: currentDate)
                        if timeData[dateKey] == nil {
                            timeData[dateKey] = 0.0
                        }
                        currentDate = Calendar.current.date(byAdding: .day, value: -1, to: currentDate)!
                    }
                    UserDefaults.standard.setValue(timeData, forKey: app)
                }
            }
        }
    }
    
    func urlStringToAlphabeticString(url: URL) -> String {
        let urlString = url.absoluteString
        let allowedCharacterSet = CharacterSet.letters
        let resultString = urlString.unicodeScalars.filter { allowedCharacterSet.contains($0) }.map { String($0) }.joined()
        return resultString
    }
    
    func getUsageTimeForToday(for url: URL) -> Double {
        let urlString = urlStringToAlphabeticString(url: url)
        let timeData = UserDefaults.standard.dictionary(forKey: urlString) as? [String: Double] ?? [String: Double]()
        let dateKey = getStingFromDate()
        let usageTimeToday = timeData[dateKey] ?? 0
        return usageTimeToday
    }
    
    public func scheduleNotification(for url: URL) {
        let usageTimeToday = getUsageTimeForToday(for: url)
        let remainingTime = max((Utils.dailyUsageTimeInSec) - (Int(usageTimeToday * 3600)), 0)
        
        if remainingTime != 0 {
            
            let notificationTime = max(Int(remainingTime) - (UserDefaults.standard.integer(forKey: "notificationTime") * 60), 0)

            if notificationTime != 0 {
                
                let content = UNMutableNotificationContent()
                content.title = "Attention!"
                content.body = "The daily usage time of \(Utils.dailyUsageTimeInSec / 60) minutes has almost been reached."
                content.sound = UNNotificationSound.default

                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(notificationTime), repeats: false)
                
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

                UNUserNotificationCenter.current().add(request) { [weak self] (error) in
                        if self?.isAppInForeground == true {
                            return
                        }
                        
                        if let error = error {
                            print("Error scheduling notification: \(error)")
                        }
                }
                
            }
            
        }
    }
    
    public func calculateStreak(data: [(day: String, hours: Double)]) -> Int {
        var streakCount = 0
        let today = getStingFromDate()
        
        for (day, hours) in data.reversed() {
            if hours > Double(Utils.dailyUsageTimeInSec) / 3600 {
                break
            }
            if day != today {
                streakCount += 1
            }
        }
        return streakCount
    }

    static func padDataWithZeroHourstoChartdataIfNeeded(_ data: [(day: String, hours: Double)]) -> [(day: String, hours: Double)] {
        
            guard !data.isEmpty else {
                return []
            }

            var paddedData = data
            while paddedData.count < 7 {
                let lastDateString = paddedData.last?.day ?? ""
                guard let lastDate = Utils.getDateFromString(dateKey: lastDateString) else {
                    print("Error: Unable to parse date from string.")
                    break
                }
                let nextDate = Calendar.current.date(byAdding: .day, value: 1, to: lastDate)!
                let nextDateString = Utils.formatDateToStringForStorage(nextDate)
                paddedData.append((day: nextDateString, hours: 0))
            }

            return paddedData.map { (day, hours) in
                let date = Utils.getDateFromString(dateKey: day)!
                let dateString = Utils.formatDateToStringForChart(date)
                return (day: dateString, hours: hours)
            }
        }
    
    static func formatDateToStringForChart(_ date: Date) -> String {
            let formatter = DateFormatter()
            formatter.dateFormat = "MMM d"
            return formatter.string(from: date)
    }
    
    static func formatDateToStringForStorage(_ date: Date) -> String {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            return formatter.string(from: date)
        }
    
    static func getDateFromString(dateKey: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.date(from: dateKey)
    }
    
    func getStingFromDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: Date())
    }
    
    public static func formatStringToDateForChart(_ str: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d"
        return formatter.date(from: str) ?? Date()
    }
    
    public static func stringToDateForChart(_ str: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d"
        guard let date = formatter.date(from: str) else {
            fatalError("Invalid date string")
        }
        return date
    }
    
    func formatDateToStringForChart(_ str: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        if let date = formatter.date(from: str) {
            formatter.dateFormat = "MMM d"
            return formatter.string(from: date)
        } else {
            return ""
        }
    }
    
    func createTestData() {
        let dummyURL = URL(string: "test")!
        let dummyURLString = urlStringToAlphabeticString(url: dummyURL)
        var dummyData = [String: Double]()
        
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        for i in 0..<50 {
            let date = Calendar.current.date(byAdding: .day, value: -i, to: currentDate)!
            let dateKey = dateFormatter.string(from: date)
            dummyData[dateKey] = Double.random(in: 0...0.5)
        }
        
        UserDefaults.standard.setValue(dummyData, forKey: dummyURLString)
        
        var urlsList = UserDefaults.standard.array(forKey: "appsWithTimeData") as? [String] ?? [String]()
        
        if !urlsList.contains(dummyURLString) {
            urlsList.append(dummyURLString)
            UserDefaults.standard.set(urlsList, forKey: "appsWithTimeData")
        }
    }

}
