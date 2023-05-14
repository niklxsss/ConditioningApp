import Foundation

public class AppState: ObservableObject {
    public static let shared = AppState()
    
    @Published public var showShortcutView = false
    @Published public var launchedAsShortcut = false
    @Published public var selectedShortcut: ShortcutType?
    @Published public var openAppUrl: URL = URL(string: "dummy://")!
    
}

public enum ShortcutType {
    case sayHello
    case catchABreath
    case shockPicture
}
