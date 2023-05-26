import SwiftUI

struct CountdownButton: View {
    
    var timerDuration: Int
    var originalAppURL: URL
    
    @State private var buttonEnabled = false
    @State private var timeRemaining: Int
    @State private var timerCompleted = false
    @State private var startTime: Date?
    @State private var externalAppOpened = false
    
    let utils = Utils()
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    init(originalAppURL: URL, timerDuration: Int) {
        self.originalAppURL = originalAppURL
        self.timerDuration = timerDuration
        self._timeRemaining = State(initialValue: timerDuration)
    }

    var body: some View {
        Button(action: {
            if utils.urlStringToAlphabeticString(url: originalAppURL) != "noURL" {
                externalAppOpened = true
                UIApplication.shared.open(originalAppURL, options: [:], completionHandler: nil)
            }
            
        }) {
            Text("open \(utils.urlStringToAlphabeticString(url: originalAppURL)) in \(timeRemaining)")
                .frame(width: 180, height: 55)
                .background(buttonEnabled || timerCompleted ? Color.blue : Color.gray)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.didEnterBackgroundNotification)) { _ in
            if utils.urlStringToAlphabeticString(url: originalAppURL) != "noURL" && externalAppOpened {
                self.startTime = Date()
                utils.isAppInForeground = false
                utils.scheduleNotification(for: originalAppURL)
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
            utils.isAppInForeground = true
            if externalAppOpened {
                if let startTime = startTime {
                    let timeSpent = utils.calculateTimeSpent(from: startTime)
                    utils.saveTimeSpent(timeSpent, for: originalAppURL)
                    self.startTime = nil
                }
                externalAppOpened = false
            }
        }
        .disabled(!buttonEnabled)
        .onAppear {
            if !timerCompleted {
                startTimer()
            }
        }
        .onReceive(timer) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                buttonEnabled = true
                timerCompleted = true
                timer.upstream.connect().cancel()
            }
        }
        
        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
    }
    
    func startTimer() {
        buttonEnabled = false
        timeRemaining = timerDuration
    }
    
}




               



