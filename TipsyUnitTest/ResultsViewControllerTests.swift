//
//  ResultsViewControllerTests.swift
//  TipsyUnitTest
//
//  Created by Matheus Góes on 21/12/21.
//  Copyright © 2021 The App Brewery. All rights reserved.
//

import XCTest
@testable import Tipsy

class ResultsViewControllerTests: XCTestCase {

    var sut: ResultsViewController!
    
    override func setUpWithError() throws {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        sut = storyboard.instantiateViewController(withIdentifier: "ResultsViewController") as? ResultsViewController
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testIfBillCalculationIsShowing() throws {
        var tipCalculatorBrain = TipCalculatorBrain()
        
        let bill = tipCalculatorBrain.calculateBill(inputValue: "467.90", tip: 0.2, numberOfPeople: 2)
        
        let totalLabel = try XCTUnwrap(sut.totalLabel, "the total label is not available/connected")
        totalLabel.text = bill
        
        XCTAssertEqual(bill, totalLabel.text, "the value passed to total label is not equal to the value registred in the label")
    }
    
    func testIfSettingsInformationIsCorrect() throws {
        var tipCalculatorBrain = TipCalculatorBrain()
        
        tipCalculatorBrain.setBillInformation(total: "56.32", tip: 0.1, numberOfPeople: 2)
        let billInformation = tipCalculatorBrain.getBillInformation()
        
        let settingsInformationLabel = try XCTUnwrap(sut.settingsLabel, "the settings label is not available/connected")
        settingsInformationLabel.text = billInformation
        
        XCTAssertEqual(billInformation, settingsInformationLabel.text)
        
    }

}
