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
                    
                    Spacer()
                    
                    NavigationBar(selectedTab: $selectedTab)
                    
                }
                .navigationBarTitle(Text("statistics"), displayMode: .inline)
            }
        }
    }
}
