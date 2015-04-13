import SwiftAddressBook
import AddressBook

class Contacts {
    
    var people: [SwiftAddressBookPerson]? = []
    var filtered: [SwiftAddressBookPerson] = []
    
    init(completion: (s: Bool,e: CFError?) -> Void){
        
        refresh { (s, e) -> Void in
            
            completion(s: s,e: e)
            
        }
        
    }
    
    func refresh(completion: (s: Bool,e: CFError?) -> Void){
        
        swiftAddressBook?.requestAccessWithCompletion { (s :Bool,e :CFError?) -> Void in
            
            dispatch_async(dispatch_get_main_queue(), {
                
                if s {
                    
                    self.people = swiftAddressBook?.allPeople
                    
                    self.people = self.people?.map {item in
                        
                        if item.lastName != nil {
                            item.nickname = item.lastName
                        } else {
                            if item.firstName != nil {
                                item.nickname = item.firstName
                            } else {
                                item.nickname = "---"
                            }
                        }
                        
                        return item
                        
                    }
                    
                }
                
                completion(s: s,e: e)
                
            })
            
        }
        
    }
    
}