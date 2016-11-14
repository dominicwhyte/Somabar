//
//  ObtainStatusViewController_1.swift
//  SomabarTestApp
//
//  Created by Dominic Whyte on 04/09/16.
//  Copyright © 2016 relayr. All rights reserved.
//

import UIKit

class ObtainStatusViewController_1: UIViewController {
    
    @IBAction func buttonClicked(sender: UIButton) {
        print("No parameters")
        let handler = self.targetForAction(#selector(TargetActionProtocol.initiateConnection(_:ipAddress:sslState:port:)), withSender: self) as? TargetActionProtocol
        if (handler!.connectionStatus) {
        handler?.model.obtainCurrentDeviceStatus()
        }
    }
    
}
