//
//  MQTTModel.swift
//  SomabarTestApp
//
//  Created by Dominic Whyte on 01/09/16.
//  Copyright © 2016 relayr. All rights reserved.
//

import Foundation
import CocoaMQTT

class MQTTModel : NSObject, CocoaMQTTDelegate {
    
    private let mqttPipe : CocoaMQTT
    weak var modelDelegate: ModelDelegate?
    
    init(clientID : String, ipAddress : String, sslState : Bool, port : UInt16) {
        self.mqttPipe = CocoaMQTT(clientId: clientID, host: ipAddress, port: port)
        self.mqttPipe.secureMQTT = sslState
        self.mqttPipe.cleanSess = true
        super.init()
        mqttPipe.delegate = self
        //testing3()
        mqttPipe.connect()
        
    }
    
    
    //KEY: remove testing functions for final version
    func testing3() {
        mqttPipe.username = "2d4d020e-5b93-43ef-a17e-c34e3ca66ffd:cf6a21ba-b422-4f8b-ac88-9a556a40a307"
        mqttPipe.password = "6XcncxrqamHI"
    }
    
    func testing() {
        //testing:
        let testmessage : CocoaMQTTMessage = CocoaMQTTMessage(topic: "/v1/pod/1/value", string: "{\"timestamp\": 1434715735.1798159, \"token\": \"f4fedbcf167b11e5b6c2aa690b9477fe\", \"value\": \"{5\": 1234567}\"}")
        
        self.mqtt(mqttPipe, didReceiveMessage: testmessage, id: 1)
    }
    
    func mqtt(mqtt: CocoaMQTT, didConnect host: String, port: Int) {
        print("MQTT did connect to \(host):\(port)")
    }
    
    func mqtt(mqtt: CocoaMQTT, didConnectAck ack: CocoaMQTTConnAck) {
        print("MQTT did connect with acknowledgment")
        subscribeToAll()
        modelDelegate?.connectivityStatusDidChange(true)
        modelDelegate?.addTextToLog("MQTT did connect with acknowledgment", additionalNewLineNeeded : true)
        
        
        //testing()
        
    }
    
    let topics : [String] = ["/v1/date/get/confirm", "/v1/date/set/confirm", "/v1/pong", "/v1/status/config", "/v1/make/#", "/v1/pod/#", "/v1/rinse/confirm"]
    
    func subscribeToAll() {
        for topic in topics {
            mqttPipe.subscribe(topic, qos: .QOS0)
        }
    }
    
    func mqtt(mqtt: CocoaMQTT, didPublishMessage message: CocoaMQTTMessage, id: UInt16) {
        //has the master pump been enabled?
        if (message.topic == "/v1/master/set/on") {
            print("Master Pump Enabled")
            modelDelegate?.masterPumpEnabled(true)
        }
        else if (message.topic == "/v1/master/set/off") {
            print("Master Pump Disabled")
            modelDelegate?.masterPumpEnabled(false)
        }
        
        print("MQTT didPublishMessage to topic \(message.topic) with message: \(message.string!)")
        if (!message.topic.containsString(receivingTopics.ping)) {
        modelDelegate?.addTextToLog("MQTT didPublishMessage to topic \(message.topic) with message: \(message.string!)", additionalNewLineNeeded : true)
        }
    }
    
    func mqtt(mqtt: CocoaMQTT, didPublishAck id: UInt16) {
        print("MQTT didPublishAck with id: \(id)")
    }
    
    private struct receivingTopics {
        static let continuouslySentInfoTopicPrefix : String = "/v1/pod/"
        static let writereadPodTag : String = "/confirm"
        static let pong : String = "/v1/pong"
        static let ping : String = "/v1/ping"
    }
    
    func mqtt(mqtt: CocoaMQTT, didReceiveMessage message: CocoaMQTTMessage, id: UInt16 ) {
        print(message.topic)
        if let text = message.string {
            if let topic : String = message.topic {
                //for continuously sent info
                if (topic.containsString(receivingTopics.continuouslySentInfoTopicPrefix) && !topic.containsString(receivingTopics.writereadPodTag)) {
                    //new message that is continuously sent has been received
                    modelDelegate?.newCurrentInfoReceived(topic, message: text)
                }
                else if (topic.containsString(receivingTopics.pong)){
                    print("Custom pong received")
                    modelDelegate?.customPongReceived()
                }
                else {
                    print("writing to log")
                    modelDelegate?.addTextToLog("New message received", additionalNewLineNeeded : true)
                    modelDelegate?.addTextToLog("Path: \(topic)", additionalNewLineNeeded : false)
                    modelDelegate?.addTextToLog(text, additionalNewLineNeeded : false)
                }
            }
            
        }
    }
    
    func mqtt(mqtt: CocoaMQTT, didSubscribeTopic topic: String) {
        modelDelegate?.addTextToLog("MQTT didSubscribeTopic to \(topic)", additionalNewLineNeeded : true)
        print("MQTT didSubscribeTopic to \(topic)")
    }
    
    func mqtt(mqtt: CocoaMQTT, didUnsubscribeTopic topic: String) {
        print("MQTT didUnsubscribeTopic to \(topic)")
    }
    
    func mqttDidPing(mqtt: CocoaMQTT) {
        print("MQTT did ping")
    }
    
    func mqttDidReceivePong(mqtt: CocoaMQTT) {
        print("MQTT did receive pong")
    }
    
    func mqttDidDisconnect(mqtt: CocoaMQTT, withError err: NSError?) {
        modelDelegate?.connectivityStatusDidChange(false)
        modelDelegate?.addTextToLog("MQTT did Disconnect", additionalNewLineNeeded : true)
    }
    
    func publish(topic : String, message : String) {
        mqttPipe.publish(topic, withString: message)
    }
    
    
    //Commands that can be called
    
    
    //  The user must have a simple button for each of the following actions (through the API), and an easy way to see all responses over MQTT:
    
    
    func obtainCurrentDeviceStatus() {
        print("Attempting to publish")
        let topic : String = "/v1/status"
        let message : String = "{}"
        publish(topic, message: message)
        
    }
    
    func mixADrink(recipeID : Int, ingredients : String) {
        print("Attempting to publish")
        let topic : String = "/v1/make/" + String(recipeID) + "/set"
        let message : String = ingredients
        publish(topic, message: message)
    }
    
    func writePodTag(pod_id : Int, ingredients_id : Int) {
        print("Attempting to publish")
        let topic : String = "/v1/pod/\(pod_id)/write"
        let message : String = "{\"value\": {\"ingredient_id\": \(ingredients_id)}}"
        publish(topic, message: message)
    }
    
    func readPodTag(pod_id : String) {
        print("Attempting to publish")
        let topic : String = "/v1/pod/\(pod_id)/read"
        let message : String = "{}"
        publish(topic, message: message)
    }
    
    func setWiFiCredentials(ssid : String, password : String) {
        print("Attempting to publish")
        let topic : String = "/v1/wifi/\(ssid)/set/\(password)"
        let message : String = "{}"
        publish(topic, message: message)
    }
    
    func performRinse(duration : Double) {
        print("Attempting to publish")
        let topic : String = "/v1/rinse"
        let message : String = "{\"duration\": \(String(duration))}"
        publish(topic, message: message)
    }
    
    func setLEDState(led_name : String, state : String) {
        print("Attempting to publish")
        let topic : String = "/v1/led/\(led_name)/set/\(state)"
        let message : String = "{}"
        publish(topic, message: message)    }
    
    func setValveState(state : String) {
        print("Attempting to publish")
        let topic : String = "/v1/valve/diverter/set/\(state)"
        let message : String = "{}"
        publish(topic, message: message)
    }
    
    func setMasterPumpEnable(state : String) {
        print("Attempting to publish")
        let topic : String = "/v1/master/set/\(state)"
        let message : String = "{}"
        publish(topic, message: message)
    }
    
    func setPumpState(pump_id : String, state : String) {
        print("Attempting to publish")
        let topic : String = "/v1/pump/\(pump_id)/set/\(state)"
        let message : String = " "
        publish(topic, message: message)
    }
    
    func sendAPing() {
        print("Custom Pinging")
        let topic : String = "/v1/ping"
        let message : String = "{}"
        publish(topic, message: message)
    }
    
    
    
    
    //end of commands that can be called
    
}

/**
 * Model Delegate
 */
protocol ModelDelegate: class {
    func connectivityStatusDidChange(status : Bool)
    func newCurrentInfoReceived(topic : String, message : String)
    func addTextToLog(text : String, additionalNewLineNeeded : Bool)
    func customPongReceived()
    func masterPumpEnabled(bool : Bool)
}