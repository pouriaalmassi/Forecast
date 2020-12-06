//
//  UIFont.swift
//  Forecast
//
//  Created by Pouria Almassi on 5/12/20.
//

import UIKit

extension UIFont {
    class var body: UIFont {
        UIFont.systemFont(ofSize: 16)
    }

    class var scaledBody: UIFont {
        UIFontMetrics(forTextStyle: .body).scaledFont(for: UIFont.body)
    }
}
