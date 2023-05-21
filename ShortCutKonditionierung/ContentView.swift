import SwiftUI


struct ContentView: View {
    
    @EnvironmentObject private var appState: AppState
    @State private var selectedTab: Tabs = AppState().showShortcutView ? .shortcut : .home

    var body: some View {
        if appState.showShortcutView && !appState.launchedAsShortcut{
            ShortcutView(selectedTab: $selectedTab)
                            .environmentObject(appState)
                            .onAppear {
                                selectedTab = .shortcut
                                appState.launchedAsShortcut = true
                            }
        } else {
            switch selectedTab {
            case .statistics:
                StatisticsView(selectedTab: $selectedTab)
            case .home:
                HomeView(selectedTab: $selectedTab)
                    .environmentObject(appState)
            case .settings:
                SettingsView(selectedTab: $selectedTab)
            case .shortcut:
                ShortcutView(selectedTab: $selectedTab).environmentObject(appState)
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
