import Intents

class IntentHandler: INExtension, OpenAppIntentHandling {

    override func handler(for intent: INIntent) -> Any {
        if intent is OpenAppIntent {
            return self
        }
        
        return self
    }
    
    func handle(intent: OpenAppIntent, completion: @escaping (OpenAppIntentResponse) -> Void) {
        let response = OpenAppIntentResponse(code: .success, userActivity: nil)
        completion(response)
    }
}

