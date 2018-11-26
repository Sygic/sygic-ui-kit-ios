import Foundation

public struct SYUIPinViewViewModel: SYUIPinViewProperties {
    public var icon: String?
    public var color: UIColor?
    public var isSelected: Bool
    public var animated: Bool
    
    public init(icon: String? = nil,
                color: UIColor? = nil,
                selected: Bool = false,
                animated: Bool = true) {
        self.icon = icon
        self.color = color
        self.isSelected = selected
        self.animated = animated
        }
    
    public init(with: SYUIPinViewProperties) {
        self.icon = with.icon
        self.color = with.color
        self.isSelected = with.isSelected
        self.animated = with.animated
    }
}