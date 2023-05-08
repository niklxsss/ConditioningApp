import SwiftUI
import Intents

@main
struct MyApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self)
    private var appDelegate

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appDelegate.appState)
        }
    }
}












/*import SwiftUI
import Intents

@main
struct MyApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self)
    private var appDelegate
    
    var body: some Scene {
        
        WindowGroup {
            ContentView()
                .environmentObject(appDelegate.appState)
                //.onAppear(perform: addShortcuts)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    
    let appState = AppState()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        // Shortcuts hinzufügen
        addShortcuts()
        
        // Überprüfen, ob die App durch einen Shortcut geöffnet wurde
        if let shortcutItem = launchOptions?[UIApplication.LaunchOptionsKey.shortcutItem] as? UIApplicationShortcutItem {
            handleShortcut(shortcutItem)
            return false
        }
        
        return true
    }
    
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {

        handleShortcut(shortcutItem)
        completionHandler(true)
    }
    
    func handleShortcut(_ shortcutItem: UIApplicationShortcutItem) {
        print("App durch Shortcut geöffnet: \(shortcutItem.type)")
        // Überprüfen, welcher Shortcut ausgelöst wurde
        switch shortcutItem.type {
        case "com.example.shortcut1":
            // Shortcut 1 ausgelöst
            DispatchQueue.main.async {
                self.appState.showShortcutView = true
                self.appState.selectedShortcut = .shortcut1
            }
        case "com.example.shortcut2":
            // Shortcut 2 ausgelöst
            DispatchQueue.main.async {
                self.appState.showShortcutView = true
                self.appState.selectedShortcut = .shortcut2
            }
        case "testAppios.ShortCutKonditionierung.HelloShortcutIntent":
            //testShortcutHelloWorld ausgelöst
            DispatchQueue.main.async {
                self.appState.showShortcutView = true
                self.appState.selectedShortcut = .testShortcutHelloWorld
            }
        default:
            break
        }
    }
    
    func addShortcuts() {
        let intent = HelloShortcutIntent()
        intent.suggestedInvocationPhrase = "Starte Hello World"
        if let shortcut3 = INShortcut(intent: intent).shortcutItem {
            UIApplication.shared.shortcutItems = [shortcut3]
        }
    }
    

}
extension INShortcut {
    var shortcutItem: UIApplicationShortcutItem? {
        guard let intent = self.intent as? HelloShortcutIntent else { return nil }
        
        let type = "testAppios.ShortCutKonditionierung.HelloShortcutIntent"
        let title = "Hello World"
        let icon = UIApplicationShortcutIcon(systemImageName: "gear")
        
        return UIApplicationShortcutItem(type: type, localizedTitle: title, localizedSubtitle: nil, icon: icon, userInfo: nil)
    }
}

class AppState: ObservableObject {
    @Published var showShortcutView = false
    @Published var selectedShortcut: ShortcutType?
}

enum ShortcutType {
    case shortcut1
    case shortcut2
    case testShortcutHelloWorld
}

class HelloShortcutIntent: INIntent {
    static let title: LocalizedStringKey = "HelloShortcutIntent"
    static var identifier: String {
        return "HelloShortcutIntent"
    }
    var shortcutTitle: String = "Hello World"
}*/
/*import SwiftUI
import Intents

@main
struct MyApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self)
    private var appDelegate
    
    var body: some Scene {
        
        WindowGroup {
            ContentView()
                .environmentObject(appDelegate.appState)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    
    let appState = AppState()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        // Shortcuts hinzufügen
        addShortcuts()
        
            
        
        // Überprüfen, ob die App durch einen Shortcut geöffnet wurde
        if let shortcutItem = launchOptions?[UIApplication.LaunchOptionsKey.shortcutItem] as? UIApplicationShortcutItem {
            handleShortcut(shortcutItem)
            return false
        }
        
        return true
    }
    
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {

        handleShortcut(shortcutItem)
        completionHandler(true)
    }
    /*func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        if userActivity.activityType == "testAppios.ShortCutKonditionierung.HelloShortcutIntent" {
            // Hier kann die App auf den Shortcut reagieren
            return true
        }
        return false
    }*/
    
    private func handleShortcut(_ shortcutItem: UIApplicationShortcutItem) {
            
            print("App durch Shortcut geöffnet: \(shortcutItem.type)")
            
            // Überprüfen, welcher Shortcut ausgelöst wurde
            switch shortcutItem.type {
            case "com.example.shortcut1":
                // Shortcut 1 ausgelöst
                DispatchQueue.main.async {
                    self.appState.showShortcutView = true
                    self.appState.selectedShortcut = .shortcut1
                }
            case "com.example.shortcut2":
                // Shortcut 2 ausgelöst
                DispatchQueue.main.async {
                    self.appState.showShortcutView = true
                    self.appState.selectedShortcut = .shortcut2
                }
            case "testAppios.ShortCutKonditionierung.HelloShortcutIntent":
                //testShortcutHelloWorld ausgelöst
                DispatchQueue.main.async {
                    self.appState.showShortcutView = true
                    self.appState.selectedShortcut = .testShortcutHelloWorld
                }
            default:
                break
            }
        
        }
    
        func addShortcuts() {
            
            // Shortcut 3
            let shortcut3 = UIApplicationShortcutItem(type: "testAppios.ShortCutKonditionierung.HelloShortcutIntent", localizedTitle: "Hello World", localizedSubtitle: nil, icon: UIApplicationShortcutIcon(systemImageName: "gear"), userInfo: nil)
            
            // Shortcuts zur Shortcut-App hinzufügen
            UIApplication.shared.shortcutItems = [shortcut3]
        }
    
    
}

class AppState: ObservableObject {
    @Published var showShortcutView = false
    @Published var selectedShortcut: ShortcutType?
}

enum ShortcutType {
    case shortcut1
    case shortcut2
    case testShortcutHelloWorld
}*/

    
//----------------------------------------------

/*
import SwiftUI
import Intents

@main
struct MyApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self)
    private var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appDelegate.appState)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    
    let appState = AppState()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        // Shortcuts hinzufügen
        addShortcuts()
        let helloShortcutIntent = HelloShortcutIntent()
        INInteraction(intent: helloShortcutIntent, response: nil).donate(completion: nil)
        
       /* let myAppShortcutIntent = testhelloShortcutIntent()
        INInteraction(intent: myAppShortcutIntent, response: nil).donate(completion: nil)*/
        
        // Registrieren der Intents
           /*let helloShortcutIntent = HelloShortcutIntent()
            let intentResponse = HelloShortcutIntentResponse(code: .success, userActivity: nil)
            INInteraction(intent: helloShortcutIntent, response: intentResponse).donate(completion: nil)*/
        
        //aus yt
        let intent = HelloShortcutIntent()
        let interaction = INInteraction(intent: intent, response: nil)
        interaction.donate {error in if (error as NSError?) != nil {print("interaction donation failed")}}
        
            
        
        // Überprüfen, ob die App durch einen Shortcut geöffnet wurde
        if let shortcutItem = launchOptions?[UIApplication.LaunchOptionsKey.shortcutItem] as? UIApplicationShortcutItem {
            handleShortcut(shortcutItem)
            return false
        }
        
        return true
    }
    
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {

        handleShortcut(shortcutItem)
        completionHandler(true)
    }
    
    private func handleShortcut(_ shortcutItem: UIApplicationShortcutItem) {
            // Hier kannst du die Logik implementieren, die ausgeführt wird,
            // wenn die App durch einen Shortcut geöffnet wird
            print("App durch Shortcut geöffnet: \(shortcutItem.type)")
            
            // Überprüfen, welcher Shortcut ausgelöst wurde
            switch shortcutItem.type {
            case "com.example.shortcut1":
                // Shortcut 1 ausgelöst
                DispatchQueue.main.async {
                    self.appState.showShortcutView = true
                    self.appState.selectedShortcut = .shortcut1
                }
            case "com.example.shortcut2":
                // Shortcut 2 ausgelöst
                DispatchQueue.main.async {
                    self.appState.showShortcutView = true
                    self.appState.selectedShortcut = .shortcut2
                }
            case "com.example.helloWorld":
                //testShortcutHelloWorld ausgelöst
                DispatchQueue.main.async {
                    self.appState.showShortcutView = true
                    self.appState.selectedShortcut = .testShortcutHelloWorld
                }
            default:
                break
            }
        
        }
    
    // Funktion zum Hinzufügen von Shortcuts in der Shortcut-App
        func addShortcuts() {
            
            // Shortcut 3
            let shortcut3 = UIApplicationShortcutItem(type: "HelloShortcutIntent", localizedTitle: "Hello World", localizedSubtitle: nil, icon: UIApplicationShortcutIcon(systemImageName: "gear"), userInfo: nil)
            
            // Shortcuts zur Shortcut-App hinzufügen
            UIApplication.shared.shortcutItems = [shortcut3]
        }
}

class AppState: ObservableObject {
    @Published var showShortcutView = false
    @Published var selectedShortcut: ShortcutType?
}

enum ShortcutType {
    case shortcut1
    case shortcut2
    case testShortcutHelloWorld
}
*/






/*import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        // Hier können Sie die Logik für die Behandlung der URL implementieren
        // Beispiel: URL analysieren und Entscheidungen treffen basierend auf der URL
        return true
    }
}

@main
struct MyApp: App {
    // Zustandsvariable, um zu überprüfen, ob die App über iOS Shortcuts geöffnet wird
    @Environment(\.scenePhase) private var scenePhase
    @State private var isShortcut = false
    @State private var shortcutAppName = ""
    @State private var trackingStartTime: Date?

    var body: some Scene {
        WindowGroup {
            if isShortcut {
                // Ansicht für die Shortcut-Ansicht mit dem Namen der App
                ShortcutView(appName: shortcutAppName)
                    .onAppear {
                        // Starten des Trackings, wenn die Shortcut-Ansicht angezeigt wird
                        trackingStartTime = Date()
                    }
                    .onDisappear {
                        // Beenden des Trackings, wenn die Shortcut-Ansicht verschwindet
                        if let startTime = trackingStartTime {
                            let elapsedTime = Date().timeIntervalSince(startTime)
                            // Hier können Sie den elapsedTime-Wert verwenden, um die Nutzungszeit zu speichern oder anderweitig zu verarbeiten
                            print("Elapsed Time: \(elapsedTime) seconds")
                            trackingStartTime = nil
                        }
                    }
            } else {
                // Ansicht für die normale App-Ansicht
                ContentView()
            }
        }
        .onChange(of: scenePhase) { phase in
            // Überprüfen, ob die App über iOS Shortcuts geöffnet wird
            if case .active = phase {
                if let shortcutItem = UIApplication.shared.shortcutItems?.first {
                    if shortcutItem.type == "com.example.myshortcutsapp.openShortcutView" {
                        self.isShortcut = true
                        self.shortcutAppName = shortcutItem.userInfo?["appName"] as? String ?? ""
                    }
                } else {
                    self.isShortcut = false
                    self.shortcutAppName = ""
                }
            }
        }
    }
}*/

