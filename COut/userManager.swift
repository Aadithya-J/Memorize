import Foundation

final class userManager {
    static let shared = userManager()

    private init() {}

    func createNewUser(u_id:String,email: String) async throws {
        let db = FirestoreManager.shared.accessFirestore()
        let uid = u_id
        let userData: [String: Any] = [
            "uid": u_id,
            "Email": email
        ]

        try await db.collection("users").document(uid).setData(userData, merge: false)
    }

    func newPost(title: String,location : String, locations: [String], review: String,hours: Int,cost : Int) async throws {
        let db = FirestoreManager.shared.accessFirestore()
        let postId = UUID().uuidString 
        let ltion = location
        var postData: [String: Any] = [
            "title": title,
            "locations": locations,
            "review": review,
            "likes": 10,
            "hours": hours,
            "cost" : cost
        ]
        if postData["title"] == nil{
            postData["title"] = "title"
        }
        try await db.collection("postLocation").document(ltion).collection("posts").document(postId).setData(postData)
        try await db.collection("posts").document(postId).setData(postData, merge: true)
    }
}

