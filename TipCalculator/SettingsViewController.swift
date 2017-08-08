//
//  SettingsViewController.swift
//  TipCalculator
//
//  Created by Varun on 8/7/17.
//  Copyright © 2017 Varun. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var defaultTipControl: UISegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        defaultTipControl.selectedSegmentIndex = UserSettings.sharedInstance.getDefaultTip()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didChangeDefaultTip(_ sender: UISegmentedControl) {
        UserSettings.sharedInstance.saveDefaultTip(i: sender.selectedSegmentIndex)
    }
    @IBAction func didClickDone(_ sender: Any) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
