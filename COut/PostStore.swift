// Post.swift
import Foundation
import FirebaseFirestore

struct Post: Identifiable {
    let id: String
    let title: String
    let locations: [String]
    let review: String
    var likes : Int
    var dislikes : Int
    var hours : Int
    var cost: Int

    init(id: String, data: [String: Any]) {
        self.id = id
        self.title = data["title"] as? String ?? ""
        self.locations = data["locations"] as? [String] ?? []
        self.review = data["review"] as? String ?? ""
        self.likes = data["likes"] as? Int ?? 0
        self.dislikes = 0
        self.hours = data["hours"] as? Int ?? 0
        self.cost = data["cost"] as? Int ?? 0
    }
}

// PostStore.swift
final class PostStore: ObservableObject {
    @Published var posts: [Post] = []

    static let shared = PostStore()

    func loadsortedPosts(obv: String) async throws {
        let snapshot = try await Firestore.firestore().collection("posts").getDocuments()
        for document in snapshot.documents {
            let postData = document.data()
            let post = Post(id: document.documentID, data: postData)
            DispatchQueue.main.async {
                self.posts.append(post)
            }
        }
    }
}


