//
//  Double.swift
//  Cerva
//
//  Created by Marcio Chagas on 24/05/20.
//  Copyright © 2020 Marcio Chagas. All rights reserved.
//

import Foundation

extension Double {
    var dinheiroString: String {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale(identifier: "pt_BR")

        return currencyFormatter.string(from: self as NSNumber)!
    }
}
