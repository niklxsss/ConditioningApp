import SwiftUI
import Charts

struct StatisticsView: View {
    
    @Binding private var selectedTab: Tabs
    
    let timeTracker = TimeTracker()
        
    init(selectedTab: Binding<Tabs>) {
        _selectedTab = selectedTab
    }
        
    var body: some View {
        NavigationView {
            VStack{
                VStack {
                    ScrollView {
                        let urlsList = UserDefaults.standard.array(forKey: "appsWithTimeData") as? [String] ?? [String]()
                        
                        ForEach(urlsList.sorted(), id: \.self) { url in
                            ChartView(url: url)
                        }
                    }
                    Spacer()
                    
                    NavigationBar(selectedTab: $selectedTab)
                    
                }
                .navigationBarTitle(Text("statistics"), displayMode: .inline)
            }
        }
    }
}

struct StatisticsView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        StatisticsView(selectedTab: .constant(.statistics))
    }
}
