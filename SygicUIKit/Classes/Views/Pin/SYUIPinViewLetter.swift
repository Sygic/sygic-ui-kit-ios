class SYUIPinViewLetter: SYUIPinViewIcon {
    
    override public var icon: String? {
        didSet {
            iconLabel.text = icon
            iconLabel.font = SYUIFont.with(SYUIFont.bold, size: SYUIFontSize.poiIcon)
        }
    }
    
}
 
