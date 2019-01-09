import Foundation

private class LocalizedHelper {
    static let SygicKitLocalizationBundleName = "SygicUIKitStrings"
    static let SygicKitLocalizationTableName = "SygicKit"
    static let LocalizedStringNotFound = "LocalizedStringNotFound"
}

/**
 Function to localize strings into currentlanguage
 
 - parameters:
 - key: The string to be localized
 - comment: Help comment for translator
 
 - returns:
 Returns localized string into current language
 */

public func LS(_ key: String?, _ comment: String = "") -> String {
    if let key = key {
        
        var localizedString: String = LocalizedHelper.LocalizedStringNotFound
        
        let podBundle = Bundle(for: LocalizedHelper.self)
        if let localizationBundleUrl = podBundle.url(forResource: LocalizedHelper.SygicKitLocalizationBundleName, withExtension: "bundle") {
            if let localizationBundle = Bundle(url: localizationBundleUrl) {
                localizedString = localizationBundle.localizedString(forKey: key, value: LocalizedHelper.LocalizedStringNotFound, table:  LocalizedHelper.SygicKitLocalizationTableName)
            }
        }
        if localizedString == LocalizedHelper.LocalizedStringNotFound {
            localizedString = NSLocalizedString(key, comment: comment)
        }
        
        return localizedString
    } else {
        return ""
    }
}
