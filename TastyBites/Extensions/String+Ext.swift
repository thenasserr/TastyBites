//
//  String+Ext.swift
//  TastyBites
//
//  Created by Ibrahim Nasser Ibrahim on 20/12/2023.
//

import Foundation

extension String {
  var asURL: URL? {
    return URL(string: self)
  }
}
