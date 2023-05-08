import Intents

class StartTimerIntent: INIntent {
    @objc dynamic var duration: NSNumber? // Duration in seconds
    
    init(duration: NSNumber?) {
        self.duration = duration
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
