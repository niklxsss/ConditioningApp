import SwiftUI

struct CountdownButton: View {
    @Binding var originalAppURL: URL?
    var timerDuration: Int
    
    @State private var buttonEnabled = false
    @State private var timeRemaining: Int
    @State private var timerCompleted = false
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    init(originalAppURL: Binding<URL?>, timerDuration: Int) {
        self._originalAppURL = originalAppURL
        self.timerDuration = timerDuration
        self._timeRemaining = State(initialValue: timerDuration)
    }

    var body: some View {
        Button(action: {
            openOriginalApp()
        }) {
            Text("open app (\(timeRemaining))")
                .frame(width: 150)
                .padding()
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
    }

    func startTimer() {
        buttonEnabled = false
        timeRemaining = timerDuration
    }

    func openOriginalApp() {
        if let url = originalAppURL {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}



