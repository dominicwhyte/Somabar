

import UIKit

class MasterViewController: UIViewController, ModelDelegate, UIPopoverPresentationControllerDelegate, TargetActionProtocol {
    
    var model =  MQTTModel(clientID: "", ipAddress: "", sslState: true, port : 0)
    var masterPageViewController : MasterPageViewController = MasterPageViewController()
    var secondaryPageViewController : SecondaryPageViewController = SecondaryPageViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addObservers()
        model.modelDelegate = self
        //connection status indicator
        onLight.layer.cornerRadius = onLight.frame.size.width/2
        onLight.clipsToBounds = true
        offLight.layer.cornerRadius = offLight.frame.size.width/2
        offLight.clipsToBounds = true
        turnOff()

        }
    
    @IBAction func test(sender: AnyObject) {
        model.testing()
//        secondaryPageViewController.writeTextToLog("")
    }
    
    func addTextToLog(text : String, additionalNewLineNeeded : Bool) {
        secondaryPageViewController.writeTextToLog(text, additionalNewLineNeeded: additionalNewLineNeeded)
    }
    
    
    func testing2() {
        let jsonTest = "{\"timestamp\": 1471616873.4102029,\"token\": \"16bba3ab661911e6a75aacbc32d2a437\"}"
        print(ParseJSON.getDictFromData(jsonTest)!["timestamp"]!)
        
        //MQTTModel(clientID: "4556922598362711264", ipAddress: "mqtt.relayr.io", sslState: true, port : 8883)
        //print(Utilities.checkIfValidInput("12saf_d3afd3DSasfaDS_df12"))
    }
  
    
    //The following code is for selecting which command page
    @IBOutlet weak var selectedCommandPageLabel: UILabel!
    
    @IBAction func selectCommandButtonClicked(sender: UIBarButtonItem) {
        let vc = storyboard?.instantiateViewControllerWithIdentifier("PopMenuViewController") as! PopMenuViewController
        vc.preferredContentSize = CGSize(width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.height)
        let navController = UINavigationController(rootViewController: vc)
        navController.modalPresentationStyle = .Popover
        navController.navigationBarHidden = true
        let popMenu = navController.popoverPresentationController
        popMenu?.delegate = self
        popMenu?.barButtonItem = sender
        presentViewController(navController, animated: true, completion: nil)
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return .None
    }
    
    func addObservers() {
        var i = 0
        while (i < commands.count) {
            NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MasterViewController.commandClicked(_:)), name: commands[i], object: nil)
            i = i + 1
        }
        
        //NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MasterViewController.menu1(_:)), name: menuNotifications.menu1TappedDone, object: nil)
    }
    
    //end of code for selecting command page
    
    
    //A command page has been selected
    
    func commandClicked(sender : NSNotification) {
        
        selectedCommandPageLabel.text = sender.name
        masterPageViewController.switchToPage(commands.indexOf(sender.name)!)
    }
        //end of code for command page being selected
    
    
    //Connection
    
    var connectionStatus : Bool = false
    
    @IBOutlet weak var onLight : UIView!
    @IBOutlet weak var offLight : UIView!
    
    private var offColor = UIColor(red: 255/255, green: 80/255, blue: 95/255, alpha: 1)
    private var onColor = UIColor(red: 149/255, green: 193/255, blue: 31/255, alpha: 1)
    private var disabledColor = UIColor(red: 139/255, green: 150/255, blue: 154/255, alpha: 1)
    
    func connectivityStatusDidChange(status : Bool) {
        if (status) {
            connectionStatus = true
            print("Now connected")
            turnOn()
            startPinging()
        }
        else {
            connectionStatus = false
            print("Now disconnected")
            turnOff()
        }
    }
    func turnOn() {
        
        offLight.backgroundColor = disabledColor
        onLight.backgroundColor = onColor
    }
    
    func turnOff(){
        onLight.backgroundColor = disabledColor
        offLight.backgroundColor = offColor
    }
    
    //end of connection code
    
    //ping/pong
    let updateFrequency : Double = 20
    
    func startPinging() {
        
        timer = NSTimer.scheduledTimerWithTimeInterval(updateFrequency, target: self, selector: #selector(ping(_:)), userInfo: nil, repeats: true)
    }
    
    var timer : NSTimer = NSTimer()
    
    func ping(time : NSTimer) {
        if (!connectionStatus) {
            timer.invalidate()
        }
        else {
            model.sendAPing()
            customPingSent()
        }
    }
    
    func customPingSent() {
        secondaryPageViewController.updateLabelNewPing()
    }
    
    func customPongReceived() {
        secondaryPageViewController.updateLabelNewPong()
    }
    
    
    //end ping/pong
    
    
    
    
    
    
    
    
    //Sub view controllers have initiated an action
    
    func initiateConnection(clientID: String, ipAddress: String, sslState : Bool, port : UInt16) {
        model =  MQTTModel(clientID: clientID, ipAddress: ipAddress, sslState: sslState, port : port)
        model.modelDelegate = self
    }
    
    //end of sub view controlleres initiating action
        
    
    
    
    
    
//    The following information will be sent continuously, and you must display the most current info (and maybe last update time)
//    MQTT Path: "/v1/pod/{pod_id}/value
//    MQTT Payload can look like one of these two:
//    {"timestamp": 1434715735.1798159, "token": "f4fedbcf167b11e5b6c2aa690b9477fe", "value": "{\"ingredient_id\": 1234567}"}
//    {"timestamp": 1434715735.1798159, "token": "f4fedbcf167b11e5b6c2aa690b9477fe", "value": null}
    
    
    //the length that the topics should be, to check that expected topics are being received
    private struct topicComponentLengths {
        static let continuouslySentInfoTopicLength : Int = 5
    }
    
    func newCurrentInfoReceived(topic : String, message : String) {
        
        let topicArray : [String] = Utilities.splitTopicBySlashes(topic)
        if (topicArray.count == topicComponentLengths.continuouslySentInfoTopicLength) {
            if let pod_id : Int = Int(topicArray[3]) {
                secondaryPageViewController.updatePod(pod_id, text : message)
            }
        }
        
    }
    var masterPumpEnabled = false
    func masterPumpEnabled(bool : Bool) {
        masterPumpEnabled = bool
    }
    
    //Segue for container page view controller
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let vc = segue.destinationViewController as? MasterPageViewController
            where segue.identifier == "masterPageViewControllerSegue" {
            self.masterPageViewController = vc
        }
        else if let vc = segue.destinationViewController as? SecondaryPageViewController
            where segue.identifier == "secondaryPageViewControllerSegue" {
            self.secondaryPageViewController = vc
        }
    }

}

@objc internal protocol TargetActionProtocol {
    func initiateConnection(clientID: String, ipAddress: String, sslState : Bool, port : UInt16)
    var connectionStatus : Bool { get }
    var model : MQTTModel { get }
    var masterPumpEnabled : Bool { get }
}


