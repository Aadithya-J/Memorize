//
//  PostView.swift
//  COut
//
//  Created by Aadithya Jayakaran on 19/02/24.
//

import SwiftUI

struct PostView: View {
    @State var title : String = ""
    @State var locations : [String] = []
    @State var location1 : String = ""
    @State var location : String = ""
    @State var review : String = ""
    @State var hours : String = ""
    @State var cost : String = ""

    @StateObject private var postController = PostController()

    func postbutton() {
        Task {
            do {
                let n_hours = Int(hours) ?? 0
                let n_cost = Int(cost) ?? 0
                try await postController.post(title_1: title,Location:location, Locations: locations, Review: review,hrs:n_hours,total:n_cost)
                
                review = ""
            } catch {
                print("Error posting: \(error)")
            }
        }
    }

    var body: some View {
        NavigationStack{
            ZStack{
                Image("backgroundGradient")
                VStack{
                    TextField("Title",text: $title)
                        .textFieldStyle(.roundedBorder)
                        .autocapitalization(.none)
                        .padding(.all)
                        .frame(width:300,height:50)
                        .controlSize(.extraLarge)
                    HStack{
                        TextField("Hours",text: $hours)
                            .textFieldStyle(.roundedBorder)
                            .autocapitalization(.none)
                            .padding(.all)
                            .frame(width:147,height:50)
                        TextField("Cost",text: $cost)
                            .textFieldStyle(.roundedBorder)
                            .autocapitalization(.none)
                            .padding(.all)
                            .frame(width:147,height:50)
                    }
                    TextField("Enter your location",text: $location)
                        .textFieldStyle(.roundedBorder)
                        .autocapitalization(.none)
                        .padding(.all)
                        .frame(width:300,height:50)
                        .controlSize(.extraLarge)
                    HStack{
                        TextField("Locations",text: $location1)
                            .textFieldStyle(.roundedBorder)
                            .autocapitalization(.none)
                            .padding(.all)
                            .frame(width:300,height:50)
                            .controlSize(.extraLarge)
                        Button(action: {
                            self.locations.append(self.location1)
                            self.location1 = ""
                        }, label: {
                            Image(systemName: "plus.circle.fill")
                                .offset(x:-10)
                                .foregroundColor(.white)
                                .font(.title)
                            
                        })
                    }
                    .offset(x:20)
                    
                    
                    HStack{
                        ForEach(locations,id: \.self){ loc in
                            Text(loc)
                        }
                    }
                    TextEditor(text: $review)
                            .foregroundStyle(.secondary)
                            .padding(.horizontal)
                            .navigationTitle("Share your experience")
                            .autocapitalization(.none)
                            .padding(.all)
                            .frame(width:330,height:160)
                            .controlSize(.extraLarge)
                            

                    Button(action: {
                        postbutton()
                    }, label: {
                        RoundedRectangle(cornerRadius: 15.0)
                            .overlay(
                                Text("Post")
                                    .foregroundColor(.white)
                            )
                            .frame(width:100,height:30)
                    })
                }
                
            }
        }
        
    }
}

#Preview {
    PostView()
}
