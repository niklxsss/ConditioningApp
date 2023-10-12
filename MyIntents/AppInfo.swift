import Foundation

public class AppInfo {
    let appType: AppType
    let name: String
    let url: URL
    let bundleId: String

    init?(appType: AppType) {
            guard
            let name = appType.mappedName(),
            let url = appType.mappedURL(),
            let bundleId = appType.mappedBundelID() else {
            print("Error: Konnte AppInfo nicht erstellen, da einige Werte fehlen.")
            return nil
            }

            self.appType = appType
            self.name = name
            self.url = url
            self.bundleId = bundleId
        }

    func getAppType() -> AppType {
        return self.appType
    }
    
    func getName() -> String {
        return self.name
    }

    func getUrl() -> URL {
        return self.url
    }

    func getBundleId() -> String {
        return self.bundleId
    }
}
