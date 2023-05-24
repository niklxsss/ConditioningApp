import SwiftUI
import Charts

public struct ChartView: View {
    let url: String
    let utils = Utils()

    public var body: some View {
        let dataDict = UserDefaults.standard.dictionary(forKey: url) as? [String: Double]
        
        GroupBox(label: HStack {
            
            Text(url).fontWeight(.bold)
            Spacer()
            
            if let dataDict = dataDict {
                
                let data: [(day: String, hours: Double)] = Array(dataDict)
                    .map { (day: $0.key, hours: $0.value) }
                    .sorted { $0.day < $1.day }
                
                let streak = utils.calculateStreak(data: data)
                if streak >= 3 {
                    Text("Streak: \(streak)🔥")
                }
            }
        }) {
            if let dataDict = dataDict {
                
                let data: [(day: String, hours: Double)] = Array(dataDict)
                    .map { (day: $0.key, hours: $0.value) }
                    .sorted { $0.day < $1.day }
                
                let lastSevenDaysData = Array(data.suffix(7))
                let paddedData = Utils.padDataWithZeroHourstoChartdataIfNeeded(lastSevenDaysData)
                
                Chart(paddedData, id: \.day){
                    BarMark(
                        x: .value("day", $0.day),
                        y: .value("hour", $0.hours)
                    )
                    
                }
                .foregroundColor(Color.blue)
                
            } else {
                Text("no data available")
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .frame(width: 375, height: 200)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
        .padding(.bottom)
        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
    }
}
