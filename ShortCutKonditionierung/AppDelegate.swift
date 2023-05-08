import SwiftUI
import Intents

class AppDelegate: NSObject, UIApplicationDelegate {
    let appState = AppState.shared

    lazy var intentHandler: IntentHandler = {
        return IntentHandler()
    }()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        print("App launched")
        checkAuthorization()
        return true
    }
    
    /*func application(_ application: UIApplication, handlerFor intent: INIntent) -> Any? {
        if intent is OpenAppIntent {
            return OpenAppIntentHandler()
        }
        return nil
    }*/
    
    
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
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
}
    /*import UIKit
    import Intents

    class AppDelegate: NSObject, UIApplicationDelegate {
        let appState = AppState.shared

        func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
            print("App launched")
            checkAuthorization()
            
            // Erstelle eine NSUserActivity für den Siri-Shortcut
            let activity = NSUserActivity(activityType: "com.example.myapp.sayHello")
            activity.title = "Sage Hallo"
            activity.isEligibleForSearch = true
            activity.isEligibleForPrediction = true
            activity.suggestedInvocationPhrase = "Sage Hallo"
            UIApplication.shared.userActivity = activity

            return true
        }
        
        func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
            checkAuthorization()
            
            // Passe die Implementierung an, um die AppIntent-Informationen aus der NSUserActivity zu extrahieren
            if userActivity.activityType == "com.example.myapp.sayHello" {
                print("Handling SayHelloIntent")
                
                DispatchQueue.main.async {
                    self.appState.showShortcutView = true
                    self.appState.selectedShortcut = .sayHello
                }
                return true
            }
            
            print("Not handling SayHelloIntent")
            return false
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
    }*/

    // Hintergrung aktivität
    
    /*func applicationDidEnterBackground(_ application: UIApplication) {
        let taskID = UIApplication.shared.beginBackgroundTask(expirationHandler: nil)
        DispatchQueue.global(qos: .background).async {
            self.handleShortcutRequestsInBackground(taskID: taskID)
        }
    }
    private func handleShortcutRequestsInBackground(taskID: UIBackgroundTaskIdentifier) {
        
        // Überprüfen Sie, ob es ausstehende Shortcut-Anfragen gibt.
        
    }
    
    private func handleShortcutRequest(_ request: SayHelloIntent, completion: @escaping (Bool) -> Void) {
        // Hier können Sie Ihren Code einfügen, um die Shortcut-Anfrage zu verarbeiten.
        // In diesem Beispiel wird einfach die `handle(intent:completion:)`-Methode der IntentHandler-Klasse aufgerufen.
        
        let intentHandler = IntentHandler()
        intentHandler.handle(intent: request) { response in
            completion(response.code == .success)
        }
    }*/

    /*func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        print("about so handle Shortcut")
        handleShortcut(shortcutItem)
        completionHandler(true)
    }

    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        if let intent = userActivity.interaction?.intent as? SayHelloIntent {
            print("Handling SayHelloIntent")
            (intentHandler as SayHelloIntentHandling).handle(intent: intent) { _ in }
            return true
        }
        print("Not handling SayHelloIntent")
        return false
    }

    func handleShortcut(_ shortcutItem: UIApplicationShortcutItem) {
        let originalAppURLScheme =
        shortcutItem.userInfo?["originalAppURLScheme"] as? String
       
        switch shortcutItem.type{
        case "SayHelloIntent":
            let intent = SayHelloIntent()
            (intentHandler as SayHelloIntentHandling).handle(intent: intent) { response in }
            DispatchQueue.main.async {
                self.appState.originalAppURLScheme = originalAppURLScheme
            }
        default:
            break
        }
    }
    
    func handleShortcut(_ shortcutItem: UIApplicationShortcutItem) {
        let originalAppURLScheme =
        shortcutItem.userInfo?["originalAppURLScheme"] as? String
        
        print("in handleShortcut")

        switch shortcutItem.type {
        case "SayHelloIntent":
            print("case SayHelloIntent")
            let intent = SayHelloIntent()
            (intentHandler as SayHelloIntentHandling).handle(intent: intent) { response in
                if response.code == .success {
                    DispatchQueue.main.async {
                        self.appState.originalAppURLScheme = originalAppURLScheme
                        self.appState.showShortcutView = true
                        self.appState.selectedShortcut = .sayHello
                    }
                }
            }
        default:
            break
        }
    }
    

}*/


