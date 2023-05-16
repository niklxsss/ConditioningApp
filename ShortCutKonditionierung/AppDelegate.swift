import SwiftUI
import Intents

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    let appState = AppState.shared
    let timeTracker = TimeTracker()
 
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        print("App launched")
        checkAuthorization()
        requestNotificationPermission()
        timeTracker.fillMissingDates()
        return true
    }
    
    func application(_ application: UIApplication, handlerFor intent: INIntent) -> Any? {
                switch intent {
                case is SayHelloIntent:
                
                    print("Handling SayHelloIntent")
                    openShortCutIntent(.sayHello)
                    return IntentHandler()
                
                case is CatchABreathIntent:
                    print("Handling CatchABreathIntent")
                    openShortCutIntent(.catchABreath)
                    return IntentHandler()
                    
                case is ShockingPicturesIntent:
                    print("Handling ShockingPicturesIntent")
                    openShortCutIntent(.shockPicture)
                    return IntentHandler()
                    
                case is WarningByTextIntent:
                    print("Handling WarningByTextIntent")
                    openShortCutIntent(.warningByText)
                    return IntentHandler()
                    
                default:
                    return nil
                }
    }

    func openShortCutIntent(_ shortcut: ShortcutType) {
        DispatchQueue.main.async {
            self.appState.showShortcutView = true
            self.appState.selectedShortcut = shortcut
        }
    }

    func checkAuthorization() {
        INPreferences.requestSiriAuthorization { status in
            switch status {
                case .authorized:
                    print("App is authorized to add shortcuts.")
                case .denied:
                    print("App is not authorized to add shortcuts.")
                case .notDetermined:
                    print("Authorization status not determined.")
                case .restricted:
                    print("App is restricted from adding shortcuts.")
                default:
                    break
                }
        }
    }
    
    func requestNotificationPermission() {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, error in
                if let error = error {
                    print("Error requesting notification permissions: \(error)")
                } else if !granted {
                    print("User did not grant notification permissions")
                } else if granted {
                    print("App is authorized to send notification")
                }
            }
        }
}
