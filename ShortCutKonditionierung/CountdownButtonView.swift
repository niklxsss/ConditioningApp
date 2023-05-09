import SwiftUI

struct CountdownButtonView: View {
    @Binding var originalAppURL: URL?
    var timerDuration: Int
    
    @State private var buttonEnabled = false
    @State private var timeRemaining: Int
    
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
            Text("Öffne App (\(timeRemaining))")
                .frame(maxWidth: .infinity)
                .padding()
                .background(buttonEnabled ? Color.green : Color.gray)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
        .disabled(!buttonEnabled)
        .onAppear {
            startTimer()
        }
        .onReceive(timer) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                buttonEnabled = true
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


