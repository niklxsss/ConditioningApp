import Foundation

public class AppState: ObservableObject {
    public static let shared = AppState()
    
    @Published public var showShortcutView = false
    @Published public var launchedAsShortcut = false
    @Published public var selectedShortcut: ShortcutType?
    @Published public var openAppUrl: URL = URL(string: "noURL")!
    @Published public var lastIntentExecution: Date?
    
}

public enum ShortcutType {
    case catchABreath
    case shockPicture
    case warningByText
}
