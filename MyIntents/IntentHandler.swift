import Intents

class IntentHandler: INExtension, SayHelloIntentHandling, CatchABreathIntentHandling, ShockingPicturesIntentHandling {
    
    override func handler(for intent: INIntent) -> Any {
        
        if intent is SayHelloIntent {
            return self as SayHelloIntentHandling
        } else if intent is CatchABreathIntent {
            return self as CatchABreathIntentHandling
        } else if intent is ShockingPicturesIntent {
            return self as ShockingPicturesIntentHandling
        }
        return self
    }
    
    func handle(intent: SayHelloIntent, completion: @escaping (SayHelloIntentResponse) -> Void) {
        print("handel sayhello")
        let userActivity = NSUserActivity(activityType: NSStringFromClass(SayHelloIntent.self))
        let response = SayHelloIntentResponse(code: .success, userActivity: userActivity)
        completion(response)
    }
    
    func handle(intent: CatchABreathIntent, completion: @escaping (CatchABreathIntentResponse) -> Void) {
        print("handel catchABreath")
        let response = CatchABreathIntentResponse(code: .success, userActivity: nil)
        completion(response)
    }
    
    func handle(intent: ShockingPicturesIntent, completion: @escaping (ShockingPicturesIntentResponse) -> Void) {
        print("handel shockingPictures")
        let response = ShockingPicturesIntentResponse(code: .success, userActivity: nil)
        completion(response)
    }
}

