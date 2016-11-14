//
//  WritePodTagViewController_3.swift
//  SomabarTestApp
//
//  Created by Dominic Whyte on 04/09/16.
//  Copyright © 2016 relayr. All rights reserved.
//

import UIKit

class WritePodTagViewController_3: UIViewController, UIPickerViewDelegate {
    
    let options = [1, 2, 3, 4, 5, 6, 7]
    
    var podID = 1
    @IBOutlet weak var ingredient_id: UITextField!
    
    @IBAction func buttonClicked(sender: UIButton) {
        if (ingredient_id.text! != "") {
            if let setIngredientsID = Int(ingredient_id.text!) {
                print("Pod ID: \(podID) Ingredient ID: \(ingredient_id.text!)")
                let handler = self.targetForAction(#selector(TargetActionProtocol.initiateConnection(_:ipAddress:sslState:port:)), withSender: self) as? TargetActionProtocol
                if (handler!.connectionStatus) {
                    handler?.model.writePodTag(podID, ingredients_id: setIngredientsID)
                }
            }
            
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
        podID = options[row]
    }
    
    
}
