import Foundation

public struct ActionButtonsViewModel {
    public var buttonsViewModels: [ActionButtonViewModel]
    
    public var buttonsMargin: CGFloat = 16.0
    public var edgeInsets = UIEdgeInsetsMake(20.0, 8.0, 0, -8.0)
    
    public init(with buttonsViewModels: [ActionButtonViewModel] = [ActionButtonViewModel]()) {
        self.buttonsViewModels = buttonsViewModels
    }
}
