import Foundation

class TimeTracker {
    
    func startTracking() -> Date {
        return Date()
    }
    
    func calculateTimeSpent(from startTime: Date) -> TimeInterval {
        return Date().timeIntervalSince(startTime)
    }
    
    func saveTimeSpent(_ timeSpent: TimeInterval, for url: URL) {
        let urlString = urlStringToAlphabeticString(url: url)
        var data = UserDefaults.standard.dictionary(forKey: urlString) as? [String: Double] ?? [String: Double]()
        let dateKey = getDateKey()
        print(data)
        print(dateKey)
        let previousTime = data[dateKey] ?? 0
        data[dateKey] = previousTime + timeSpent/3600
        UserDefaults.standard.setValue(data, forKey: urlString)
        
        var urlsList = UserDefaults.standard.array(forKey: "appsWithTimeData") as? [String] ?? [String]()
        
        UserDefaults.standard.set(urlString, forKey: "lastUpdatedTimeDataAppkey")
        
        if !urlsList.contains(urlString) {
            urlsList.append(urlString)
            UserDefaults.standard.set(urlsList, forKey: "appsWithTimeData")
        }
        // test data
        createTestData()
        
        //Streak Userdefault data einfügen: pro urlString wird die anzahl an Aufrufen pro Datum gespeichert. bleibt die Tagesanzahl <= 5 wird die Streak forgesetzt oder streak ssetzt sich fort wenn man unter einer std pro Tag bleibt
        
        
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
