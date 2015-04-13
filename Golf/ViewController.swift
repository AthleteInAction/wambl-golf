//
//  ViewController.swift
//  Golf
//
//  Created by Will Robinson on 4/10/15.
//  Copyright (c) 2015 Will Robinson. All rights reserved.
//

import UIKit

class ViewController: UITableViewController,UISearchBarDelegate,UISearchDisplayDelegate {
    
    var contacts: Contacts!
    var collation: Collate = Collate()
    var F: Bool = false

    @IBOutlet weak var searchBAR: UISearchBar!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        contacts = Contacts(completion: { (s, e) -> Void in
            
            self.contacts.people = self.contacts.people?.filter {person in
                
                let numbers = person.phoneNumbers?.map { $0.value.toPhone }
                
                return true
                
            }
            
            let clist: [Collate.Item] = self.contacts.people!.map {record in
                
                return Collate.Item(displayName: record.compositeName!, sortName: record.nickname!,record: record)
                
            }
            
            self.collation.organize(items: clist)
            
            self.tableView.reloadData()
            
        })
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        
        
    }
    
    func pop(key: String,val: String){
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
        
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        if tableView == self.searchDisplayController?.searchResultsTableView {
            return 1
        } else {
            return collation.sections.count
        }
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == self.searchDisplayController?.searchResultsTableView {
            return contacts.filtered.count
        } else {
            return collation.sections[section].items.count
        }
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell!
        
        if cell == nil {
            
            cell = UITableViewCell(style: .Default, reuseIdentifier: "cell")
            
        }
        
        if tableView == self.searchDisplayController?.searchResultsTableView {
            
            cell.textLabel?.text = contacts.filtered[indexPath.row].compositeName
            
        } else {
            
            let item = collation.sections[indexPath.section].items[indexPath.row]
            
            cell.textLabel?.text = item.displayName
            
        }
        
        return cell
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if tableView == self.searchDisplayController?.searchResultsTableView {
            
            println(contacts.filtered[indexPath.row].phoneNumbers)
            
        } else {
            let item = collation.sections[indexPath.section].items[indexPath.row]
            
            println(item.numbers)
        }
        
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if tableView == self.searchDisplayController?.searchResultsTableView {
            return nil
        } else {
            if !collation.sections[section].items.isEmpty {
                return collation.collation.sectionTitles[section] as? String
            }
        }
        
        return ""
        
    }
    
    override func sectionIndexTitlesForTableView(tableView: UITableView) -> [AnyObject]? {
        
        if tableView == self.searchDisplayController?.searchResultsTableView {
            return nil
        } else {
            return collation.collation.sectionIndexTitles
        }
        
    }
    
    override func tableView(tableView: UITableView, sectionForSectionIndexTitle title: String, atIndex index: Int) -> Int {
        
        if tableView == self.searchDisplayController?.searchResultsTableView {
            return 0
        } else {
            return collation.collation.sectionForSectionIndexTitleAtIndex(index)
        }
        
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        
        
    }
    
    func searchDisplayController(controller: UISearchDisplayController, shouldReloadTableForSearchString searchString: String!) -> Bool {
        
        filterData()
        
        return true
        
    }
    
    func searchDisplayController(controller: UISearchDisplayController, shouldReloadTableForSearchScope searchOption: Int) -> Bool {
        
        filterData()
        
        return true
        
    }
    
    func filterData(){
        
        contacts.filtered = contacts.people!.filter {contact in
            
            contact.firstName?.lowercaseString.rangeOfString(self.searchDisplayController!.searchBar.text.lowercaseString) != nil
            ||
            contact.lastName?.lowercaseString.rangeOfString(self.searchDisplayController!.searchBar.text.lowercaseString) != nil
            
        }
        
    }

}
