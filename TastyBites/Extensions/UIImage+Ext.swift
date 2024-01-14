//
//  UIImage+Ext.swift
//  TastyBites
//
//  Created by Ibrahim Nasser Ibrahim on 31/12/2023.
//

import Foundation
import UIKit

extension UIImage {

    // MARK: - Image Orientation

    /// Returns `true` if the image is in portrait orientation.
    var isPortrait: Bool { size.height > size.width }

    /// Returns `true` if the image is in landscape orientation.
    var isLandscape: Bool { size.width > size.height }

    // MARK: - Image Breadth

    /// The minimum dimension of the image (width or height).
    var breadth: CGFloat { min(size.width, size.height) }

    /// Size with both dimensions equal to the image's breadth.
    var breadthSize: CGSize { .init(width: breadth, height: breadth) }

    /// Rectangular area with both dimensions equal to the image's breadth.
    var breadthRect: CGRect { .init(origin: .zero, size: breadthSize) }

    // MARK: - Circular Masking

    /// Returns a circular masked version of the image.
    var circleMasked: UIImage? {
        guard let cgImage = cgImage?.cropping(to: .init(
                origin: .init(
                    x: isLandscape ? ((size.width - size.height) / 2).rounded(.down) : 0,
                    y: isPortrait ? ((size.height - size.width) / 2).rounded(.down) : 0),
                size: breadthSize)) else {
            return nil
        }

        let format = imageRendererFormat
        format.opaque = false

        return UIGraphicsImageRenderer(size: breadthSize, format: format).image { _ in
            UIBezierPath(ovalIn: breadthRect).addClip()
            UIImage(cgImage: cgImage, scale: format.scale, orientation: imageOrientation)
                .draw(in: .init(origin: .zero, size: breadthSize))
        }
    }
}

