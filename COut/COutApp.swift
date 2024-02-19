import SwiftUI
import FirebaseCore
import FirebaseFirestore

class AppDelegate: NSObject,UIApplicationDelegate {
    func application(_ application: UIApplication,didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FirebaseApp.configure()
        let db = Firestore.firestore()
        FirestoreManager.shared.db = db
        return true
    }
}

class FirestoreManager {
    static let shared = FirestoreManager()
    var db: Firestore!

    func accessFirestore() -> Firestore {
        return db
    }
}
@main
struct COutApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            AuthViewController()
        }
    }
}
