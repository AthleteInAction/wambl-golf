import SwiftAddressBook
import AddressBook

class Collate {
    
    let collation = UILocalizedIndexedCollation.currentCollation() as UILocalizedIndexedCollation
    var sections: [Section]! = []
    private var _sections: [Section]?
    
    class Item: NSObject {
        
        let record: SwiftAddressBookPerson
        let displayName: String
        let sortName: String
        let numbers: [String]?
        var section: Int?
        
        init(displayName _displayName: String,sortName _sortName: String,record _record: SwiftAddressBookPerson) {
            
            self.record = _record
            self.displayName = _displayName
            self.sortName = _sortName
            
            self.numbers = record.phoneNumbers?.map { return $0.value.toPhone }
            
        }
        
    }
    
    class Section {
        var items: [Item] = []
        
        func addItem(item: Item) {
            self.items.append(item)
        }
    }
    
    init(){
        
        
        
    }
    
    func organize(items _items: [Item]){
        
        var tmp: [Section] {
            
            // return if already initialized
            if self._sections != nil {
                return self._sections!
            }
            
            // create users from the name list
            var items: [Item] = _items.map { record in
                
                var item = Item(displayName: record.displayName, sortName: record.sortName, record: record.record)
                
                item.section = self.collation.sectionForObject(item, collationStringSelector: "sortName")
                
                return item
            }
            
            // create empty sections
            var sectionsz = [Section]()
            for i in 0..<self.collation.sectionIndexTitles.count {
                sectionsz.append(Section())
            }
            
            // put each user in a section
            for item in items {
                sectionsz[item.section!].addItem(item)
            }
            
            // sort each section
            for section in sectionsz {
                section.items = self.collation.sortedArrayFromArray(section.items, collationStringSelector: "sortName") as [Item]
            }
            
            self._sections = sectionsz
            
            return self._sections!
            
        }
        
        sections = tmp
        
    }
    
}