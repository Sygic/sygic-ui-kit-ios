import Foundation

public struct SYUIActionButtonsViewModel {
    public var buttonsViewModels: [SYUIActionButtonProperties]
    
    public var buttonsMargin: CGFloat = 16.0
    public var edgeInsets = UIEdgeInsetsMake(20.0, 8.0, 0, -8.0)
    
    public init(with buttonsViewModels: [SYUIActionButtonProperties] = [SYUIActionButtonProperties]()) {
        self.buttonsViewModels = buttonsViewModels
    }
}
