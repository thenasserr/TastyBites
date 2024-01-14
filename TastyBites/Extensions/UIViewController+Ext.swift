//
//  UIViewController+Ext.swift
//  TastyBites
//
//  Created by Ibrahim Nasser Ibrahim on 21/12/2023.
//

import UIKit

extension UIViewController {
    /// Get the storyboard identifier for the view controller.
    static var identifier: String {
        return String(describing: self)
    }

    /// Instantiate the view controller from the Main storyboard.
    ///
    /// Example:
    /// ```
    /// let viewController = YourViewController.instantiate()
    /// ```
    ///
    /// - Returns: An instance of the view controller.
    static func instantiate() -> Self {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: identifier) as! Self
    }
}

