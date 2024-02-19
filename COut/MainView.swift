//
//  MainView.swift
//  COut
//
//  Created by Aadithya Jayakaran on 19/02/24.
//

import SwiftUI
import FirebaseAuth

struct MainView: View {
    @State private var isAboutUsPresented = false
    
    var body: some View {
        NavigationStack{
            NavigationView{
                ZStack{
                    Image("backgroundGradient")
                    VStack{
                        Spacer()
                        Image("Cout")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width:300,height:300)
                        NavigationLink {
                            PostView()
                        } label: {
                            RoundedRectangle(cornerRadius: 15.0)
                                .overlay(
                                    Text("Share your experience")
                                        .foregroundColor(.blue)
                                )
                                .frame(width:250,height: 45)
                                .foregroundColor(.white)
                                .padding()
                        }
                        
                        NavigationLink {
                            SearchPostsView()
                                .environmentObject(PostStore.shared)
                        } label: {
                            RoundedRectangle(cornerRadius: 15.0)
                                .overlay(
                                    Text("Plan your trip")
                                        .foregroundColor(.blue)
                                )
                                .frame(width:250,height: 45)
                                .foregroundColor(.white)
                                .padding()
                        }
                        
                        Spacer()
                        Spacer()
                    }
                    
                }.navigationBarTitle(Text(""),displayMode: .inline)
                    .navigationBarItems(
                        leading:
                            HStack{
                                Button(action:{
                                    Task {
                                        let result: ()? = try? Auth.auth().signOut()
                                            if result == nil {
                                            }
                                        }
                                }, label: {
                                    Image(systemName:"power")
                                        .foregroundColor(.red)
                                })
                            }
                                        
                    )
                    .navigationBarItems(
                        trailing:
                            HStack{
                                Button(action: {
                                    isAboutUsPresented.toggle()
                                }, label: {
                                    Text("About us")
                                        .foregroundColor(.white)
                                })
                            }
                                        
                    )
                    .sheet(isPresented: $isAboutUsPresented, content: {
                        AboutUsView(isAboutUsPresented: $isAboutUsPresented)
                    })

                
            }
            
        }
        

    }
}



struct AboutUsView: View {
    @Binding var isAboutUsPresented : Bool
    var body: some View{
        NavigationView{
            VStack{
                Text("""
                Developed by:
                Aadithya Jayakaran
                Mohan Ram Sridhar
                Vaibhavi Jaiswal
                     
                """)
                .font(.title)
            }
            .navigationBarItems(trailing: Button(action: {
                isAboutUsPresented.toggle()
            }, label: {
                Text("Cancel")
            }))
        }
    }
}

#Preview {
    MainView()
}
