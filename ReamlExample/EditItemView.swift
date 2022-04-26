import SwiftUI
import RealmSwift

struct EditItemView: View {
    
    @ObservedRealmObject var item: Item
    var operation: ItemOperation
    var onSave: ((Item) -> Void)?
    var onCancel: ((Item) -> Void)?
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $item.name)
                
                Toggle(isOn: $item.completed, label: {
                    Text("Completed")
                })
                
                Picker("Size", selection: $item.size) {
                    ForEach(ItemSize.allCases, id: \.self) { size in
                        Text(size.rawValue.capitalized)
                    }
                }
            }
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading, content: {
                    Button("Cancel") {
                        onCancel?(item)
                        dismiss()
                    }
                })
                
                ToolbarItem(placement: .navigationBarTrailing, content: {
                    Button("Save") {
                        onSave?(item)
                        dismiss()
                    }
                })
            })
            .navigationTitle("\(operation == .add ? "Add New" : "Edit") Item")
            .navigationBarTitleDisplayMode(.inline)
        }
        .navigationBarHidden(true)
    }
}

struct EditItemView_Previews: PreviewProvider {
    static var previews: some View {
        EditItemView(item: Item(name: "Hello World"), operation: .add) { item in
            
        }
    }
}
