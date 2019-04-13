//
//  SecondViewController.swift
//  L2D1TabAndBluetooth
//
//  Created by Alan Lam on 4/13/19.
//  Copyright © 2019 Alan Lam. All rights reserved.
//

import UIKit
import CoreBluetooth

class SecondViewController: UIViewController, CBCentralManagerDelegate {
    
    var count = 0
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        count += 1
        msg += "Count = \(count)\n"
        
        msg += "Central is Scanning: \(central.isScanning)\n"
        switch central.state {
        case .poweredOff: msg += "Powered Off\n"
        case .poweredOn: msg += "Powered On\n"
        case .resetting: msg += "Resetting\n"
        case .unauthorized: msg += "Unauthorized\n"
        case .unknown: msg += "Unknown\n"
        case .unsupported: msg += "Unsupported\n"
        @unknown default:
            print("default")
        }
        myTextView.text = msg
    }
    
    var centralManager: CBCentralManager!

    var msg = ""
    var countDiscover = 0
    var bluetoothNames = [""]
    
    @IBAction func doScan(_ sender: UISwitch) {
        if sender.isOn {
            msg = "Start Scan\n"
            countDiscover = 0
            bluetoothNames.removeAll()
            centralManager?.scanForPeripherals(withServices: nil, options: nil)
        }
        else {
            msg += "Stop Scan"
            centralManager?.stopScan()
        }
        myTextView.text = msg
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        countDiscover += 1 // Found another Bluetooth device
        
        var found = false
        if let name = peripheral.name {
            for i in 0..<bluetoothNames.count {
                // Check if this name is already found
                if bluetoothNames[i] == name {
                    found = true
                    break
                }
            }
            if !found {
                bluetoothNames.append(name)
                msg += name + "\n"
            }
            msg += msg + "\n"
            myTextView.text = msg
        }
    }
    
    @IBOutlet weak var myTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        myTextView.text = "Toggle swtich to begin scan"
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }


}

