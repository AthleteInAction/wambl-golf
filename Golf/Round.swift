class Round {
    
    var object: PFObject!
    var course: String!
    var date: NSDate!
    var title: String!
    var createdAt: NSDate!
    var updatedAt: NSDate!
    var pars: [Int]!
    var playersR: PFRelation!
    var players: [PFUser]!
    var user: PFUser!
    var status: String!
    var i_am_creator: Bool = false
    
    init(obj: PFObject){
        
        object = obj
        course = object["course"] as String
        date = object["date"] as NSDate
        title = object["title"] as String
        createdAt = object.createdAt as NSDate
        updatedAt = object.updatedAt as NSDate
        pars = object["pars"] as Array<Int>
        playersR = object["players"] as PFRelation
        user = object["user"] as PFUser
        status = object["status"] as String
        
        i_am_creator = (user.objectId == PFUser.currentUser().objectId)
        
    }
    
    func loadPlayers(completion: (s: Bool,e: NSError?) -> Void){
        
        playersR.query().findObjectsInBackgroundWithBlock { (p: [AnyObject]!, error: NSError!) -> Void in
            
            if error == nil {
                
                var tmp: [PFUser] = []
                
                for o in p {
                    
                    let final = o as PFUser
                    
                    tmp.append(final)
                    
                }
                
                self.players = tmp
                
                completion(s: true, e: nil)
                
            } else {
                
                Error.report(user: PFUser.currentUser(), error: error, alert: true)
                
                completion(s: false, e: error)
                
            }
            
            self.i_am_creator = (self.user.objectId == PFUser.currentUser().objectId)
            
        }
        
    }
    
    func save(completion: (s: Bool,e: NSError?) -> Void){
        
        object["course"] = course
        object["date"] = date
        object["title"] = title
        object["pars"] = pars
        object["players"] = playersR
        object["user"] = user
        object["status"] = status
        
        object.saveInBackgroundWithBlock { (success,error) -> Void in
            
            completion(s: success, e: error)
            
        }
        
    }
    
    func delete(completion: (s: Bool,e: NSError?) -> Void){
        
        object.deleteInBackgroundWithBlock { (success,error) -> Void in
            
            completion(s: success, e: error)
            
        }
        
    }
    
}