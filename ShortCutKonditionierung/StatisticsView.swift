import SwiftUI

struct StatisticsView: View {
    
    @Binding private var selectedTab: Tabs
        
        init(selectedTab: Binding<Tabs>) {
            _selectedTab = selectedTab
        }
        
        var body: some View {
            NavigationView{
                VStack {
                        
                    Spacer()
                    
                    NavigationBar(selectedTab: $selectedTab)
                    
                }
                .navigationBarTitle(Text("statistics"), displayMode: .inline)
            }
            
        }
}

struct StatisticsView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        StatisticsView(selectedTab: .constant(.statistics))
    }
}
