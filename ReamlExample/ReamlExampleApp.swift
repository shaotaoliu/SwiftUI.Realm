import SwiftUI
import RealmSwift

@main
struct ReamlExampleApp: SwiftUI.App {
    
    init() {
        // Change the default data file (default.realm) to example.realm
        if var url = Realm.Configuration.defaultConfiguration.fileURL {
            url.deleteLastPathComponent()
            url.appendPathComponent("example.realm")
            
            print(url.path)
            Realm.Configuration.defaultConfiguration = Realm.Configuration(fileURL: url)
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    UserDefaults.standard.setValue(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
                }
        }
    }
}
