import SwiftUI
import Charts

struct StatisticsView: View {
    
    @Binding private var selectedTab: Tabs
        
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
                            
                            let dataDict = UserDefaults.standard.dictionary(forKey: url) as? [String: Double] ?? [:]
                            let data: [(day: String, hours: Double)] = Array(dataDict)
                                .map { (day: $0.key, hours: $0.value) }
                            
                            GroupBox(label: HStack {
                                Text(url).fontWeight(.bold)
                                Spacer()
                                Text("Streak: 5🔥")
                                //Streak nur einlebenden wenn Streak über 0
                            }) {
                                
                                Chart(data, id: \.day){
                                    BarMark(
                                        x: .value("day", $0.day),
                                        y: .value("hour", $0.hours)
                                    )
                                }
                                //.colorScheme(Color.black)
                                //.chartYScale(domain: 0 ... 8)
                            }
                            .frame(width: 375, height: 200)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(10)
                            .padding(.bottom)
                        }
                    }
                    //.padding()
                    
                    
                    
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
