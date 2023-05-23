import SwiftUI

struct CountdownButton: View {
    
    var timerDuration: Int
    var originalAppURL: URL
    
    @State private var buttonEnabled = false
    @State private var timeRemaining: Int
    @State private var timerCompleted = false
    @State private var startTime: Date?
    
    let utils = Utils()
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    init(originalAppURL: URL, timerDuration: Int) {
        self.originalAppURL = originalAppURL
        self.timerDuration = timerDuration
        self._timeRemaining = State(initialValue: timerDuration)
    }

    var body: some View {
        Button(action: {
            
            utils.scheduleNotification(for: originalAppURL)
            
            if utils.urlStringToAlphabeticString(url: originalAppURL) != "dummy" {
                    startTime = Date()
                    UIApplication.shared.open(originalAppURL, options: [:], completionHandler: nil)
            }
            
        }) {
            Text("open \(utils.urlStringToAlphabeticString(url: originalAppURL)) in \(timeRemaining)")
                .frame(width: 180, height: 55)
                .background(buttonEnabled || timerCompleted ? Color.blue : Color.gray)
                .foregroundColor(.white)
                .cornerRadius(10)
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
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
            if let startTime = startTime {
                let timeSpent = utils.calculateTimeSpent(from: startTime)
                utils.saveTimeSpent(timeSpent, for: originalAppURL)
                self.startTime = nil
            }
        }
    }
    
    func startTimer() {
        buttonEnabled = false
        timeRemaining = timerDuration
    }
    
}




               



