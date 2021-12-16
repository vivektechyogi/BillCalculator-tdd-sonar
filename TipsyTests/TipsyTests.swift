//
//  TipsyTests.swift
//  TipsyTests
//
//  Created by Matheus Góes on 09/12/21.
//  Copyright © 2021 The App Brewery. All rights reserved.
//

import XCTest
@testable import Tipsy

class TipsyTests: XCTestCase {
    
    let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CalculatorViewController") as! CalculatorViewController

    func testSelectedTip() {
        let tipCalculatorBrain = TipCalculatorBrain()
        let tip = tipCalculatorBrain.convertTipToDecimal(tip: "10%")
        XCTAssertNotNil(tip)
        XCTAssertEqual(tip, 0.1)
    }
    
    func testBillTextFieldKeyboard() {
        let textField = viewController.billTextField
        guard let billTextField = textField else { return }
        
        XCTAssertEqual(billTextField.keyboardType, UIKeyboardType.numbersAndPunctuation)
    }
    
    func testBillTextFieldValue() {
        let textField = viewController.billTextField
        guard let billTextField = textField else { return }
        
        billTextField.text = "100"
        
        XCTAssertEqual(billTextField.text, "100")
    }

}
