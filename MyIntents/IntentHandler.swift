import Intents

class IntentHandler: INExtension, SayHelloIntentHandling {
    
    override func handler(for intent: INIntent) -> Any {
        if intent is SayHelloIntent {
            return self
        }
        
        return self
    }
    
    func handle(intent: SayHelloIntent, completion: @escaping (SayHelloIntentResponse) -> Void) {
        print("Received SayHelloIntent")
        let userActivity = NSUserActivity(activityType: "testAppios.ShortCutKonditionierung.sayHello")
        completion(SayHelloIntentResponse(code: .success, userActivity: userActivity))
    }
    
}
