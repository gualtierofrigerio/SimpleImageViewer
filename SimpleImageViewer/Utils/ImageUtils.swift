//
//  ImageUtils.swift
//  SimpleImageViewer
//
//  Created by Gualtiero Frigerio on 09/02/21.
//

import Foundation
import CoreImage

/// Extention to add utility function to CGImage
extension CGImage {
    
    /// Create a CGImage from a CIImage
    /// - Parameter ciImage: the CIImage from which the CGImage is created
    /// - Returns: An optional CGImage if the conversion is possible
    class func createFrom(ciImage:CIImage) -> CGImage? {
        let context = CIContext(options: nil)
        if let cgImage = context.createCGImage(ciImage, from: ciImage.extent) {
            return cgImage
        }
        return nil
    }
    
    /// Resize the current CGImage to the given size
    /// - Parameter size: size of the new image
    /// - Returns: A new CGImage resized from the current one
    func resize(size:CGSize) -> CGImage {
        let context = CGContext(data: nil,
                                width: Int(size.width),
                                height: Int(size.height),
                                bitsPerComponent: self.bitsPerComponent,
                                bytesPerRow: self.bytesPerRow,
                                space: self.colorSpace ?? CGColorSpace(name: CGColorSpace.sRGB)!,
                                bitmapInfo: self.bitmapInfo.rawValue)
        context?.interpolationQuality = .high
        context?.draw(self, in: CGRect(origin: .zero, size: size))
        return context?.makeImage() ?? self
    }
    
    /// Resize the current CGImage to the maximum size specified by the parameter.
    /// The aspect ratio is preserved
    /// - Parameter maxSize: maximum width/height of the new image
    /// - Returns: A new CGImage resised from the current one
    func resize(maxSize:Int) -> CGImage {
        var newSize = CGSize.zero
        let ratio = CGFloat(width / height)
        if (width > height) {
            newSize.width = CGFloat(maxSize)
            newSize.height = CGFloat(maxSize) / ratio
        }
        else {
            newSize.height = CGFloat(maxSize)
            newSize.width = CGFloat(maxSize) * ratio
        }
        return resize(size: newSize)
    }
}
