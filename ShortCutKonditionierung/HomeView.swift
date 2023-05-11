import SwiftUI

struct HomeView: View {
    
    @Binding private var selectedTab: Tabs
        
        init(selectedTab: Binding<Tabs>) {
            _selectedTab = selectedTab
        }
        
        var body: some View {
            NavigationView {
                VStack {
                    
                    Spacer()
                    
                    NavigationBar(selectedTab: $selectedTab)
                    
                }
                .navigationBarTitle(Text("home"), displayMode: .inline)
                
            }
        }
}

/*struct HomeView: View {
    @Binding private var selectedTab: Tabs

    init(selectedTab: Binding<Tabs>) {
        _selectedTab = selectedTab
    }

    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    VStack(spacing: 20) {
                        PerformanceChart(data: [
                            ChartData(date: "2023-05-01", value: 50.0),
                            ChartData(date: "2023-05-02", value: 75.0),
                            ChartData(date: "2023-05-03", value: 60.0),
                            ChartData(date: "2023-05-04", value: 90.0),
                            ChartData(date: "2023-05-05", value: 80.0)
                        ], title: "Chart 1")
                        .frame(height: 200)
                        .background(Color.white)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 1)
                        )
                        
                        PerformanceChart(data: [
                            ChartData(date: "2023-05-01", value: 20.0),
                            ChartData(date: "2023-05-02", value: 40.0),
                            ChartData(date: "2023-05-03", value: 30.0),
                            ChartData(date: "2023-05-04", value: 50.0),
                            ChartData(date: "2023-05-05", value: 60.0)
                        ], title: "Chart 2")
                        .frame(height: 200)
                        .background(Color.white)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 1)
                        )
                        
                        PerformanceChart(data: [
                            ChartData(date: "2023-05-01", value: 70.0),
                            ChartData(date: "2023-05-02", value: 90.0),
                            ChartData(date: "2023-05-03", value: 80.0),
                            ChartData(date: "2023-05-04", value: 60.0),
                            ChartData(date: "2023-05-05", value: 50.0)
                        ], title: "Chart 3")
                        .frame(height: 200)
                        .background(Color.white)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 1)
                        )
                    }
                    .padding()
                }

                Spacer()

                NavigationBar(selectedTab: $selectedTab)
            }
            .navigationBarTitle(Text("home"), displayMode: .inline)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(selectedTab: .constant(.home))
    }
}

struct PerformanceChart: View {
    var data: [ChartData]
    var title: String
    
    var body: some View {
        VStack {
            Text(title)
                .font(.title)
                .padding()
            
            LineChartView(data: data)
                .padding()
        }
    }
}

struct ChartData {
    var date: String
    var value: Double
}


struct LineChartView: View {
    var data: [ChartData]
    
    var body: some View {
        GeometryReader { geometry in
            let xScale = geometry.size.width / CGFloat(data.count - 1)
            let yScale = geometry.size.height / CGFloat(data.maxValue())
            
            Path { path in
                for (index, chartData) in data.enumerated() {
                    let x = CGFloat(index) * xScale
                    let y = geometry.size.height - CGFloat(chartData.value) * yScale
                    
                    if index == 0 {
                        path.move(to: CGPoint(x: x, y: y))
                    } else {
                        path.addLine(to: CGPoint(x: x, y: y))
                    }
                    
                    let dataPoint = CGPoint(x: x, y: y)
                    drawDataPoint(dataPoint: dataPoint, chartData: chartData)
                }
            }
            .stroke(Color.blue, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
            
            // X-Achse
            Path { path in
                path.move(to: CGPoint(x: 0, y: geometry.size.height))
                path.addLine(to: CGPoint(x: geometry.size.width, y: geometry.size.height))
            }
            .stroke(Color.gray)
            
            // Y-Achse
            Path { path in
                path.move(to: CGPoint(x: 0, y: 0))
                path.addLine(to: CGPoint(x: 0, y: geometry.size.height))
            }
            .stroke(Color.gray)
        }
    }
    
    private func drawDataPoint(dataPoint: CGPoint, chartData: ChartData) {
        VStack {
            Text(chartData.date)
                .font(.caption)
                .foregroundColor(.gray)
            
            Text("\(Int(chartData.value))")
                .font(.caption)
                .foregroundColor(.gray)
        }
        .position(dataPoint)
    }
}



extension Array where Element == ChartData {
    func maxValue() -> Double {
        return self.map { $0.value }.max() ?? 0.0
    }
}*/
