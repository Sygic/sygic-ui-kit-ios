//// SYUILangUtils.swift
//
// Copyright (c) 2019 Sygic a.s.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

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
