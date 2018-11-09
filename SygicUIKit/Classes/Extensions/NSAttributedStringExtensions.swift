import Foundation

public extension NSAttributedString {
    public static func starRating(with rating: Double, outOfTotal numberOfStars: Int, fontSize: CGFloat) -> NSAttributedString {
        guard let currentFont = SygicFonts.with(SygicFonts.iconFont, size: fontSize) else { return NSAttributedString() }
        let activeStarFormat: [NSAttributedStringKey: Any] = [.font: currentFont, .foregroundColor: UIColor.rating]
        let inactiveStarFormat: [NSAttributedStringKey: Any] = [.font: currentFont, .foregroundColor: UIColor.actionIndicator]
        let starString = NSMutableAttributedString()
        
        for i in 0..<numberOfStars {
            //Full star
            if rating >= Double(i+1) {
                starString.append(NSAttributedString(string: SygicIcon.ratingFull, attributes: activeStarFormat))
            }
            else if rating > Double(i) {
                let leftHalf = NSMutableAttributedString(string: SygicIcon.ratingHalfLeft, attributes: activeStarFormat)
                let rightHalf = NSMutableAttributedString(string: SygicIcon.ratingHalfRight, attributes: inactiveStarFormat)
                starString.append(leftHalf)
                starString.append(rightHalf)
            }
            else {
                starString.append(NSAttributedString(string: SygicIcon.ratingFull, attributes: inactiveStarFormat))
            }
        }
        return starString
    }
}
