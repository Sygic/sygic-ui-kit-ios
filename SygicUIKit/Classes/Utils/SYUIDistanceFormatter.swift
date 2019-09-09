//// SYUIDistanceFormatter.swift
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


/// Distance units.
public enum SYUIDistanceUnits {
    case kilometers
    case milesFeet
    case milesYards
    
    /// Speed format for units.
    public var speedTitle: String {
        switch self {
        case .kilometers: return LS("km/h")
        case .milesFeet, .milesYards: return LS("mph")
        }
    }
}

/// Distance units formatter.
public class SYUIGeneralFormatter {
    
    private static let kmToMile = 0.62137119
    private static let mileToKm = 1.609344
    
    /// Formats distance from unit to another unit.
    ///
    /// - Parameters:
    ///   - distance: Distance to format.
    ///   - fromUnit: Units format from.
    ///   - toUnit: Units format to.
    /// - Returns: Formatted distance.
    public static func format(_ distance: Double, from fromUnit: SYUIDistanceUnits, to toUnit: SYUIDistanceUnits) -> Double {
        var constant = 1.0
        if fromUnit == .kilometers && (toUnit == .milesYards || toUnit == .milesFeet) {
            constant = kmToMile
        } else if (fromUnit == .milesYards || fromUnit == .milesFeet) && toUnit == .kilometers {
            constant = mileToKm
        }
        return distance * constant;
    }
    
}

/// Units formatter.
public class SYUIFormattersUnits {
    
    public static var clockFormat: String = "HH:mm"
    public static var distanceUnits: SYUIDistanceUnits = .kilometers
    
}
