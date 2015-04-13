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

extension String {
    
    subscript (i: Int) -> Character {
        return self[advance(self.startIndex, i)]
    }
    
    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    
    subscript (r: Range<Int>) -> String {
        return substringWithRange(Range(start: advance(startIndex, r.startIndex), end: advance(startIndex, r.endIndex)))
    }
    
    var toPhone: String {
        
        var s = self
        
        var regex: NSRegularExpression = NSRegularExpression(pattern: "\\W", options: NSRegularExpressionOptions.CaseInsensitive, error: nil)!
        s = regex.stringByReplacingMatchesInString(s, options: nil, range: NSMakeRange(0,countElements(s)), withTemplate: "")
        
        if countElements(s) < 11 {
            s = "1\(s)"
        }
        
        return s
        
    }
    
}


extension Array {
    
    func compare(items: [String]) -> Bool {
        
        for s in self {
            
            let z: String = s as String
            
            for i in items {
                
                if z.lowercaseString == i.lowercaseString {
                    
                    return true
                    
                }
                
            }
            
        }
        
        return false
        
    }
    
}