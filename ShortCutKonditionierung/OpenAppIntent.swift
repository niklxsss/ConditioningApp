import Intents

public class OpenAppIntent: INIntent {
}

public class OpenAppIntentResponse: INIntentResponse {
    @objc public enum Code: Int {
        case success = 1
    }
    
    public var code: Code {
        get {
            return Code(rawValue: self._code.rawValue)!
        }
        set {
            self._code.rawValue = newValue.rawValue
        }
    }
    
    @objc fileprivate var _code: OpenAppIntentResponseCode = .success
    
    required init(code: OpenAppIntentResponse.Code, userActivity: NSUserActivity?) {
        self.code = code
        super.init()
        self.userActivity = userActivity
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

