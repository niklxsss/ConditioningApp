import SwiftUI
import Intents

class AppDelegate: UIResponder, UIApplicationDelegate {
    let appState = AppState.shared

   /*lazy var intentHandler: IntentHandler = {
        return IntentHandler()
    }()*/
    
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        if userActivity.activityType == NSStringFromClass(SayHelloIntent.self) {
            print("app kommt in den Vordergrund")
            return true
        }
        return false
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        print("App launched")
        checkAuthorization()

        // Überprüfen, ob die App durch einen Siri Shortcut gestartet wurde
        if let activityDictionary = launchOptions?[.userActivityDictionary] as? [AnyHashable: Any],
           let userActivity = activityDictionary["UIApplicationLaunchOptionsUserActivityKey"] as? NSUserActivity {
            // Überprüfen, ob der Activity-Typ mit einem deiner Intents übereinstimmt
            if userActivity.activityType == "testAppios.ShortCutKonditionierung.sayHello" {
                print("App started from SayHelloIntent shortcut")
                // Hier kannst du die entsprechenden Aktionen ausführen
            }
        }

        return true
    }
    
    

    
    /*func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        print("App launched")
        checkAuthorization()
        return true
    }*/
    
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
                    
                default:
                    return nil
                }
    }
    
    /*func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        guard let intent = userActivity.interaction?.intent else {
            return false
        }

        switch intent {
        case is SayHelloIntent:
            print("Handling SayHelloIntent")
            openShortCutIntent(.sayHello)
            
        case is CatchABreathIntent:
            print("Handling CatchABreathIntent")
            openShortCutIntent(.catchABreath)
            
        case is ShockingPicturesIntent:
            print("Handling ShockingPicturesIntent")
            openShortCutIntent(.shockPicture)
            
        default:
            return false
        }
        
        return true
    }*/

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
}
