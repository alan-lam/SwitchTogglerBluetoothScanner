//
//  FirstViewController.swift
//  L2D1TabAndBluetooth
//
//  Created by Alan Lam on 4/13/19.
//  Copyright © 2019 Alan Lam. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var mySwitchLED1: UISwitch!
    
    @IBAction func doSwitchLED1(_ sender: Any) {
        print("todo: send command via bluetooth")
    }
    
    @IBOutlet weak var mySwitchLED2: UISwitch!
    
    @IBAction func doSwitchLED2(_ sender: Any) {
        print("todo: send command via bluetooth")
    }
    
    @IBOutlet weak var myTextField: UITextField!
    
    var timer:Timer!
    var seconds = 0
    var minutes = 0
    var on = false
    
    func updateDisplay() {
        myDuration.text = String(format: "%02d:%02d", minutes, seconds)
    }
    
    
    @IBAction func doInterval(_ sender: UIButton) {
        // verify a value is entered
        // verifty it's a number
        // start up or stop the timer
        if timer != nil {
            sender.setTitle("Start Interval", for: .normal)
            timer.invalidate()
            timer = nil
            self.mySwitchLED1.isOn = false
            self.mySwitchLED2.isOn = true
        }
        else {
            minutes = 0
            seconds = 0
            mySwitchLED1.isOn = false
            mySwitchLED2.isOn = false
            sender.setTitle("Stop Interval", for: .normal)
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timer) in
                self.seconds += 1
                if self.seconds == 60 {
                    self.minutes += 1
                    self.seconds = 0
                }
                self.updateDisplay()
                self.on = !self.on
                self.mySwitchLED1.isOn = self.on
                self.mySwitchLED2.isOn = !self.on
            })
        }
        // change the button text
    }
    
    @IBOutlet weak var myDuration: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

