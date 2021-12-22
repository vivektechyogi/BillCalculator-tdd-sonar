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
    
    var tipCalculatorBrain = TipCalculatorBrain()
    var tipPorcentage: Double?
    
    override func viewDidLoad() {
        billTextField.keyboardType = UIKeyboardType.numbersAndPunctuation
    }

    @IBAction func tipChanged(_ sender: UIButton) {
        let tipPct = sender.currentTitle!
        selectButton(button: tipPct)
        
        tipPorcentage = tipCalculatorBrain.convertTipToDecimal(tip: tipPct)
        
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
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        setNumberOfPeopleToSplit(value: sender.value)
    }
    
    func setNumberOfPeopleToSplit(value: Double) {
        let numberOfPeopleToSplit = Int(value)
        splitNumberLabel.text = String(numberOfPeopleToSplit)
    }

    @IBAction func calculatePressed(_ sender: UIButton) {
        guard let inputValue = billTextField.text else { return }
        guard let porcentage = tipPorcentage else { return }
        guard let numberOfPeople = Double(splitNumberLabel.text!) else { return }
        
        tipCalculatorBrain.calculateBill(inputValue: inputValue, tip: porcentage, numberOfPeople: numberOfPeople)
        tipCalculatorBrain.setBillInformation(total: inputValue, tip: porcentage, numberOfPeople: numberOfPeople)
        self.performSegue(withIdentifier: "goToResult", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            let bill = tipCalculatorBrain.getBill()
            let billInformation = tipCalculatorBrain.getBillInformation()

            let destinationVC = segue.destination as! ResultsViewController
            destinationVC.settings = billInformation
            destinationVC.total = bill
        }
    }
}

