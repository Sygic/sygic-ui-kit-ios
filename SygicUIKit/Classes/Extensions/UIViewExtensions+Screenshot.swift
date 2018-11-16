import UIKit

public extension UIView {
    // MARK: - UIImageView creation
    class func grabScreenshot(for view: UIView, withTag tag: Int) -> UIImageView? {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, true, 0.0)
        let context = UIGraphicsGetCurrentContext()
        let viewLayer = view.layer
        if let context = context {
            viewLayer.render(in: context)
        }
        let capturedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        let imageViewOverlay = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: capturedImage?.size.width ?? 0.0, height: capturedImage?.size.height ?? 0.0))
        imageViewOverlay.image = capturedImage
        imageViewOverlay.tag = tag
        return imageViewOverlay
    }
    
    func grabScreenshot(for view: UIView?, withTag tag: Int) -> UIImageView {
        let rect: CGRect
        let viewLayer: CALayer
        if let view = view {
            rect = view.bounds
            viewLayer = view.layer
        } else {
            rect = bounds
            viewLayer = layer
        }
        UIGraphicsBeginImageContextWithOptions(rect.size, true, 0.0)
        let context = UIGraphicsGetCurrentContext()
        if let aContext = context {
            viewLayer.render(in: aContext)
        }
        let capturedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        let imageViewOverlay = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: capturedImage?.size.width ?? 0.0, height: capturedImage?.size.height ?? 0.0))
        imageViewOverlay.image = capturedImage
        imageViewOverlay.tag = tag
        return imageViewOverlay
    }
    
    // MARK: - UIImage creation
    func imageFromLayer() -> UIImage? {
        return imageFromLayer(with: .zero)
    }
    
    func imageFromLayer(with insets: UIEdgeInsets) -> UIImage? {
        var contextSize: CGSize = bounds.size
        contextSize.width -= insets.left + insets.right
        contextSize.height -= insets.top + insets.bottom
        UIGraphicsBeginImageContextWithOptions(contextSize, false, 0)
        if let ctx = UIGraphicsGetCurrentContext() {
            ctx.translateBy(x: -insets.left, y: -insets.top)
            layer.render(in: ctx)
        }
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    func imageFromView() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(bounds.size, isOpaque, 0.0)
        if let aContext = UIGraphicsGetCurrentContext() {
            layer.render(in: aContext)
        }
        let image: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
