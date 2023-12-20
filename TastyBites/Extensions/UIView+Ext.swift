//
//  UIView+Ext.swift
//  TastyBites
//
//  Created by Ibrahim Nasser Ibrahim on 20/12/2023.
//

import UIKit

extension UIView {
  @IBInspectable var cornerRadius: CGFloat {
    get { return cornerRadius }
    set {
      self.layer.cornerRadius = newValue
    }
  }
}
