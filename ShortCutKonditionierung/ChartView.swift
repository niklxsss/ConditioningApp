/*import SwiftUI
import Charts

public struct ChartView: View {
    let url: String
    let utils = Utils()

    @State private var isFlipped = false
    @State private var isZoomed = false

    
    public var body: some View {
        let dataDict = UserDefaults.standard.dictionary(forKey: url) as? [String: Double]
        
        ZStack {
            if !isFlipped {
                buildFrontSideView(dataDict: dataDict)
            }
            else {
                buildBackSideView(dataDict: dataDict)
                    .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
            }
        }
        .rotation3DEffect(.degrees(isFlipped ? 180 : 0), axis: (x: 0, y: 1, z: 0))
        .onTapGesture(count: 2) {
            withAnimation(.spring()) {
                isFlipped.toggle()
            }
        }
    }



    @ViewBuilder
    private func buildFrontSideView(dataDict: [String: Double]?) -> some View {
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

                let convertedData: [(day: String, minutes: Double)] = paddedData
                                                    .map { (day: $0.day, minutes: $0.hours * 60) }

                                Chart(convertedData, id: \.day) {
                                    BarMark(
                                        x: .value("day", $0.day),
                                        y: .value("minutes", $0.minutes)
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

    @ViewBuilder
    private func buildBackSideView(dataDict: [String: Double]?) -> some View {
        GroupBox {
            if let dataDict = dataDict, !dataDict.isEmpty {
            ScrollView {
                VStack {
                    ForEach(dataDict.sorted(by: <).reversed(), id: \.key) { key, value in
                        HStack {
                            Text("\(key):")
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text(utils.timeString(fromHours: value))
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .padding(.vertical, 2)
                    }
                }
            }
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
*/
