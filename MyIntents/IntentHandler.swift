import Intents

class IntentHandler: INExtension, SayHelloIntentHandling {
    
    
    
    override func handler(for intent: INIntent) -> Any {
        if intent is SayHelloIntent {
            return self
        }
        
        return self
    }
    
    /*func handle(intent: SayHelloIntent, completion: @escaping (SayHelloIntentResponse) -> Void) {
        print("Received SayHelloIntent")
        completion(SayHelloIntentResponse(code: .success, userActivity: nil))
    }*/
    
    func handle(intent: SayHelloIntent, completion: @escaping (SayHelloIntentResponse) -> Void) {
        let userActivity = NSUserActivity(activityType: "testAppios.ShortCutKonditionierung")
        completion(SayHelloIntentResponse(code: .success, userActivity: userActivity))
    }


    
}

/*import Intents

class IntentHandler: INExtension {
    override func handler(for intent: INIntent) -> Any {
        if intent is SayHelloIntent {
            return self
        }
        
        return self
    }
    
    func handle(intent: SayHelloIntent, completion: @escaping (SayHelloIntentResponse) -> Void) {
        completion(SayHelloIntentResponse(code: .success, userActivity: nil))
    }
}*/





/*import Intents

public class SayHelloIntent: INIntent {
    @objc dynamic var originalAppURLScheme: String?
    static let expressionKey = "SayHelloIntent"
}

protocol SayHelloIntentHandling {
    func handle(intent: SayHelloIntent, completion: @escaping (SayHelloIntentResponse) -> Void)
}

public class SayHelloIntentResponse: INIntentResponse {
    @objc public var code: SayHelloIntentResponseCode = .unspecified

    required init(code: SayHelloIntentResponseCode, userActivity: NSUserActivity?) {
        self.code = code
        super.init()
        self.userActivity = userActivity
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc public enum SayHelloIntentResponseCode: Int {
        case unspecified = 0
        case success
    }
}*/
