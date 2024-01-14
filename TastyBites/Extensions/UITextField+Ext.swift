//
//  UITextField+Ext.swift
//  TastyBites
//
//  Created by Ibrahim Nasser Ibrahim on 01/01/2024.
//

import UIKit

@IBDesignable
class CustomTextField: UITextField {

    // MARK: - Properties

    /// An optional image to be displayed on the left side of the text field.
    @IBInspectable var image: UIImage? {
        didSet {
            setupLeftView()
        }
    }

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTextField()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupTextField()
    }

    // MARK: - Setup

    /// Common setup for the text field.
    private func setupTextField() {
        cornerRadius = 16
        backgroundColor = .systemBackground
        setupLeftView()
    }

    /// Setup the left view, which can include an optional image.
    private func setupLeftView() {
        leftViewMode = .always

        // Create a container view for the left view
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 24, height: 24))

        // Create an image view with the provided image
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.frame = view.bounds
        view.addSubview(imageView)

        // Set the container view as the left view
        leftView = view
    }
}
