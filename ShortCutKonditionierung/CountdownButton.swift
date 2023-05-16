import SwiftUI

struct CountdownButton: View {
    
    var timerDuration: Int
    var originalAppURL: URL
    
    @State private var buttonEnabled = false
    @State private var timeRemaining: Int
    @State private var timerCompleted = false
    @State private var startTime: Date?
    
    let timeTracker = TimeTracker()
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    init(originalAppURL: URL, timerDuration: Int) {
        self.originalAppURL = originalAppURL
        self.timerDuration = timerDuration
        self._timeRemaining = State(initialValue: timerDuration)
    }

    var body: some View {
        Button(action: {
            
            timeTracker.scheduleNotification(for: originalAppURL)
            
            if urlStringToAlphabeticString(url: originalAppURL) != "dummy" {
                    startTime = Date()
                    UIApplication.shared.open(originalAppURL, options: [:], completionHandler: nil)
            }
            
        }) {
            Text("open \(urlStringToAlphabeticString(url: originalAppURL)) in \(timeRemaining)")
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
                let timeSpent = timeTracker.calculateTimeSpent(from: startTime)
                timeTracker.saveTimeSpent(timeSpent, for: originalAppURL)
                self.startTime = nil
            }
        }
    }
    
    func startTimer() {
        buttonEnabled = false
        timeRemaining = timerDuration
    }
    
    func urlStringToAlphabeticString(url: URL) -> String {
        let urlString = url.absoluteString
        let allowedCharacterSet = CharacterSet.letters
        let resultString = urlString.unicodeScalars.filter { allowedCharacterSet.contains($0) }.map { String($0) }.joined()
        return resultString
    }
}




               



