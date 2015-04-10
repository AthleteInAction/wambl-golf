//
//  ViewController.swift
//  Golf
//
//  Created by Will Robinson on 4/9/15.
//  Copyright (c) 2015 Will Robinson. All rights reserved.
//

import UIKit

class LoginCtrl: UIViewController {

    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var submit: UIButton!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
        
    }
    
    @IBAction func go(sender: UIButton){
        
        if phone.text != "" {
            
            loader.startAnimating()
            submit.hidden = true
            
            var user = PFUser()
            
            user.username = phone.text
            user.password = user.username
            
            user.signup { (s, e) -> Void in
                
                if s {
                    
                    var newWindow = UIWindow(frame: UIScreen.mainScreen().bounds)
                    
                    var newStoryboard = UIStoryboard(name: "In", bundle: nil)
                    var vc = newStoryboard.instantiateViewControllerWithIdentifier("dashboard_ctrl") as DashboardCtrl
                    var nav = UINavigationController(rootViewController: vc)
                    newWindow.rootViewController = nav
                    newWindow.makeKeyAndVisible()
                    
                    root = newWindow
                    
                }
                
                self.loader.stopAnimating()
                self.submit.hidden = false
                
            }
            
        }
        
    }


}