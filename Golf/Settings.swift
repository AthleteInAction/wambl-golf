import CoreData

class Settings: NSObject {
    
    private var AppDel: AppDelegate!
    private var context: NSManagedObjectContext!
    
    var accuracy: Double!
    var verify: Double!
    var tolerance: Double!
    
    private var accuracyObj: NSManagedObject!
    private var verifyObj: NSManagedObject!
    private var toleranceObj: NSManagedObject!
    
    override init(){
        super.init()
        
        AppDel = UIApplication.sharedApplication().delegate as AppDelegate
        context = AppDel.managedObjectContext!
        
        var request = NSFetchRequest(entityName: "Settings")
        request.returnsObjectsAsFaults = false
        
        var error: NSError?
        
        var results: NSArray = context.executeFetchRequest(request, error: &error)!
        
        if !(error != nil) {
            
            if results.count > 0 {
                
                for object in results {
                    
                    let set = object as NSManagedObject
                    
                    println(set)
                    
                    if set.valueForKey("type") as String == "accuracy" {
                        
                        accuracyObj = set
                        
                    }
                    
                    if set.valueForKey("type") as String == "verify" {
                        
                        verifyObj = set
                        
                    }
                    
                    if set.valueForKey("type") as String == "tolerance" {
                        
                        toleranceObj = set
                        
                    }
                    
                }
                
            } else {
                
                println("NO RESULTS FOUOND")
                
            }
            
        } else {
            
            println("ERROR")
            
        }
        
        var needToCreate: Bool = false
        
        if accuracyObj == nil {
            
            accuracyObj = NSEntityDescription.insertNewObjectForEntityForName("Settings", inManagedObjectContext: context) as NSManagedObject
            accuracyObj.setValue("accuracy", forKey: "type")
            accuracyObj.setValue(10, forKey: "value")
            
            needToCreate = true
            
        }
        if verifyObj == nil {
            
            verifyObj = NSEntityDescription.insertNewObjectForEntityForName("Settings", inManagedObjectContext: context) as NSManagedObject
            verifyObj.setValue("verify", forKey: "type")
            verifyObj.setValue(5, forKey: "value")
            
            needToCreate = true
            
        }
        if toleranceObj == nil {
            
            toleranceObj = NSEntityDescription.insertNewObjectForEntityForName("Settings", inManagedObjectContext: context) as NSManagedObject
            toleranceObj.setValue("tolerance", forKey: "type")
            toleranceObj.setValue(0, forKey: "value")
            
            needToCreate = true
            
        }
        
        accuracy = accuracyObj.valueForKey("value") as Double
        verify = verifyObj.valueForKey("value") as Double
        tolerance = toleranceObj.valueForKey("value") as Double
        
        if needToCreate {save()} else {println("ALL THERE")}
        
    }
    
    func save(){
        
        setValues()
        
        var error: NSError?
        
        context.save(&error)
        
        if error == nil {
            
            println("SETTINGS SAVE")
            
        } else {
            
            println("SETTINGS ERROR")
            
        }
        
    }
    
    func setValues(){
        
        accuracyObj.setValue(accuracy, forKey: "value")
        
        verifyObj.setValue(verify, forKey: "value")
        
        toleranceObj.setValue(tolerance.rd(1), forKey: "value")
        
    }
    
}