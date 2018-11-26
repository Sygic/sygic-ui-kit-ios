public struct SYUIZoomControlViewModel: SYUIZoomControlProperties {
    
    public var icon2D: String
    public var icon3D: String
    public var iconZoomIn: String
    public var iconZoomOut: String
    public var is3D : Bool
    
    public var iconToggle3D: String {
        return is3D ? icon2D : icon3D
    }
    
    public init(icon2D: String,
                icon3D: String,
                iconZoomIn: String,
                iconZoomOut: String,
                is3D: Bool) {
        self.icon2D = icon2D
        self.icon3D = icon3D
        self.iconZoomIn = iconZoomIn
        self.iconZoomOut = iconZoomOut
        self.is3D = is3D
    }
    
    public init(with viewModel: SYUIZoomControlProperties) {
        icon2D = viewModel.icon2D
        icon3D = viewModel.icon3D
        iconZoomIn = viewModel.iconZoomIn
        iconZoomOut = viewModel.iconZoomOut
        is3D = viewModel.is3D
    }
    
}
