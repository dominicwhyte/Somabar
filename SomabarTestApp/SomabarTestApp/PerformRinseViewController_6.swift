//
//  PerformRinseViewController_6.swift
//  SomabarTestApp
//
//  Created by Dominic Whyte on 04/09/16.
//  Copyright © 2016 relayr. All rights reserved.
//

import UIKit

class PerformRinseViewController_6: UIViewController {
    
    @IBOutlet weak var duration: UITextField!

    @IBAction func buttonClicked(sender: UIButton) {
        var setDuration = duration.text!
        if (setDuration == "") {
            setDuration = "5"
        }
        if let SetDurationNumber = Double(setDuration) {
            print("Duration: \(String(SetDurationNumber))")
            let handler = self.targetForAction(#selector(TargetActionProtocol.initiateConnection(_:ipAddress:sslState:port:)), withSender: self) as? TargetActionProtocol
            if (handler!.connectionStatus) {
                handler?.model.performRinse(SetDurationNumber)
            }
        }
        
    }
}
