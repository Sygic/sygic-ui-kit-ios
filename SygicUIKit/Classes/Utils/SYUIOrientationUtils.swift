//// SYUIOrientationUtils.swift
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


/// Device orientation enum.
public enum SYUIDeviceOrientation {
    /// Portrait device orientation.
    case portrait
    /// Landscape device orienatation.
    case landscape
    
    /// If orientation of a device is portrait.
    ///
    /// - Returns: Boolean value whether device is in portrait or not.
    public func isPortrait() -> Bool {
        return self == .portrait
    }
    
    /// If orientation of a device is landscape.
    ///
    /// - Returns: Boolean value whether device is in landscape or not.
    public func isLandscape() -> Bool {
        return !isPortrait()
    }
}

/// Device orientation utils.
public class SYUIDeviceOrientationUtils {
    
    /// Device orientation information for any size.
    ///
    /// - Parameter size: For what size is orientation detected.
    /// - Returns: Whether orientation based on `size` is portrait or landscape.
    public static func orientation(for size: CGSize) -> SYUIDeviceOrientation {
        return size.height > size.width ? .portrait : .landscape
    }
    
    public static func orientationSize(for portrait: CGFloat, landscape: CGFloat, traitCollection: UITraitCollection) -> CGFloat {
        return self.isLandscape(traitCollection) ? landscape : portrait
    }
    
    public static func orientationSize(for portrait: CGFloat, landscape: CGFloat) -> CGFloat {
        guard let traitCollection = self.currentTraitCollection() else { return portrait }
        return self.orientationSize(for: portrait, landscape: landscape, traitCollection: traitCollection)
    }
    
    /// Current trait collection.
    ///
    /// - Returns: Current trait collection.
    public static func currentTraitCollection() -> UITraitCollection? {
        return UIApplication.shared.keyWindow?.traitCollection
    }
    
    public static func isLandscape(_ traitCollection: UITraitCollection) -> Bool {
        return UIApplication.shared.statusBarOrientation.isLandscape
    }
    
    public static func isLandscape() -> Bool {
        guard let traitCollection = self.currentTraitCollection() else { return false }
        return self.isLandscape(traitCollection)
    }
    
    public static func isPortrait(_ traitCollection: UITraitCollection) -> Bool {
        return (traitCollection.horizontalSizeClass == .compact && traitCollection.verticalSizeClass != traitCollection.horizontalSizeClass);
    }

    public static func isPortrait() -> Bool {
        if let traitCollection = self.currentTraitCollection() {
            return self.isPortrait(traitCollection)
        }
        return false
    }
    
    /// Current device orientation.
    ///
    /// - Returns: Current device orientation.
    public static func currentOrientation() -> UIInterfaceOrientation {
        return UIApplication.shared.statusBarOrientation
    }
    
}
