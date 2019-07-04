//// SYUIColorPalette.swift
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


/**
 Defines all colors used by SYUIKit components. To customize kit colors, create your own color palette that implements SYUIColorPalette protocol and implements your own desired values.
 */
public protocol SYUIColorPalette {
    
    // MARK: - Basic colors
    var background: UIColor { get }
    var mapBackground: UIColor { get }
    var tableBackground: UIColor { get }
    var textInvert: UIColor { get }
    var bar: UIColor { get }
    var border: UIColor { get }
    var textBody: UIColor { get }
    var textTitle: UIColor { get }
    var action: UIColor { get }
    var error: UIColor { get }
    var warning: UIColor { get }
    var success: UIColor { get }
    var rating: UIColor { get }
    
    // MARK: - Derived colors with opacity
    var textSign: UIColor { get }
    var iconBackground: UIColor { get }
    var shadow: UIColor { get }
    var barShadow: UIColor { get }
    var actionIndicator: UIColor { get }
    var overlay: UIColor { get }
    var mapInfoBackground: UIColor { get }
    
    var textInvertSecondary: UIColor { get }
    var textInvertSubtitle: UIColor { get }
    
    var actionShadow: UIColor { get }
    var errorShadow: UIColor { get }
    
    // MARK: - POI group colors
    var poiGroupTourism         : UIColor { get }
    var poiGroupFoodDrink       : UIColor { get }
    var poiGroupAccomodation    : UIColor { get }
    var poiGroupParking         : UIColor { get }
    var poiGroupPetrolStation   : UIColor { get }
    var poiGroupTransportation  : UIColor { get }
    var poiGroupBank            : UIColor { get }
    var poiGroupShopping        : UIColor { get }
    var poiGroupVehicleServices : UIColor { get }
    var poiGroupSocialLife      : UIColor { get }
    var poiGroupSvcEducation    : UIColor { get }
    var poiGroupSport           : UIColor { get }
    var poiGroupGuides          : UIColor { get }
    var poiGroupEmergency       : UIColor { get }
    
    var signpostDefaultBackground: UIColor { get }
    
}

// MARK: - Default values
public extension SYUIColorPalette {
    
    // MARK: - Basic colors
    var background:         UIColor {
        if #available(iOS 13.0, *) {
            return UIColor(named: "SYUIColorBackground")!
        } else {
            return UIColor(argb: 0xffffffff)
        }
    }
    var mapBackground:      UIColor { return UIColor(argb: 0xffefefea) }
    var tableBackground:    UIColor {
        if #available(iOS 13.0, *) {
            return UIColor(named: "SYUIColorTableBackground")!
        } else {
            return UIColor(argb: 0xffe1e7f2)
        }
    }
    var textInvert:         UIColor {
        if #available(iOS 13.0, *) {
            return UIColor(named: "SYUIColorTextInvert")!
        } else {
            return UIColor(argb: 0xffffffff)
        }
    }
    var bar:                UIColor {
        if #available(iOS 13.0, *) {
            return UIColor(named: "SYUIColorBar")!
        } else {
            return UIColor(argb: 0xfff2f7ff)
        }
    }
    var border:             UIColor {
        if #available(iOS 13.0, *) {
            return UIColor(named: "SYUIColorBorder")!
        } else {
            return UIColor(argb: 0xffd5dbe6)
        }
    }
    var textBody:           UIColor {
        if #available(iOS 13.0, *) {
            return UIColor(named: "SYUIColorTextBody")!
        } else {
            return UIColor(argb: 0xff5c6373)
        }
    }
    var textTitle:          UIColor {
        if #available(iOS 13.0, *) {
            return UIColor(named: "SYUIColorTextTitle")!
        } else {
            return UIColor(argb: 0xff171c26)
        }
    }
    var action:             UIColor {
        if #available(iOS 13.0, *) {
            return UIColor(named: "SYUIColorAction")!
        } else {
            return UIColor(argb: 0xff0080ff)
        }
    }
    var error:              UIColor {
        if #available(iOS 13.0, *) {
            return UIColor(named: "SYUIColorError")!
        } else {
            return UIColor(argb: 0xffe63939)
        }
    }
    var warning:            UIColor {
        if #available(iOS 13.0, *) {
            return UIColor(named: "SYUIColorWarning")!
        } else {
            return UIColor(argb: 0xffe67300)
        }
    }
    var success:            UIColor {
        if #available(iOS 13.0, *) {
            return UIColor(named: "SYUIColorSuccess")!
        } else {
            return UIColor(argb: 0xff339900)
        }
    }
    var rating:             UIColor {
        if #available(iOS 13.0, *) {
            return UIColor(named: "SYUIColorRating")!
        } else {
            return UIColor(argb: 0xfff2ae24)
        }
    }
    
    // MARK: - Derived colors with opacity
    var textSign:           UIColor { return textTitle }
    var iconBackground:     UIColor { return textTitle.withAlphaComponent(0.1) }
    var shadow:             UIColor { return textTitle.withAlphaComponent(0.15) }
    var barShadow:          UIColor { return textTitle.withAlphaComponent(0.15) }
    var actionIndicator:    UIColor { return textTitle.withAlphaComponent(0.25) }
    var overlay:            UIColor { return textTitle.withAlphaComponent(0.5) }
    var mapInfoBackground:  UIColor { return textTitle.withAlphaComponent(0.25) }
    
    var textInvertSecondary:    UIColor { return textInvert.withAlphaComponent(0.75) }
    var textInvertSubtitle:     UIColor { return textInvert.withAlphaComponent(0.25) }
    
    var actionShadow: UIColor { return UIColor(argb: 0xff0059B3).withAlphaComponent(0.5) }
    var errorShadow: UIColor { return UIColor(argb: 0xffB32D2D).withAlphaComponent(0.5) }
    
    // MARK: - POI group colors
    var poiGroupTourism         : UIColor { return UIColor(argb: 0xffE4337B) }
    var poiGroupFoodDrink       : UIColor { return UIColor(argb: 0xffFD883F) }
    var poiGroupAccomodation    : UIColor { return UIColor(argb: 0xff90BD24) }
    var poiGroupParking         : UIColor { return UIColor(argb: 0xff2079D6) }
    var poiGroupPetrolStation   : UIColor { return UIColor(argb: 0xff404040) }
    var poiGroupTransportation  : UIColor { return UIColor(argb: 0xff4CBEE4) }
    var poiGroupBank            : UIColor { return UIColor(argb: 0xff09567E) }
    var poiGroupShopping        : UIColor { return UIColor(argb: 0xffF1CD35) }
    var poiGroupVehicleServices : UIColor { return UIColor(argb: 0xff404040) }
    var poiGroupSocialLife      : UIColor { return UIColor(argb: 0xffBD2043) }
    var poiGroupSvcEducation    : UIColor { return UIColor(argb: 0xffF1CD35) }
    var poiGroupSport           : UIColor { return UIColor(argb: 0xff4A982A) }
    var poiGroupGuides          : UIColor { return UIColor(argb: 0xffB3B3B3) }
    var poiGroupEmergency       : UIColor { return UIColor(argb: 0xffEF3346) }
    
    var signpostDefaultBackground: UIColor { return UIColor(argb: 0xff0080ff) }
    
}
