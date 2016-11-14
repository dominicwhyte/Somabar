//
//  ReadPodTagViewController_4.swift
//  SomabarTestApp
//
//  Created by Dominic Whyte on 04/09/16.
//  Copyright © 2016 relayr. All rights reserved.
//

import UIKit

class ReadPodTagViewController_4: UIViewController {
    
    let options = ["1", "2", "3", "4", "5", "6", "7", "All"]
    
    var pod_id: String = "1"
    
    @IBAction func buttonClicked(sender: UIButton) {
        print("Pod ID: \(pod_id)")
        let handler = self.targetForAction(#selector(TargetActionProtocol.initiateConnection(_:ipAddress:sslState:port:)), withSender: self) as? TargetActionProtocol
        if (handler!.connectionStatus) {
            handler?.model.readPodTag(pod_id)
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
        pod_id = options[row]
        
    }
}
