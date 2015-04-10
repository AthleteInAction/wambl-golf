//
//  NewRoundCtrl.swift
//  Golf
//
//  Created by Will Robinson on 4/10/15.
//  Copyright (c) 2015 Will Robinson. All rights reserved.
//

import UIKit

class NewRoundCtrl: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var titleTXT: UITextField!
    @IBOutlet weak var courseTXT: UITextField!
    @IBOutlet weak var date: UIDatePicker!
    @IBOutlet weak var next: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
        
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
        self.view.endEditing(true)
        
    }
    
    @IBAction func dissmiss(sender: UIBarButtonItem){
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    @IBAction func titleChanged(sender: UITextField){
        
        if titleTXT.text == "" || courseTXT.text == "" {
            
            next.enabled = false
            
        } else {
            
            next.enabled = true
            
        }
        
    }
    
    @IBAction func noKeyboard(sender: AnyObject){
        
        self.view.endEditing(true)
        
    }
    
}