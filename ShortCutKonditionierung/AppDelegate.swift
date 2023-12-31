import SwiftUI
import Intents
import FamilyControls

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    let appState = AppState.shared
    let utils = Utils()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        print("App launched")
        checkAuthorizations()
        return true
    }
    
    func application(_ application: UIApplication, handlerFor intent: INIntent) -> Any? {
        switch intent {
            
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
            self.appState.launchedAsShortcut = false
        }
    }
    
    func checkAuthorizations() {
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
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, error in
            if let error = error {
                print("Error requesting notification permissions: \(error)")
            } else if !granted {
                print("User did not grant notification permissions")
            } else if granted {
                print("App is authorized to send notification")
            }
        }
        
        
        let ac = AuthorizationCenter.shared

        Task {
            do {
                try await ac.requestAuthorization(for: .individual)
            }
            catch {
                print("error familycontrol Aut")
            }
        }
        
    }
    
}
