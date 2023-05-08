import SwiftUI


struct ContentView: View {
    
    @State private var selectedTab: Tabs = .home
    @EnvironmentObject private var appState: AppState
    
    var body: some View {
        
        if appState.showShortcutView {
                    ShortcutView().environmentObject(appState)
        } else {
            
            switch selectedTab {
                
            case .statistics:
                StatisticsView(selectedTab: $selectedTab)
            case .home:
                HomeView(selectedTab: $selectedTab)
            case .settings:
                SettingsView(selectedTab: $selectedTab)
            }
        }
        
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
