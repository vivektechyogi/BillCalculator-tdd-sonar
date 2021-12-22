//
//  TipsyUnitTest.swift
//  TipsyUnitTest
//
//  Created by Matheus Góes on 16/12/21.
//  Copyright © 2021 The App Brewery. All rights reserved.
//

import XCTest
@testable import Tipsy

class TipsyUnitTest: XCTestCase {

    var sut: CalculatorViewController!
        
        override func setUpWithError() throws {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            sut = storyboard.instantiateViewController(withIdentifier: "CalculatorViewController") as? CalculatorViewController
            sut.loadViewIfNeeded()
        }
        
        override func tearDownWithError() throws {
            sut = nil
        }
        
        func testBillTextFieldAreConnected() throws {
            _ = try XCTUnwrap(sut.billTextField, "the bill input UITextField is not connected")
        }

        func testSelectedTip() throws {
            let tipCalculatorBrain = TipCalculatorBrain()
            let tip = tipCalculatorBrain.convertTipToDecimal(tip: "75%")

            XCTAssertNotNil(tip, "tip value can not be nil")
            XCTAssertEqual(tip, 0.75, "tip value does not match with the input value")
        }
        
        func testBillTextFieldKeyboard() throws {
            let textField = try XCTUnwrap(sut.billTextField, "the bill input UITextField is not connected")
            
            XCTAssertEqual(textField.keyboardType, UIKeyboardType.numbersAndPunctuation, "billTextField does not have numbers and ponctuation type set")
        }
        
        func testBillTextFieldContent() throws {
            let textField = try XCTUnwrap(sut.billTextField, "the bill input UITextField is not connected")
            textField.text = "123"

            XCTAssertNotNil(textField.text, "billTextField UITextField can not be nil")
            XCTAssertEqual("123", textField.text, "billTextField UITextField does not have the same value as the input")
        }
        
        func testNumberOfPeopleToSplitTheBill() throws {
            let splitNumberLabel = sut.splitNumberLabel
            
            sut.setNumberOfPeopleToSplit(value: 3.0)
            
            XCTAssertEqual("3", splitNumberLabel?.text, "splitNumberLabel content does not match with the stepper value passed")
        }
        
        func testCalculateBill() throws {
            let textField = try XCTUnwrap(sut.billTextField, "the bill input UITextField is not connected")
            let twentyPctButtonTitle = try XCTUnwrap(sut.twentyPctButton.titleLabel?.text, "the twentyPctButton title cannot be empty")
            let stepperValue = try XCTUnwrap(sut.stepper.value, "the stepper value cannot be nil")
            var tipCalculatorBrain = TipCalculatorBrain()
            
            textField.text = "467.90"
            
            guard let inputValue = textField.text else { return }
            let tip = tipCalculatorBrain.convertTipToDecimal(tip: twentyPctButtonTitle)
            
            let result = tipCalculatorBrain.calculateBill(inputValue: inputValue, tip: tip, numberOfPeople: stepperValue)

            XCTAssertNotNil(result, "the calc result cannot be nil")
            XCTAssertEqual("280.74", result, "result value does not match with value expected")
        }

}
