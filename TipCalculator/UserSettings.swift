//
//  UserSettings.swift
//  TipCalculator
//
//  Created by Varun on 8/7/17.
//  Copyright © 2017 Varun. All rights reserved.
//

import Foundation

private let DEFAULT_TIP = "default_tip"
private let EXIT_TIME = "exit_time"
private let TIP_INDEX = "tip_index"
private let BILL_AMOUNT = "bill_amount"
private let SPLIT_BETWEEN = "split_between"

class UserSettings {
    
    static let sharedInstance = UserSettings()
    
    
    private let userDefaults = UserDefaults.standard
    
    private init(){}
    
    func saveDefaultTip(i: Int) {
        userDefaults.set(i, forKey: DEFAULT_TIP)
        userDefaults.synchronize()
    }
    
    func getDefaultTip()-> Int {
        return userDefaults.integer(forKey: DEFAULT_TIP)
    }
    
    func saveTime() {
        let time = Date().timeIntervalSinceReferenceDate
        userDefaults.set(time, forKey: EXIT_TIME)
        userDefaults.synchronize()
    }
    
    func getTimeIntervalSinceLastSave()-> Double {
        let lastSavedTime = userDefaults.double(forKey: EXIT_TIME)
        let timeIntervalSinceLastSave = (Date().timeIntervalSinceReferenceDate - lastSavedTime) / 60
        return timeIntervalSinceLastSave
    }
    
    func saveBillInfo(tipIndex: Int, billAmount: String, splitBetween: Int) {
        userDefaults.set(tipIndex, forKey: TIP_INDEX)
        userDefaults.set(billAmount, forKey: BILL_AMOUNT)
        userDefaults.set(splitBetween, forKey: SPLIT_BETWEEN)
        userDefaults.synchronize()
    }
    
    func getBillInfo()-> (Int, String, Int) {
        return (userDefaults.integer(forKey: TIP_INDEX),
                userDefaults.string(forKey: BILL_AMOUNT) ?? "",
                userDefaults.integer(forKey: SPLIT_BETWEEN))
    }
}
