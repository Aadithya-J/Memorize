import SwiftUI
import FirebaseAuth

struct RegisterView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isLoading = false
    @State private var iscreated = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("backgroundGradient")
                
                VStack {
                    Spacer()
                    
                    Image("Cout")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width:300,height:300)
                    
                    TextField("Email", text: $email)
                        .textFieldStyle(.roundedBorder)
                        .autocapitalization(.none)
                        .padding(.all)
                        .frame(width:300,height:50)
                        .controlSize(.extraLarge)
                    
                    SecureField("Password", text: $password)
                        .textFieldStyle(.roundedBorder)
                        .autocapitalization(.none)
                        .padding([.leading,.bottom,.trailing])
                        .frame(width:300,height:50)
                        .padding(30)
                        .controlSize(.regular)
                    
                    Button(action: {
                        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
                            if let error = error {
                                print("Error creating user: \(error.localizedDescription)")
                            } else {
                                
                            }
                        }
                    }) {
                        RoundedRectangle(cornerRadius: 15.0)
                            .opacity(0.9)
                            .overlay(
                                Text("Sign in")
                                    .foregroundColor(.blue)
                            )
                            .frame(width:130,height:40)
                            .foregroundColor(.white)
                        
                        
                        NavigationLink(destination: AuthViewController()) {
                            EmptyView()
                        }
                        //   .disabled(isLoading || !isSignedIn)
                    }
                    
                    
                    Spacer()
                    
                    Spacer()
                    
                }
            }
        }
    }
}
#Preview {
    RegisterView()
}

