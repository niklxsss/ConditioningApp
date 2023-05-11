import SwiftUI

enum Tabs: Int{
    case statistics = 0
    case home = 1
    case settings = 2
    case shortcut = 3
}

struct NavigationBar: View {
    
    @EnvironmentObject var appState: AppState
    @Binding var selectedTab: Tabs
    
    var body: some View{
        
        HStack{
            
            if appState.showShortcutView{
                Button{
                    selectedTab = .shortcut
                } label: {
                    CustomNavBarButton(buttonText: "shortcut", imageName: "star", isAcitve: selectedTab == .shortcut)
                }
                    .tint(Color("icons-secondary"))
            }
            
            Button{
                selectedTab = .statistics
    
            } label: {
                CustomNavBarButton(buttonText: "statistics", imageName: "chart.bar", isAcitve: selectedTab == .statistics)
            }
            .tint(Color("icons-secondary"))
            
            Button{
                selectedTab = .home
            } label: {
                CustomNavBarButton(buttonText: "home", imageName: "house", isAcitve: selectedTab == .home)
            }
            .tint(Color("icons-secondary"))
            
            Button{
                selectedTab = .settings
            } label: {
                CustomNavBarButton(buttonText: "settings", imageName: "gear", isAcitve: selectedTab == .settings)
            }
            .tint(Color("icons-secondary"))
            
        }
        .frame(height: 80)
        .frame(maxHeight: 95, alignment: .bottom)
        
    }
}



struct NavigationBar_Previews: PreviewProvider{
    
    static var previews :some View{
        NavigationBar(selectedTab: .constant(.home))
.previewInterfaceOrientation(.portrait)
    }
}

