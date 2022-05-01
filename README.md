# SwiftUI.RealmExample

https://github.com/realm/realm-swift

The following defines a Realm object.

```Swift
class Item: Object, ObjectKeyIdentifiable {
    
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var name: String
    @Persisted var completed = false
    @Persisted var size: ItemSize = .medium
    
    convenience init(name: String) {
        self.init()
        self.name = name
    }
}

enum ItemSize: String, CaseIterable, PersistableEnum {
    case large
    case medium
    case small
}

```


The following shows how to add, query, update, and delete Realm objects.

```Swift
let realm = try! Realm()

let item = Item(name: "Test")
item.completed = true
item.size = .large

// add
try! realm.write {
    realm.add(item)
}

// update
try! realm.write {
    item.name = "Test Again"
}

// query
for item in realm.objects(Item.self) {
    print(item.name)
}

// delete
try! realm.write {
    realm.delete(item)
}

```
