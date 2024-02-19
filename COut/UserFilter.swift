import Foundation
import FirebaseFirestore

class UserFilter: ObservableObject{
    @Published var posts: [Post] = []
    
    func userfilter(loc:String,fromTime:Int,toTime:Int,cost:Int) async throws{
        
        let locationref = Firestore.firestore().collection("postLocation").document(loc)
        
        let posts2 = locationref.collection("posts")
        
        var query = posts2.whereField("hours", isGreaterThanOrEqualTo: fromTime)
        query = query.whereField("hours", isLessThanOrEqualTo: toTime)
       // query = query.whereField("cost", isLessThanOrEqualTo: cost)
        
        let snapshot = try await query.getDocuments()
        
        for docs in snapshot.documents{
            let postData = docs.data()
            let post = Post(id: docs.documentID, data: postData)
            DispatchQueue.main.async {
                self.posts.append(post)
            }
        }
    }
    
}
