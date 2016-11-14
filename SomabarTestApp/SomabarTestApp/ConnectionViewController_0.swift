//
//  ConnectionViewController_0.swift
//  SomabarTestApp
//
//  Created by Dominic Whyte on 04/09/16.
//  Copyright © 2016 relayr. All rights reserved.
//

import UIKit

class ConnectionViewController_0: UIViewController {
    
    @IBOutlet weak var ipAddressTextField: UITextField!
    @IBOutlet weak var sslStateSwitch: UISwitch!
    @IBOutlet weak var portTextField: UITextField!
    
    @IBAction func connectButtonClicked(sender: UIButton) {
        if (ipAddressTextField.text != "") {
            if (portTextField.text != "") {
                let ipAddressSelected = ipAddressTextField.text!
                if let portSelected = UInt16(portTextField.text!) {
                    let sslStateSelected : Bool = sslStateSwitch.on
                    let handler = self.targetForAction(#selector(TargetActionProtocol.initiateConnection(_:ipAddress:sslState:port:)), withSender: self) as? TargetActionProtocol
                    handler?.initiateConnection("4556922598362711264", ipAddress: ipAddressSelected, sslState: sslStateSelected, port : portSelected)
                }
            }
        }
    }




}
