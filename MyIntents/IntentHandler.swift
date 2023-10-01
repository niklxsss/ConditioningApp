import Intents

class IntentHandler: INExtension, CatchABreathIntentHandling, ShockingPicturesIntentHandling, WarningByTextIntentHandling {
    
    static let shared = IntentHandler()
    
    override func handler(for intent: INIntent) -> Any {
        
        if intent is CatchABreathIntent {
            return self as CatchABreathIntentHandling
        } else if intent is ShockingPicturesIntent {
            return self as ShockingPicturesIntentHandling
        } else if intent is WarningByTextIntent{
            return self as WarningByTextIntentHandling
        }
        return self
    }
    
    
    func handle(intent: CatchABreathIntent, completion: @escaping (CatchABreathIntentResponse) -> Void) {
        if let lastIntentExecution = AppState.shared.lastIntentExecution, Date().timeIntervalSince(lastIntentExecution) < 15 {
            let response = CatchABreathIntentResponse(code: .success, userActivity: nil)
            completion(response)
        } else {
            print("handle catchABreath")
            
            guard let appType = AppType(rawValue: intent.selectedApp.rawValue) else {
                        print("Error: Invalid or missing appType value")
                        let response = CatchABreathIntentResponse(code: .failure, userActivity: nil)
                        completion(response)
                        return
            }
            print("Selected App: \(appType)")
            AppState.shared.openAppUrl = appType.mappedURL()!
            
            let response = CatchABreathIntentResponse(code: .continueInApp, userActivity: nil)
            completion(response)
        }
        
    }
    
    func handle(intent: ShockingPicturesIntent, completion: @escaping (ShockingPicturesIntentResponse) -> Void) {
        if let lastIntentExecution = AppState.shared.lastIntentExecution, Date().timeIntervalSince(lastIntentExecution) < 15 {
            let response = ShockingPicturesIntentResponse(code: .success, userActivity: nil)
            completion(response)
        } else {
            print("handle ShockingPicturesIntent")
            
            guard let appType = AppType(rawValue: intent.selectedApp.rawValue) else {
                        print("Error: Invalid or missing appType value")
                        let response = ShockingPicturesIntentResponse(code: .failure, userActivity: nil)
                        completion(response)
                        return
            }
            print("Selected App: \(appType)")
            AppState.shared.openAppUrl = appType.mappedURL()!
            
            let response = ShockingPicturesIntentResponse(code: .continueInApp, userActivity: nil)
            completion(response)
        }
    }
    
    func handle(intent: WarningByTextIntent, completion: @escaping (WarningByTextIntentResponse) -> Void) {
        if let lastIntentExecution = AppState.shared.lastIntentExecution, Date().timeIntervalSince(lastIntentExecution) < 15 {
            let response = WarningByTextIntentResponse(code: .success, userActivity: nil)
            completion(response)
        } else {
            print("handle WarningByText")
            
            guard let appType = AppType(rawValue: intent.selectedApp.rawValue) else {
                        print("Error: Invalid or missing appType value")
                        let response = WarningByTextIntentResponse(code: .failure, userActivity: nil)
                        completion(response)
                        return
            }
            print("Selected App: \(appType)")
            AppState.shared.openAppUrl = appType.mappedURL()!
            
            let response = WarningByTextIntentResponse(code: .continueInApp, userActivity: nil)
            completion(response)
        }
    }
}

