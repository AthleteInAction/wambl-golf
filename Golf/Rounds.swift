class Rounds {
    
    var list = [String:Round]()
    var keys = [String]()
    
    func get(completion: (s: Bool,e: NSError?) -> Void){
        
        var query = PFQuery(className:"Rounds")
        
//        query.whereKey("user", equalTo: PFUser.currentUser())
        
        query.findObjectsInBackgroundWithBlock {(objects: [AnyObject]!, error: NSError!) -> Void in
            
            if error == nil {
                
                for object in objects {
                    
                    let r = object as PFObject
                    
                    let R = Round(obj: r)
                    
                    self.list[R.object.objectId] = R
                    
                }
                
                self.keys = [String](self.list.keys)
                
                completion(s: true, e: nil)
                
            } else {
                
                Error.report(user: PFUser.currentUser(), error: error, alert: true)
                
                completion(s: false, e: error)
                
            }
            
        }
        
    }
    
}