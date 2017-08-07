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
    
    @IBOutlet weak var shareControl: UISegmentedControl!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var numberOfPeopleLabel: UILabel!
    @IBOutlet weak var personImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let greyColor = UIColor(red: 184/255, green: 184/255, blue: 184/255, alpha: 1)
        personImage.tintColor = greyColor
        billAmountLabel.attributedPlaceholder = NSAttributedString(string: "$", attributes: [NSForegroundColorAttributeName:greyColor])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }

}

