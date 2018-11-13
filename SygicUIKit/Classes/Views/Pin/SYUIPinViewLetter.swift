class SYUIPinViewLetter: SYUIPinViewIcon {
    
    override public var icon: String? {
        didSet {
            iconLabel.text = icon
            iconLabel.font = SygicFonts.with(SygicFonts.bold, size: SygicFontSize.poiIcon)
        }
    }
    
}
 
