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
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(selectedTab: .constant(.home))
    }
}
