//
//  ViewController.swift
//  AwareHelloWorld
//
//  Created by Drew Bratcher on 6/25/15.
//  Copyright (c) 2015 Drew Bratcher. All rights reserved.
//

import UIKit
import AwareStack

class ViewController: UIViewController {
    
    @IBOutlet weak var helloLabel: UILabel!
    var deviceKey:String?
    var events:AwareEventManager?
    
    override func viewDidAppear(animated:Bool) {
        super.viewDidAppear(animated)
        helloLabel.hidden = true
        if let haveIt = deviceKey {
            println("got key" + haveIt)
        } else {
            var app = AwareDeviceManager(appID: "jiberish")
            app.pair(self, completion: onPair)
        }
    }
    
    func onPair(newDeviceKey:String) {
        deviceKey = newDeviceKey
        println("got device key" + deviceKey!)
        events = AwareEventManager(deviceID: deviceKey!)
        events?.onRange(onRange)
    }
    
    func onRange(device:AwareDevice) {
        println("on Range")
        if let dist = device.distance {
            println(dist)
            if(dist=="Near") {
                helloLabel.hidden = false;
            } else if(dist == "Immediate") {
                helloLabel.hidden = false;
            }else {
                helloLabel.hidden = true;
            }
            
        }
    }
    
    
    
}

