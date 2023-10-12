import Intents

class IntentHandler: INExtension, CatchABreathIntentHandling, ShockingPicturesIntentHandling, WarningByTextIntentHandling {
    
    static let shared = IntentHandler()
    
    override func handler(for intent: INIntent) -> Any {
        return self
    }
    
    func handle(intent: CatchABreathIntent, completion: @escaping (CatchABreathIntentResponse) -> Void) {
        handleIntent(intent: intent, appTypeRawValue: intent.selectedApp.rawValue, successCompletion: {
            completion(CatchABreathIntentResponse(code: .continueInApp, userActivity: nil))
        }, failureCompletion: {
            completion(CatchABreathIntentResponse(code: .failure, userActivity: nil))
        })
    }
    
    func handle(intent: ShockingPicturesIntent, completion: @escaping (ShockingPicturesIntentResponse) -> Void) {
        handleIntent(intent: intent, appTypeRawValue: intent.selectedApp.rawValue, successCompletion: {
            completion(ShockingPicturesIntentResponse(code: .continueInApp, userActivity: nil))
        }, failureCompletion: {
            completion(ShockingPicturesIntentResponse(code: .failure, userActivity: nil))
        })
    }
    
    func handle(intent: WarningByTextIntent, completion: @escaping (WarningByTextIntentResponse) -> Void) {
        handleIntent(intent: intent, appTypeRawValue: intent.selectedApp.rawValue, successCompletion: {
            completion(WarningByTextIntentResponse(code: .continueInApp, userActivity: nil))
        }, failureCompletion: {
            completion(WarningByTextIntentResponse(code: .failure, userActivity: nil))
        })
    }
    
    private func handleIntent(intent: INIntent, appTypeRawValue: Int, successCompletion: @escaping () -> Void, failureCompletion: @escaping () -> Void) {
        if let lastIntentExecution = AppState.shared.lastIntentExecution, Date().timeIntervalSince(lastIntentExecution) < 15 {
            successCompletion()
            return
        }
        
        guard let appType = AppType(rawValue: appTypeRawValue) else {
            print("Error: Invalid or missing appType value")
            failureCompletion()
            return
        }
        
        if let appInfo = AppInfo(appType: appType) {
            AppState.shared.appInfo = appInfo
            print("Selected App: \(appInfo.getName())")
            successCompletion()
        } else {
            fatalError("AppInfo konnte nicht initialisiert werden, da erforderliche Werte fehlen.")
        }
    }
}


