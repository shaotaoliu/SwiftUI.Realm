import RealmSwift
import SwiftUI

class RealmManager {
    
    static let shared = RealmManager()
    private var realm: Realm!
    
    private init() {
        realm = try! Realm()
    }
    
    func add(item: Item) {
        try! realm.write {
            realm.add(item)
        }
    }
    
    func delete(item: Item) {
        if let x = realm.object(ofType: Item.self, forPrimaryKey: item.id) {
            try! realm.write {
                realm.delete(x)
            }
        }
    }
    
    func update(item: Item) {
        if let x = realm.object(ofType: Item.self, forPrimaryKey: item.id) {
            try! realm.write {
                x.name = item.name
                x.completed = item.completed
                x.size = item.size
            }
        }
    }
}

class Item: Object, ObjectKeyIdentifiable {
    
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var name: String
    @Persisted var completed = false
    @Persisted var size: ItemSize = .medium
    
    convenience init(name: String) {
        self.init()
        self.name = name
    }
    
    func copy() -> Item {
        let item = Item(name: self.name)
        item.id = self.id
        item.completed = self.completed
        item.size = self.size
        return item
    }
}

enum ItemSize: String, CaseIterable, PersistableEnum {
    case large
    case medium
    case small
}

enum ItemOperation {
    case add
    case edit
}
