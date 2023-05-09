import Foundation

public class AppState: ObservableObject {
    public static let shared = AppState()
    
    @Published public var showShortcutView = false
    @Published var selectedShortcut: ShortcutType?
    @Published public var originalAppURLScheme: String?
    
    public func resetOriginalAppURLScheme() {
            originalAppURLScheme = nil
        }
}

public enum ShortcutType {
    case sayHello
    case catchABreath
    case shockingPictures
}
