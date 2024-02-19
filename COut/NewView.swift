
import SwiftUI
import FirebaseAuth

struct NewView: View {
    @EnvironmentObject var firebaseUserObserver: FirebaseUserObserver
    @Environment(\.dismiss) var dismissAction
    
    var body: some View {
        
        NavigationView{
            ZStack{
                Image("backgroundGradient")
                VStack{
                    Spacer()
                    Spacer()
                    Image("Cout")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width:300,height:300)
                    NavigationLink(destination: LoginView()){
                        RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                            .foregroundColor(.white)
                            .frame(width: 100,height:35)
                            .overlay(
                                Text("Login")
                                    .foregroundColor(.blue)
                            )
                            .padding(8)
                                
                    }
                    
                    
                    NavigationLink(destination: RegisterView()) {
                        RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                            .foregroundColor(.white)
                            .frame(width: 100,height:35)
                            .overlay(
                                Text("Register")
                                    .foregroundColor(.blue)
                            )
                                
                    }
                    Spacer()
                    Spacer()
                    Spacer()
                }
                
            }
            
        }.navigationBarBackButtonHidden()
    }
}

#Preview {
    NewView()
}
