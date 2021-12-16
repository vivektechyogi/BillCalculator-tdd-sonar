//
//  TipCalculatorBrain.swift
//  Tipsy
//
//  Created by Matheus Góes on 14/12/21.
//  Copyright © 2021 The App Brewery. All rights reserved.
//

import Foundation

struct TipCalculatorBrain {
    func convertTipToDecimal(tip: String) -> Double {
        let numberFormatter = NumberFormatter()
        numberFormatter.minimumFractionDigits = 1
        
        let value = Double(tip.filter(\.isNumber))
        guard let tipValue = value else { return 0.0 }
        
        let tipValueConvertedToDecimal = tipValue / 100
        let formattedTipValue = numberFormatter.string(from: NSNumber.init(value: tipValueConvertedToDecimal))
        
        guard let result = formattedTipValue else { return 0.0 }
        guard let decimalTipValue = Double(result) else { return 0.0 }
        
        return decimalTipValue
    }
}
