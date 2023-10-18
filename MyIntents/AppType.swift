import Foundation
enum AppType: Int {
    case imessage = 3
    case instagram = 1
    case tiktok = 5
    case snapchat = 4
    case youtube  = 6
    case safari  = 2
    case unknown = 0
    
    func mappedURL() -> URL? {
        switch self {
        case .unknown:
            return URL(string: "unkown://")
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
    
    func mappedBundelID() -> String? {
        switch self {
        case .unknown:
            return "unkown"
        case .imessage:
            return "com.apple.iChat"
        case .instagram:
            return "com.apple.MobileSMS"
        case .tiktok:
            return "com.apple.MobileSMS"
        case .snapchat:
            return "com.apple.MobileSMS"
        case .youtube:
            return "com.apple.MobileSMS"
        case .safari:
            return "com.apple.mobilesafari"
        }
    }
    
    func mappedName() -> String? {
        switch self {
        case .unknown:
            return "unkown"
        case .imessage:
            return "imessage"
        case .instagram:
            return "instagram"
        case .tiktok:
            return "tiktok"
        case .snapchat:
            return "snapchat"
        case .youtube:
            return "youtube"
        case .safari:
            return "safari"
        }
    }
}

