
import SwiftUI
import FirebaseFirestore

struct SearchPostsView: View {
    @StateObject var postsStore = UserFilter()
    @State var chosenOptions : Bool = false
    
    @State var hours : String = ""
    @State var Cost : String = ""
    @State var location : String = ""

    var body: some View {
        if(chosenOptions){
            VStack{
                Button(action: {
                    self.chosenOptions = false
                    self.postsStore.posts = []
                }, label: {
                    /*@START_MENU_TOKEN@*/Text("Button")/*@END_MENU_TOKEN@*/
                })
                
                List {
                    ScrollView{
                        ForEach(postsStore.posts) { post in
                            RoundedRectangle(cornerRadius: 5.0)
                                .overlay(
                                    VStack {
                                        Spacer()
                                        Text(post.title)
                                            .font(.title)
                                        Spacer()
                                        Spacer()
                                        HStack{
                                            Text(post.locations.joined(separator: " -> "))
                                        }
                                        Text("\n\(post.review)\n")
                                        
                                        Button(action: {
                                            Task{
                                                await updateLikeCount(for: post)
                                            }
                                            
                                        }, label: {
                                            HStack{
                                                Text("hours: \(post.hours)")
                                                    .padding(.all)
                                                Text("cost: \(post.cost)")
                                                    .padding(.all)
                                                HStack{
                                                    Image(systemName: "hand.thumbsup.fill")
                                                    Text("\(post.likes)")
                                                }
                                                .padding(.all)
                                            }
                                            
                                        })
                                        Spacer()
                                    }
                                        .foregroundColor(.white)
                                )
                                .frame(width:300,height:250)
                                .foregroundColor(.blue)
                            
                            
                        }
                        
                    }
                }
                .navigationTitle("Plan your trip")
                .onAppear {
                    Task {
                        do {
                            let number = Int(hours) ?? 1
                            let c = Int(Cost)
                            try await postsStore.userfilter(loc: "Mumbai" , fromTime: number-1, toTime: number+1 ,cost:c ?? 0)
                        } catch {
                            print("Error loading posts: \(error)")
                        }
                    }
                    
                    
                }
            }
        }
        else{
            ZStack{
                Image("backgroundGradient")
                VStack{
                    TextField("Enter the time you have",text:$hours)
                        .textFieldStyle(.roundedBorder)
                        .autocapitalization(.none)
                        .padding(.all)
                        .frame(width:300,height:50)
                        .controlSize(.extraLarge)
                    TextField("Enter the budget you have",text:$Cost)
                        .textFieldStyle(.roundedBorder)
                        .autocapitalization(.none)
                        .padding(.all)
                        .frame(width:300,height:50)
                        .controlSize(.extraLarge)
                    
//                    TextField("Enter your location",text:$location)
//                        .textFieldStyle(.roundedBorder)
//                        .autocapitalization(.none)
//                        .padding(.all)
//                        .frame(width:300,height:50)
//                        .controlSize(.extraLarge)
                    
                    RoundedRectangle(cornerRadius: 7.0)
                        .overlay(
                            Picker("City",selection : $location){
                                Text("Chennai").tag("Chennai")
                                Text("Vellore").tag("Vellore")
                                Text("Mumbai").tag("Mumbai")
                                Text("Delhi").tag("Delhi")
                                Text("Bangalore").tag("Bangalore")
                                Text("Hyderabad").tag("Hyderabad")
                                Text("Pune").tag("Pune")
                            }
                                .foregroundColor(.white)
                            
                        )
                        .foregroundColor(.white)
                        .frame(width:270,height:35)
                        .padding(5)
                    
                    
                    
                    
                    Button {
                        self.chosenOptions = true
                    } label: {
                        RoundedRectangle(cornerRadius: 15.0)
                            .opacity(0.9)
                            .overlay(
                                Text("Countiue")
                                    .foregroundColor(.blue)
                            )
                            .frame(width:130,height:40)
                            .foregroundColor(.white)
                        
                    }
                    .padding(.all)
                    
                }
                .navigationTitle("Plan your trip")
            }
        }
        
        
    }

    private func updateLikeCount(for post: Post) async {
            do {
                var updatedPost = post
                updatedPost.likes += 1

                try await Firestore.firestore().collection("posts").document(post.id).setData(["likes": updatedPost.likes], merge: true)

            } catch {
                print("Error updating like count: \(error)")
            }
        }
}

#Preview {
    SearchPostsView()
        .environmentObject(PostStore())
}
