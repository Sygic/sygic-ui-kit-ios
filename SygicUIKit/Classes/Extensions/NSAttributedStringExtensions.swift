//// NSAttributedStringExtensions.swift
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

public extension NSAttributedString {
    
    /// Attributed string showing stars rating.
    ///
    /// - Parameters:
    ///   - rating: Number of fulfill stars. Stars can be also half-fulfilled.
    ///   - numberOfStars: Number of all stars.
    ///   - fontSize: Size of stars.
    /// - Returns: `NSAttributedString` representing stars.
    public static func starRating(with rating: Double, outOfTotal numberOfStars: Int, fontSize: CGFloat) -> NSAttributedString {
        guard let currentFont = SYUIFont.with(SYUIFont.iconFont, size: fontSize) else { return NSAttributedString() }
        let activeStarFormat: [NSAttributedString.Key: Any] = [.font: currentFont, .foregroundColor: UIColor.rating]
        let inactiveStarFormat: [NSAttributedString.Key: Any] = [.font: currentFont, .foregroundColor: UIColor.actionIndicator]
        let starString = NSMutableAttributedString()
        
        for i in 0..<numberOfStars {
            //Full star
            if rating >= Double(i+1) {
                starString.append(NSAttributedString(string: SYUIIcon.ratingFull, attributes: activeStarFormat))
            }
            else if rating > Double(i) {
                let leftHalf = NSMutableAttributedString(string: SYUIIcon.ratingHalfLeft, attributes: activeStarFormat)
                let rightHalf = NSMutableAttributedString(string: SYUIIcon.ratingHalfRight, attributes: inactiveStarFormat)
                starString.append(leftHalf)
                starString.append(rightHalf)
            }
            else {
                starString.append(NSAttributedString(string: SYUIIcon.ratingFull, attributes: inactiveStarFormat))
            }
        }
        return starString
    }
    
}
