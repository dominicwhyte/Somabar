//
//  SetMasterPumpEnableViewController_9.swift
//  SomabarTestApp
//
//  Created by Dominic Whyte on 04/09/16.
//  Copyright © 2016 relayr. All rights reserved.
//

import UIKit

class SetMasterPumpEnableViewController_9: UIViewController, UIPickerViewDelegate {
    
    let options = ["on", "off"]
    var state = "on"
    
    @IBAction func buttonClicked(sender: UIButton) {
        print("State: \(state)")
        let handler = self.targetForAction(#selector(TargetActionProtocol.initiateConnection(_:ipAddress:sslState:port:)), withSender: self) as? TargetActionProtocol
        if (handler!.connectionStatus) {
            handler?.model.setMasterPumpEnable(state)
        }
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return options.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(options[row])
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        state = options[row]
        
    }
}
