//
//  SettingsCtrl.swift
//  Golf
//
//  Created by Will Robinson on 4/9/15.
//  Copyright (c) 2015 Will Robinson. All rights reserved.
//

import UIKit
import CoreData

class SettingsCtrl: UITableViewController {

    @IBOutlet weak var accuracy: UIStepper!
    @IBOutlet weak var accuracyTxt: UILabel!
    @IBOutlet weak var verify: UIStepper!
    @IBOutlet weak var verifyTxt: UILabel!
    @IBOutlet weak var tolerance: UISlider!
    @IBOutlet weak var toleranceTxt: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        accuracy.minimumValue = 5
        accuracy.stepValue = 5
        verify.minimumValue = 0
        tolerance.minimumValue = 0
        tolerance.maximumValue = 5
        
        accuracy.value = ST.accuracy
        accuracyTxt.text = "\(Int(round(accuracy.value)))m"
        verify.value = ST.verify
        verifyTxt.text = "\(Int(round(verify.value)))"
        tolerance.value = Float(ST.tolerance)
        toleranceTxt.text = "\(tolerance.value)m"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
        
    }

    @IBAction func accuracyChanged(sender: UIStepper){
        
        let v = Int(round(sender.value))
        
        ST.accuracy = Double(v)
        ST.save()
        
        accuracyTxt.text = "\(v)m"
        
    }
    
    @IBAction func verifyChanged(sender: UIStepper){
        
        let v = Int(round(sender.value))
        
        ST.verify = Double(v)
        ST.save()
        
        verifyTxt.text = "\(v)"
        
    }
    
    @IBAction func toleranceChanged(sender: UISlider){
        
        let v = Double(sender.value).rd(1)
        
        ST.tolerance = v
        ST.save()
        
        toleranceTxt.text = "\(v)m"
        
    }
    
}
