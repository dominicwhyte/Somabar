//
//  SetPumpStateViewController_10.swift
//  SomabarTestApp
//
//  Created by Dominic Whyte on 04/09/16.
//  Copyright © 2016 relayr. All rights reserved.
//

import UIKit

class SetPumpStateViewController_10: UIViewController {
    
    var pump_id = "1"
    var state = "on"
    
    let optionsPumpID = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
    let optionsStates = ["on", "off"]
    
    
    @IBAction func buttonClicked(sender: UIButton) {
        let handler = self.targetForAction(#selector(TargetActionProtocol.initiateConnection(_:ipAddress:sslState:port:)), withSender: self) as? TargetActionProtocol
        if ((handler!.masterPumpEnabled)) {
            print("Pump ID: \(pump_id) State: \(state)")
            if (handler!.connectionStatus) {
                handler?.model.setPumpState(pump_id, state: state)
            }
        }
        else {
            print("Master Pump is disabled")
        }
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (component == 0) {
            return optionsPumpID.count
        }
        else {
            return optionsStates.count
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (component == 0) {
            return optionsPumpID[row]
        }
        else {
            return optionsStates[row]
        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (component == 0) {
            pump_id = optionsPumpID[row]
        }
        else {
            state = optionsStates[row]
        }
    }
    
}
