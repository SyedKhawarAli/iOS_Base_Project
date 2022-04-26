//
//  Numeric.swift
//  zytrack_ios
//
//  Created by BrainX 3096 on 14/09/2021.
//

import Foundation

extension Numeric {
    func formatted(with groupingSeparator: String? = nil, style: NumberFormatter.Style, locale: Locale = .current) -> String {
        Formatter.number.locale = locale
        Formatter.number.numberStyle = style
        if let groupingSeparator = groupingSeparator {
            Formatter.number.groupingSeparator = groupingSeparator
        }
        return Formatter.number.string(for: self) ?? ""
    }

    var currency: String { formatted(style: .currency) }
    var currencyUS: String { formatted(style: .currency, locale: .englishUS) }
    var currencySwiss: String { formatted(style: .currency, locale: .swissGerman) }
}
