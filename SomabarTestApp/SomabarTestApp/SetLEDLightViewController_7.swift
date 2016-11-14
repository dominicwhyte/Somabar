//
//  SetLEDLightViewController_7.swift
//  SomabarTestApp
//
//  Created by Dominic Whyte on 04/09/16.
//  Copyright © 2016 relayr. All rights reserved.
//

import UIKit

class SetLEDLightViewController_7: UIViewController, UIPickerViewDelegate {
    
    var led_name = "blue"
    var state = "on"
    
    let optionsLED = ["blue", "green", "white"]
    let optionsStates = ["on", "off", "blink"]

    @IBAction func buttonClicked(sender: UIButton) {
        print("Led Name: \(led_name) State: \(state)")
        let handler = self.targetForAction(#selector(TargetActionProtocol.initiateConnection(_:ipAddress:sslState:port:)), withSender: self) as? TargetActionProtocol
        if (handler!.connectionStatus) {
            handler?.model.setLEDState(led_name, state: state)
        }
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (component == 0) {
        return optionsLED.count
        }
        else {
            return optionsStates.count
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (component == 0) {
            return optionsLED[row]
        }
        else {
            return optionsStates[row]
        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (component == 0) {
            led_name = optionsLED[row]
        }
        else {
            state = optionsStates[row]
        }
    }
}
