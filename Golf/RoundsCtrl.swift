//
//  RoundsCtrl.swift
//  Golf
//
//  Created by Will Robinson on 4/9/15.
//  Copyright (c) 2015 Will Robinson. All rights reserved.
//

import UIKit

class RoundsCtrl: UITableViewController {
    
    var rounds = Rounds()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
        
    }
    
    func setData(){
        
        rounds.get { (s, e) -> Void in
            
            if s {
                
                println("SUCCESS")
                
            } else {
                
                println("ERROR")
                
            }
            
            self.tableView.reloadData()
            
        }
        
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
        
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return rounds.list.count
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell
        
        let key = rounds.keys[indexPath.row]
        let round = rounds.list[key]
        
        cell.textLabel?.text = round!.title
        
        return cell
        
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        let key = rounds.keys[indexPath.row]
        let round = rounds.list[key]
        
        if editingStyle == .Delete {
            
            round?.delete({ (s, e) -> Void in
                
                if s {
                    
                    self.rounds.list[key] = nil
                    self.rounds.keys = [String](self.rounds.list.keys)
                    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
                    
                }
                
            })
            
        }
        
    }

}
