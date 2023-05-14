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
                    //https://medium.com/@contact.jmeyers/complete-list-of-ios-url-schemes-for-apple-apps-and-services-always-updated-800c64f450f
                    
                    //UserDefault "lastUpdatedTimeDataAppkey" Chart anzeigen + Current Streak
                    
                    //Infos zu Studie
                    
                    NavigationBar(selectedTab: $selectedTab)
                    
                }
                .navigationBarTitle(Text("home"), displayMode: .inline)
                
            }
        }
}
