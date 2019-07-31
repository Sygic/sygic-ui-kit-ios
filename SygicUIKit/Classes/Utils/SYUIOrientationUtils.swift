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
    
    /// Returns given portrait or landscape size based on trait collection.
    /// - Parameter portrait: Portrait orientation size.
    /// - Parameter landscape: Landscape orientation size.
    /// - Parameter traitCollection: Traint collection to determine correct return value.
    /// - Returns: Orientation size based on actual trait collection.
    public static func orientationSize(for portrait: CGFloat, landscape: CGFloat, traitCollection: UITraitCollection) -> CGFloat {
        return self.isLandscapeLayout(traitCollection) ? landscape : portrait
    }
    
    /// Returns given portrait or landscape size based on actual trait collection.
    /// - Parameter portrait: Portraint orientation size.
    /// - Parameter landscape: Landscape orientation size.
    /// - Returns: Orientation size based on actual trait collection.
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
    
    /// If layout should be for portrait orientation size based on trait collection.
    /// - Parameter traitCollection: Traint collection to determine layout orientation.
    public static func isPortraitLayout(_ traitCollection: UITraitCollection) -> Bool {
        return (traitCollection.horizontalSizeClass == .compact && traitCollection.verticalSizeClass == .regular)
    }
    
    /// If defice is in portrait orientation based on status bar orientation.
    public static func isPortraitStatusBar() -> Bool {
        return UIApplication.shared.statusBarOrientation.isPortrait
    }
    
    /// If layout should be for landscape orientation size based on trait collection.
        /// - Parameter traitCollection: Traint collection to determine layout orientation.
    public static func isLandscapeLayout(_ traitCollection: UITraitCollection) -> Bool {
        return !isPortraitLayout(traitCollection)
    }
    
    /// If defice is in landscape orientation based on status bar orientation.
    public static func isLandscapeStatusBar() -> Bool {
        return UIApplication.shared.statusBarOrientation.isLandscape
    }
    
}
