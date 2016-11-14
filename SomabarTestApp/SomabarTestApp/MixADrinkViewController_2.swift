//
//  MixADrinkViewController_2.swift
//  SomabarTestApp
//
//  Created by Dominic Whyte on 04/09/16.
//  Copyright © 2016 relayr. All rights reserved.
//

import UIKit

class MixADrinkViewController_2: UIViewController {
    
    @IBOutlet weak var recipe_id: UITextField!
    
    let ingredients : String = "{\"ingredients\": [{\"pod_number\": 1,\"pump_time\": 2.5},{\"pod_number\": 2,\"pump_time\": 2.5},{\"pod_number\": 3,\"pump_time\": 2.5},{\"pod_number\": 4,\"pump_time\": 2.5},{\"pod_number\": 5,\"pump_time\": 2.5},{\"pod_number\": 6,\"pump_time\": 2.5},{\"pod_number\": 7,\"pump_time\": 1.5}]}"
    
    @IBAction func buttonClicked(sender: UIButton) {
        if (recipe_id.text! != "") {
            if let setRecipeID = Int(recipe_id.text!) {
                print("Recipe ID: \(recipe_id.text!) Ingredient ID: \(ingredients)")
                let handler = self.targetForAction(#selector(TargetActionProtocol.initiateConnection(_:ipAddress:sslState:port:)), withSender: self) as? TargetActionProtocol
                if (handler!.connectionStatus) {
                    handler?.model.mixADrink(setRecipeID, ingredients: ingredients)
                }
            }
            
        }
    }
}
