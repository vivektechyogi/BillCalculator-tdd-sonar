//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {

    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    
    var tipPorcentage: Double?
    
    override func viewDidLoad() {
        billTextField.keyboardType = UIKeyboardType.numbersAndPunctuation
    }

    @IBAction func tipChanged(_ sender: UIButton) {
        let tipPct = sender.currentTitle!
        selectButton(button: tipPct)
        
        tipPorcentage = convertTipToDecimal(tip: tipPct)
        
        billTextField.endEditing(true)
    }
    
    func selectButton(button: String) {
        switch button {
        case "0%":
            zeroPctButton.isSelected = true
            tenPctButton.isSelected = false
            twentyPctButton.isSelected = false
        case "10%":
            tenPctButton.isSelected = true
            zeroPctButton.isSelected = false
            twentyPctButton.isSelected = false
        default:
            twentyPctButton.isSelected = true
            zeroPctButton.isSelected = false
            tenPctButton.isSelected = false
        }
    }
    
    func convertTipToDecimal(tip: String) -> Double {
        let tipPctValue = tip.filter(\.isNumber)
        let decimalValue = (Double(tipPctValue)! / 100)
        return decimalValue
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        setNumberOfPeopleToSplit(target: sender)
    }
    
    func setNumberOfPeopleToSplit(target: UIStepper) {
        let numberOfPeopleToSplit = Int(target.value)
        splitNumberLabel.text = String(numberOfPeopleToSplit)
    }

    @IBAction func calculatePressed(_ sender: UIButton) {
        calculateBillAmountForEachPerson()
    }
    
    func calculateBillAmountForEachPerson() {
        guard let totalBill = Double(billTextField.text!) else { return }
        guard let numberOfPeople = Double(splitNumberLabel.text!) else { return }
        guard let porcentage = tipPorcentage else { return }
        
        let total = ((totalBill * porcentage) + totalBill) / numberOfPeople
    }
}

