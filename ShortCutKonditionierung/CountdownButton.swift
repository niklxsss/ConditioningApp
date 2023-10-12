import SwiftUI

struct CountdownButton: View {
    
    var timerDuration: Int
    var appURL: URL
    var appName: String
    
    @State private var buttonEnabled = false
    @State private var timeRemaining: Int
    @State private var timerCompleted = false
    @State private var startTime: Date?
    @State private var externalAppOpened = false
    
    @EnvironmentObject private var appState: AppState
    
    let utils = Utils()
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    init(appInfo: AppInfo, timerDuration: Int) {
        self.appURL = appInfo.url
        self.timerDuration = timerDuration
        self.appName = appInfo.name
        self._timeRemaining = State(initialValue: timerDuration)
    }

    var body: some View {
        Button(action: {
            
                if timerCompleted && buttonEnabled {
                    self.appState.lastIntentExecution = Date()
                }
                externalAppOpened = true
                UIApplication.shared.open(appURL, options: [:], completionHandler: nil)
            
            
        }) {
            Text("open \(appName) in \(timeRemaining)")
                .frame(width: 180, height: 55)
                .background(buttonEnabled || timerCompleted ? Color.blue : Color.gray)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.didEnterBackgroundNotification)) { _ in
            if externalAppOpened {
                utils.isAppInForeground = false
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
            utils.isAppInForeground = true
            if externalAppOpened {
                externalAppOpened = false
            }
            resetTimer()
        }
        .disabled(!buttonEnabled)
        .onAppear {
            resetTimer()
        }
        .onReceive(timer) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                buttonEnabled = true
                timerCompleted = true
            }
        }
        
        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
    }
    
    func startTimer() {
        buttonEnabled = false
        timeRemaining = timerDuration
    }
    
    func resetTimer() {
        timerCompleted = false
        startTimer()
    }
    
}




               



