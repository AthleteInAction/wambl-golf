// Playground - noun: a place where people can play

import UIKit

var n: [String] = ["234","765","213"]
var z: [String] = ["72389","5434623","432","424223"]

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

n.compare(z)
