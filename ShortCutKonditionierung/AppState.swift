import Foundation

public class AppState: ObservableObject {
    public static let shared = AppState()
    
    @Published public var showShortcutView = false
    @Published var selectedShortcut: ShortcutType?
    @Published public var originalAppURLScheme: String?
}

public enum ShortcutType {
    case sayHello
}
