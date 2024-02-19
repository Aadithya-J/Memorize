import Foundation

class PostController : ObservableObject {
    func post(title_1 :String,Location: String ,Locations:[String],Review: String,hrs:Int,total:Int) async throws{
        try await userManager.shared.newPost(title: title_1,location:Location,locations: Locations,review: Review,hours:hrs,cost:total)
    }
}
