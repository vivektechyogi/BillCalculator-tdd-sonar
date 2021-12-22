//
//  TipCalculatorBrain.swift
//  Tipsy
//
//  Created by Matheus Góes on 14/12/21.
//  Copyright © 2021 The App Brewery. All rights reserved.
//

import Foundation

struct TipCalculatorBrain {
    
    var result: Double = 0.0
    var bill: Bill?
    
    func convertTipToDecimal(tip: String) -> Double {
        let numberFormatter = NumberFormatter()
        numberFormatter.minimumFractionDigits = 1
        
        let value = Double(tip.filter(\.isNumber))
        guard let tipValue = value else { return 0.0 }
        
        let tipValueConvertedToDecimal = tipValue / 100
        return tipValueConvertedToDecimal
    }
    
    mutating func calculateBill(inputValue: String, tip: Double, numberOfPeople: Double) -> String {
        let value = Double(inputValue)
        
        if let value = value {
            result = ((value * tip) + value) / numberOfPeople
        }
        return String(result)
    }
    
    func getBill() -> String {
        return String(format: "%.2f", result)
    }
    
    mutating func setBillInformation(total: String, tip: Double, numberOfPeople: Double) {
        bill = Bill(total: total, tip: tip, numberOfPeople: numberOfPeople)
    }
    
    func getBillInformation() -> String {
        var result = ""
        if let numberOfPeople = bill?.numberOfPeople, let tip = bill?.tip {
            result = "Split between \(Int(numberOfPeople)) people, with \(Int(tip * 100))% tip."
        }
        return result
    }
}
