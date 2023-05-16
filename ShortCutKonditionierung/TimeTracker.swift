import Foundation
import SwiftUI
import UserNotifications

public class TimeTracker {
    
    
    func startTracking() -> Date {
        return Date()
    }
    
    func calculateTimeSpent(from startTime: Date) -> TimeInterval {
        return Date().timeIntervalSince(startTime)
    }
    
    func saveTimeSpent(_ timeSpent: TimeInterval, for url: URL) {
        let urlString = urlStringToAlphabeticString(url: url)
        var timeData = UserDefaults.standard.dictionary(forKey: urlString) as? [String: Double] ?? [String: Double]()
        let dateKey = getDateKey()
        print(timeData)
        print(dateKey)
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
        
        //Streak Userdefault data einfügen: pro urlString wird die anzahl an Aufrufen pro Datum gespeichert. bleibt die Tagesanzahl <= 5 wird die Streak forgesetzt oder streak ssetzt sich fort wenn man unter einer std pro Tag bleibt
        
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
    
    func getDateFromKey(dateKey: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.date(from: dateKey)
    }
    
    func getDateKey(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
    
    func urlStringToAlphabeticString(url: URL) -> String {
        let urlString = url.absoluteString
        let allowedCharacterSet = CharacterSet.letters
        let resultString = urlString.unicodeScalars.filter { allowedCharacterSet.contains($0) }.map { String($0) }.joined()
        return resultString
    }
    
    func getDateKey() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: Date())
    }
    
    func getUsageTimeForToday(for url: URL) -> Double {
        let urlString = urlStringToAlphabeticString(url: url)
        let timeData = UserDefaults.standard.dictionary(forKey: urlString) as? [String: Double] ?? [String: Double]()
        let dateKey = getDateKey()
        let usageTimeToday = timeData[dateKey] ?? 0
        return usageTimeToday
    }
    
    public func scheduleNotification(for url: URL) {
        let usageTimeToday = getUsageTimeForToday(for: url)
        let remainingTime = (30 * 60) - (usageTimeToday * 3600)
        let notificationTime = max(Int(remainingTime) - (UserDefaults.standard.integer(forKey: "notificationTime") * 60), 0)

        let content = UNMutableNotificationContent()
        content.title = "Attention!"
        content.body = "The daily usage time of 30 minutes has almost been reached."

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(notificationTime), repeats: false)

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request)
    }

    
    func createTestData() {
        let dummyURL = URL(string: "a1test")!
        let dummyURLString = urlStringToAlphabeticString(url: dummyURL)
        var dummyData = [String: Double]()
        
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        for i in 0..<50 {
            let date = Calendar.current.date(byAdding: .day, value: -i, to: currentDate)!
            let dateKey = dateFormatter.string(from: date)
            dummyData[dateKey] = Double.random(in: 0...8)
        }
        
        UserDefaults.standard.setValue(dummyData, forKey: dummyURLString)
        
        var urlsList = UserDefaults.standard.array(forKey: "appsWithTimeData") as? [String] ?? [String]()
        
        if !urlsList.contains(dummyURLString) {
            urlsList.append(dummyURLString)
            UserDefaults.standard.set(urlsList, forKey: "appsWithTimeData")
        }
    }

}
