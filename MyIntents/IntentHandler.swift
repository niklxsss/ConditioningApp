import Intents

class IntentHandler: INExtension, SayHelloIntentHandling, CatchABreathIntentHandling, ShockingPicturesIntentHandling, WarningByTextIntentHandling {
    
    static let shared = IntentHandler()
    
    override func handler(for intent: INIntent) -> Any {
        
        if intent is SayHelloIntent {
            return self as SayHelloIntentHandling
        } else if intent is CatchABreathIntent {
            return self as CatchABreathIntentHandling
        } else if intent is ShockingPicturesIntent {
            return self as ShockingPicturesIntentHandling
        } else if intent is WarningByTextIntent{
            return self as WarningByTextIntentHandling
        }
        return self
    }
    
    func handle(intent: SayHelloIntent, completion: @escaping (SayHelloIntentResponse) -> Void) {
        print("handel sayhello")
        AppState.shared.openAppUrl = intent.appURL ?? URL(string: "noURL")!
        let response = SayHelloIntentResponse(code: .continueInApp, userActivity: nil)
        completion(response)
    }
    
    func handle(intent: CatchABreathIntent, completion: @escaping (CatchABreathIntentResponse) -> Void) {
        print("handel catchABreath")
        AppState.shared.openAppUrl = intent.appURL ?? URL(string: "noURL")!
        let response = CatchABreathIntentResponse(code: .continueInApp, userActivity: nil)
        completion(response)
    }
    
    func handle(intent: ShockingPicturesIntent, completion: @escaping (ShockingPicturesIntentResponse) -> Void) {
        print("handel shockingPictures")
        AppState.shared.openAppUrl = intent.appURL ?? URL(string: "noURL")!
        let response = ShockingPicturesIntentResponse(code: .continueInApp, userActivity: nil)
        completion(response)
    }
    
    func handle(intent: WarningByTextIntent, completion: @escaping (WarningByTextIntentResponse) -> Void) {
        print("handel WarningByText")
        AppState.shared.openAppUrl = intent.appURL ?? URL(string: "noURL")!
            
        let response = WarningByTextIntentResponse(code: .continueInApp, userActivity: nil)
        completion(response)
    }
}

