//
//  BrowserViewController.swift
//  SideHustle
//
//  Created by Anna Yelizarova on 11/25/15.
//  Copyright © 2015 annayelizarova. All rights reserved.
//

import UIKit

class BrowserViewController: UIViewController {
    
    @IBOutlet weak var connectionsLabel: UILabel!
    
    let service = ServiceManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        service.delegate = self
    }
    
    @IBAction func profileTapped(sender: AnyObject) {
        service.sendContent("")
    }
    
}

extension BrowserViewController : ServiceManagerDelegate {
    
    func connectedDevicesChanged(manager: ServiceManager, connectedDevices: [String]) {
        NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
            self.connectionsLabel.text = "Connections: \(connectedDevices)"
        }
        
        for var i = 0; i < connectedDevices.count; ++i {
            let button   = UIButton(type: UIButtonType.System) as UIButton
            button.frame = CGRectMake(90, 90, 90, 90)
            //button.setBackgroundImage(image: img, forState: UIControlState)
            button.setTitle(connectedDevices[i], forState: UIControlState.Normal)
            button.addTarget(self, action: "profilePressed:", forControlEvents: UIControlEvents.TouchUpInside)
            self.view.addSubview(button)
        }
        
    }
    
    func profileChanged(manager: ServiceManager, contentString: String) {
        NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
            
            //change title of the profileviewcontroller programmatically
            //programatically segue to profileviewcontroller
            //programatically displlay profile (data that was sent over)
            NSLog("%@", "Unknown value received: \(contentString)")
        }
    }

    
}
