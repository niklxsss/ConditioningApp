import Foundation
import SwiftUI
import UserNotifications

public class Utils {
    
    var isAppInForeground: Bool = true
    
    func urlStringToAlphabeticString(url: URL) -> String {
        let urlString = url.absoluteString
        let allowedCharacterSet = CharacterSet.letters
        let resultString = urlString.unicodeScalars.filter { allowedCharacterSet.contains($0) }.map { String($0) }.joined()
        return resultString
    }

}
