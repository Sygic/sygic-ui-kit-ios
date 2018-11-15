import Foundation

public struct SYUICompassViewModel: SYUICompassProperties {
    public var compassCourse: Double
    public var compassAutoHide: Bool
    
    public init(course: Double,
                autoHide: Bool) {
        compassCourse = course
        compassAutoHide = autoHide
    }
    
    public init(with: SYUICompassProperties) {
        compassCourse = with.compassCourse
        compassAutoHide = with.compassAutoHide
    }
}
