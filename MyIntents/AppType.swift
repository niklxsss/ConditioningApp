import Foundation
enum AppType: Int {
    case imessage = 3
    case instagram = 1
    case tiktok = 5
    case snapchat = 4
    case youtube  = 6
    case safari  = 2
    
    
    func mappedURL() -> URL? {
        switch self {
        case .imessage:
            return URL(string: "messages://")
        case .instagram:
            return URL(string: "instagram://")
        case .tiktok:
            return URL(string: "tiktok://")
        case .snapchat:
            return URL(string: "snapchat://")
        case .youtube:
            return URL(string: "youtube://")
        case .safari:
            return URL(string: "x-web-search://")
    }
    }
}

