//
//  String.swift
//  Forecast
//
//  Created by Pouria Almassi on 5/12/20.
//

import Foundation

extension String {
    var isBlank: Bool {
        allSatisfy { $0.isWhitespace }
    }

    var isNumeric: Bool {
        !isEmpty && rangeOfCharacter(from: .decimalDigits) != nil
    }
}
