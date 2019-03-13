//// UIFontExtensions.swift
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

import UIKit


public extension UIFont {
    
    public var monospacedDigitFont: UIFont {
        let fontDescriptorAttributes = [UIFontDescriptor.AttributeName.featureSettings: [[UIFontDescriptor.FeatureKey.featureIdentifier: kNumberSpacingType,
                                                                                          UIFontDescriptor.FeatureKey.typeIdentifier: kMonospacedNumbersSelector]]]
        return UIFont(descriptor: fontDescriptor.addingAttributes(fontDescriptorAttributes), size: 0)
    }
    
    public static func scaleFactor(for fontSize: CGFloat, minimalDesiredFontSize: CGFloat) -> CGFloat {
        return minimalDesiredFontSize / fontSize
    }
    
    static func registerFont(bundle: Bundle, fontName: String, fontExtension: String) -> Bool {
        for oldFontFamily in UIFont.familyNames {
            for oldFontName in UIFont.fontNames(forFamilyName: oldFontFamily) {
                if oldFontName == fontName {
                    // font already registerd
                    return true
                }
            }
        }
        
        guard let fontURL = bundle.url(forResource: fontName, withExtension: fontExtension) else {
            fatalError("Couldn't find font \(fontName)")
        }
        
        guard let fontDataProvider = CGDataProvider(url: fontURL as CFURL) else {
            fatalError("Couldn't load data from the font \(fontName)")
        }
        
        guard let font = CGFont(fontDataProvider) else {
            fatalError("Couldn't create font from data")
        }
        
        var error: Unmanaged<CFError>?
        let success = CTFontManagerRegisterGraphicsFont(font, &error)
        guard success else {
            print("Error registering font: maybe it was already registered.")
            return false
        }
        
        return true
    }
    
}
