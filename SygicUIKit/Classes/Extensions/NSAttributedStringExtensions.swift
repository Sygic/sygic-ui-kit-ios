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
        let activeStarFormat: [NSAttributedStringKey: Any] = [.font: currentFont, .foregroundColor: UIColor.rating]
        let inactiveStarFormat: [NSAttributedStringKey: Any] = [.font: currentFont, .foregroundColor: UIColor.actionIndicator]
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
