//
//  ImageUtils.swift
//  SimpleImageViewer
//
//  Created by Gualtiero Frigerio on 09/02/21.
//

import Foundation
import CoreImage

extension CGImage {
    class func createFrom(ciImage:CIImage) -> CGImage? {
        let context = CIContext(options: nil)
        if let cgImage = context.createCGImage(ciImage, from: ciImage.extent) {
            return cgImage
        }
        return nil
    }
    
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
