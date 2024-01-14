//
//  String+Ext.swift
//  TastyBites
//
//  Created by Ibrahim Nasser Ibrahim on 20/12/2023.
//

import Foundation

extension String {
    /// Convert the string to a URL.
    ///
    /// Example:
    /// ```
    /// let urlString = "https://example.com"
    /// if let url = urlString.asURL {
    ///     // Use the URL
    /// }
    /// ```
    var asURL: URL? {
        return URL(string: self)
    }
}

