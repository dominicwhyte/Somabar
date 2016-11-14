//
//  SetWifiCredentialsViewController_5.swift
//  SomabarTestApp
//
//  Created by Dominic Whyte on 04/09/16.
//  Copyright © 2016 relayr. All rights reserved.
//

import UIKit

class SetWifiCredentialsViewController_5: UIViewController {
    
    @IBOutlet weak var ssid: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var warningLabel: UILabel!
    
    @IBAction func buttonClicked(sender: UIButton) {
        if (Utilities.checkIfValidInput(ssid.text!) && Utilities.checkIfValidInput(password.text!)) {
            warningLabel.textColor = UIColor.blackColor()
            print("ssid: \(ssid.text!) password: \(password.text!)")
            let handler = self.targetForAction(#selector(TargetActionProtocol.initiateConnection(_:ipAddress:sslState:port:)), withSender: self) as? TargetActionProtocol
            if (handler!.connectionStatus) {
                handler?.model.setWiFiCredentials(ssid.text!, password: password.text!)
            }
        }
            //invalid input
        else {
            print("Invalid ssid or password entered")
            warningLabel.textColor = UIColor.redColor()
        }
        
    }
}
