import SwiftUI
import Intents

class AppDelegate: UIResponder, UIApplicationDelegate {
    let appState = AppState.shared

   lazy var intentHandler: IntentHandler = {
        return IntentHandler()
    }()
    


    
    func application(_ application: UIApplication, handlerFor intent: INIntent) -> Any? {

                switch intent {
                    case is SayHelloIntent:
                    print("Handling SayHelloIntent")
                    
                    DispatchQueue.main.async {
                                    self.appState.showShortcutView = true
                                    self.appState.selectedShortcut = .sayHello
                                    
                                    // Hier speichern Sie den Namen der auslösenden App
                        
                                    }
                                
                            
                        return IntentHandler()
                case is OpenAppIntent:
                    print("Handling 'OpenApp'Intent")
                    return true
                    default:
                        return nil
                }
       
            }
    
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        if userActivity.activityType == "testAppios.ShortCutKonditionierung" {
            handleOpenAppIntent()
            return true
        }
        return false
    }

    func handleOpenAppIntent() {
        DispatchQueue.main.async {
            self.appState.showShortcutView = true
            self.appState.selectedShortcut = .sayHello
        }
    }


    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        print("App launched")
        checkAuthorization()
        return true
    }
    /*func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        print("open via url")
        if url.scheme == "yourAppScheme" {
            // Hier können Sie die App auf den gewünschten Bildschirm navigieren oder Aktionen ausführen.
        }
        return true
    }*/

    
    /*func application(_ application: UIApplication, handlerFor intent: INIntent) -> Any? {
        if intent is OpenAppIntent {
            return OpenAppIntentHandler()
        }
        return nil
    }*/
    
    
    /*func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        checkAuthorization()
        if let intent = userActivity.interaction?.intent as? SayHelloIntent {
            print("Handling SayHelloIntent")
            (intentHandler as SayHelloIntentHandling).handle(intent: intent) { response in
                if response.code == .success {
                    DispatchQueue.main.async {
                        //self.appState.originalAppURLScheme = intent.originalAppURLScheme
                        self.appState.showShortcutView = true
                        self.appState.selectedShortcut = .sayHello
                    }
                }
            }
            return true
        }
        print("Not handled SayHelloIntent")
        return false
    }*/
    
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
}
import Foundation

extension NSUserActivity {
    static var openApp: NSUserActivity {
        let activity = NSUserActivity(activityType: "testAppios.ShortCutKonditionierung.openApp")
        activity.title = "Open Your App"
        activity.userInfo = ["url": "yourAppScheme://"]
        activity.isEligibleForHandoff = false
        activity.isEligibleForSearch = false
        activity.isEligibleForPublicIndexing = false
        activity.isEligibleForPrediction = true
        return activity
    }
}

   
