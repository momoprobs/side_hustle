//
//  ViewController.swift
//  SideHustle
//
//  Created by Anna Yelizarova on 11/25/15.
//  Copyright © 2015 annayelizarova. All rights reserved.
//

import UIKit

class ColorSwitchViewController: UIViewController {
    
    @IBOutlet weak var connectionsLabel: UILabel!
    
    let service = ServiceManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        service.delegate = self
    }
    
    @IBAction func redTapped(sender: AnyObject) {
        self.changeColor(UIColor.redColor())
        service.sendColor("red")
    }
    
    @IBAction func yellowTapped(sender: AnyObject) {
        self.changeColor(UIColor.yellowColor())
        service.sendColor("yellow")
    }
    
    func changeColor(color : UIColor) {
        UIView.animateWithDuration(0.2) {
            self.view.backgroundColor = color
        }
    }
    
}

extension UIViewController : ServiceManagerDelegate {
    
    func connectedDevicesChanged(manager: ServiceManager, connectedDevices: [String]) {
        NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
            self.connectionsLabel.text = "Connections: \(connectedDevices)"
        }
    }
    
    func colorChanged(manager: ColorServiceManager, colorString: String) {
        NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
            switch colorString {
            case "red":
                self.changeColor(UIColor.redColor())
            case "yellow":
                self.changeColor(UIColor.yellowColor())
            default:
                NSLog("%@", "Unknown color value received: \(colorString)")
            }
        }
    }
    
}

