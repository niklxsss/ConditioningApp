import Foundation

public class AppState: ObservableObject {
    public static let shared = AppState()
    
    @Published public var showShortcutView = false
    @Published public var launchedAsShortcut = false
    @Published public var selectedShortcut: ShortcutType?
    @Published public var lastIntentExecution: Date?
    @Published public var appInfo: AppInfo = AppInfo(appType: .unknown)!
    
}

public enum ShortcutType {
    case catchABreath
    case shockPicture
    case warningByText
}
