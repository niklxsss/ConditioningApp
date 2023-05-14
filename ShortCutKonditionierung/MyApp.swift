import SwiftUI
import Intents

@main
struct MyApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self)
    private var appDelegate
    private var settings = Settings()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appDelegate.appState)
                .environmentObject(settings)
        }
    }
}

//TODO Notification nach gewisser Zeit senden, zeit stoppen, Diagramme erstellen, Streak einbauen
