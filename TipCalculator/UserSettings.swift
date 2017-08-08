//
//  UserSettings.swift
//  TipCalculator
//
//  Created by Varun on 8/7/17.
//  Copyright © 2017 Varun. All rights reserved.
//

import Foundation

private let DEFAULT_TIP = "default_tip"

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
    
}
