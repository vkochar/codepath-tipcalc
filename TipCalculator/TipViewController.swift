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
    
    @IBOutlet weak var totalView: UIView!
    
    let tipArray = [0.15, 0.18, 0.2]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let greyColor = UIColor(red: 184/255, green: 184/255, blue: 184/255, alpha: 1)
        personImage.tintColor = greyColor
        billAmountLabel.attributedPlaceholder = NSAttributedString(string: currencyCode(), attributes: [NSForegroundColorAttributeName:greyColor])
        tipLabel.text = currencyCode()
        totalLabel.text = currencyCode()
        
        let userSettings = UserSettings.sharedInstance
        
        let timeIntervalSinceLastSave = userSettings.getTimeIntervalSinceLastSave()
        
        if (timeIntervalSinceLastSave <= 10){
            let billInfo = userSettings.getBillInfo()
            tipPercentageControl.selectedSegmentIndex = billInfo.0
            billAmountLabel.text = billInfo.1
            shareControl.selectedSegmentIndex = billInfo.2
            changeTotalViewVisibility(show: true)
            print("less than 10 mins")
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let userSettings = UserSettings.sharedInstance
        
        userSettings.saveBillInfo(tipIndex: tipPercentageControl.selectedSegmentIndex,
                                  billAmount: billAmountLabel.text!,
                                  splitBetween: shareControl.selectedSegmentIndex)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tipPercentageControl.selectedSegmentIndex = UserSettings.sharedInstance.getDefaultTip()
        calculateTip()
        billAmountLabel.becomeFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    private func changeTotalViewVisibility(show: Bool) {
        if (show) {
            UIView.animate(withDuration: 0.4, animations: {
                self.totalView.alpha = 1
            })
        } else {
            UIView.animate(withDuration: 0.4, animations: {
                self.totalView.alpha = 0
            })
        }
    }
    
    private func currencyCode()-> String {
        return Locale.current.currencySymbol ?? "$"
    }
    
    private func formatAmount(_ money: Double)-> String? {
        let formatter: NumberFormatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.currency
        formatter.locale = Locale.current
        return formatter.string(for: money)
    }
    
    private func calculateTip() {
        
        let billAmount = Double(billAmountLabel.text!) ?? 0
        
        if (billAmount == 0) {
            tipLabel.text = currencyCode()
            totalLabel.text = currencyCode()
            return
        }
        
        let numberOfPeopleToShareBetween = Double(numberOfPeopleLabel.text!) ?? 1
        let myBillAmount = billAmount / numberOfPeopleToShareBetween
        
        let tipAmount = myBillAmount * tipArray[tipPercentageControl.selectedSegmentIndex]
        let totalAmount = myBillAmount + tipAmount
        
        tipLabel.text = formatAmount(tipAmount)
        totalLabel.text = formatAmount(totalAmount)
    }
    
    @IBAction func didUpdateBillAmount(_ sender: Any) {
        changeTotalViewVisibility(show: billAmountLabel.text != "")
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

