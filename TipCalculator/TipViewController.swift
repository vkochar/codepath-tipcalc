//
//  ViewController.swift
//  TipCalculator
//
//  Created by Varun on 8/6/17.
//  Copyright © 2017 Varun. All rights reserved.
//

import UIKit

class TipViewController: UIViewController {

    @IBOutlet weak var billAmountLabel: UITextField!
    
    @IBOutlet weak var tipPercentageControl: UISegmentedControl!
    @IBOutlet weak var tipLabel: UILabel!
    
    @IBOutlet weak var shareControl: UISegmentedControl!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var numberOfPeopleLabel: UILabel!
    @IBOutlet weak var personImage: UIImageView!
    
    let tipArray = [0.15, 0.18, 0.2]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let greyColor = UIColor(red: 184/255, green: 184/255, blue: 184/255, alpha: 1)
        personImage.tintColor = greyColor
        billAmountLabel.attributedPlaceholder = NSAttributedString(string: "$", attributes: [NSForegroundColorAttributeName:greyColor])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tipPercentageControl.selectedSegmentIndex = UserSettings.sharedInstance.getDefaultTip()
        calculateTip()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    private func calculateTip() {
        
        let billAmount = Double(billAmountLabel.text!) ?? 0
        
        if (billAmount == 0) {
            tipLabel.text = "$"
            totalLabel.text = "$"
            return
        }
        
        let numberOfPeopleToShareBetween = Double(numberOfPeopleLabel.text!) ?? 1
        let myBillAmount = billAmount / numberOfPeopleToShareBetween
        
        let tipAmount = myBillAmount * tipArray[tipPercentageControl.selectedSegmentIndex]
        let totalAmount = myBillAmount + tipAmount
        
        tipLabel.text = String(format: "$%.2f", tipAmount)
        totalLabel.text = String(format: "$%.2f", totalAmount)
    }
    
    @IBAction func didUpdateBillAmount(_ sender: Any) {
        calculateTip()
    }
    
    @IBAction func didSelectTipPercentage(_ sender: Any) {
        calculateTip()
    }
    
    @IBAction func didChangeShareAmongNumber(_ sender: Any) {
        var currentShareAmong = Int(numberOfPeopleLabel.text!) ?? 1
        
        if (shareControl.selectedSegmentIndex == 1) {
            currentShareAmong += 1
        } else if (shareControl.selectedSegmentIndex == 0 && currentShareAmong > 1) {
            currentShareAmong -= 1
        }
        
        shareControl.selectedSegmentIndex = -1
        
        numberOfPeopleLabel.text = "\(currentShareAmong)"
        
        calculateTip()
    }

}

