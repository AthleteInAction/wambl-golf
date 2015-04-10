extension Double {
    
    func rd(places: Int) -> Double {
        
        let multiplier = pow(10.0,Double(places))
        
        let v = round(self*multiplier)/multiplier
        
        return v
        
    }
    
}

extension PFUser {
    
    func login(username _username: String, password _password: String, completion: (s: Bool, e: NSError!) -> Void) {
        
        PFUser.logInWithUsernameInBackground(_username, password: _password) { (user: PFUser!, error: NSError!) -> Void in
            
            if !(error != nil) {
                
                completion(s: true, e: nil)
                
            } else {
                
                Error.report(user: nil, error: error, alert: true)
                
                completion(s: false, e: error)
                
            }
            
        }
        
    }
    
    func signup(completion: (s: Bool, e: NSError!) -> Void){
        
        self.signUpInBackgroundWithBlock { (success: Bool, error: NSError!) -> Void in
            
            if !success {
                
                Error.report(user: nil, error: error, alert: true)
                
            }
            
            completion(s: success, e: error)
            
        }
        
    }
    
}