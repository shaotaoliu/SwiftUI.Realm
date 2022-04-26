import SwiftUI
import RealmSwift

struct ContentView: View {
    
    @ObservedResults(Item.self) var items
    @State var showAddSheet = false
    @State var searchText = ""
    var filterItems: Results<Item> {
        var result: Results<Item>
        
        if searchText.isEmpty {
            result = items
        }
        else {
            result = items.where {
                $0.name.contains(searchText, options: .caseInsensitive)
            }
        }
        
        return result.sorted(byKeyPath: "name")
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(filterItems) { item in
                    NavigationLink(destination: EditItemView(item: item.copy(), operation: .edit, onSave: { item2 in
                        RealmManager.shared.update(item: item2)
                    }, onCancel: { item2 in
                        item2.name = item.name
                        item2.completed = item.completed
                        item2.size = item.size
                    }), label: {
                        Text(item.name)
                    })
                }
                .onDelete { indexSet in
                    indexSet.forEach {
                        RealmManager.shared.delete(item: filterItems[$0])
                        
                    }
                }
            }
            .listStyle(.plain)
            .searchable(text: $searchText)
            .navigationTitle("Items")
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarTrailing, content: {
                    Button(action: {
                        showAddSheet = true
                    }, label: {
                        Image(systemName: "plus")
                    })
                })
            })
            .sheet(isPresented: $showAddSheet, content: {
                EditItemView(item: Item(name: ""), operation: .add, onSave: { item in
                    RealmManager.shared.add(item: item)
                })
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
