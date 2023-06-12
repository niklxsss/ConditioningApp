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
            print("handel catchABreath")
            AppState.shared.openAppUrl = intent.appURL ?? URL(string: "noURL")!
            let response = CatchABreathIntentResponse(code: .continueInApp, userActivity: nil)
            completion(response)
        }
        
    }
    
    func handle(intent: ShockingPicturesIntent, completion: @escaping (ShockingPicturesIntentResponse) -> Void) {
        if let lastIntentExecution = AppState.shared.lastIntentExecution, Date().timeIntervalSince(lastIntentExecution) < 15 {
            let response = ShockingPicturesIntentResponse(code: .success, userActivity: nil)
            completion(response)
        } else {
            print("handel shockingPictures")
            AppState.shared.openAppUrl = intent.appURL ?? URL(string: "noURL")!
            let response = ShockingPicturesIntentResponse(code: .continueInApp, userActivity: nil)
            completion(response)
        }
    }
    
    func handle(intent: WarningByTextIntent, completion: @escaping (WarningByTextIntentResponse) -> Void) {
        if let lastIntentExecution = AppState.shared.lastIntentExecution, Date().timeIntervalSince(lastIntentExecution) < 15 {
            let response = WarningByTextIntentResponse(code: .success, userActivity: nil)
            completion(response)
        } else {
            print("handel WarningByText")
            AppState.shared.openAppUrl = intent.appURL ?? URL(string: "noURL")!
            let response = WarningByTextIntentResponse(code: .continueInApp, userActivity: nil)
            completion(response)
        }
    }
}

