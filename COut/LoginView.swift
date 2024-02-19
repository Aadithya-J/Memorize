import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @EnvironmentObject var firebaseUserObserver: FirebaseUserObserver
    @Environment(\.dismiss) var dismissAction
    
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isLoading = false
    @State private var errorMessage = ""
    @State var isSignedIn = false

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
                        Task {
                            await signIn()
                            if Auth.auth().currentUser != nil {
                                 isSignedIn = true
                                 if isSignedIn {
                                     dismissAction()
                                 }
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
                        .disabled(isLoading || !isSignedIn)
                    }


                    Spacer()
                    
                    Spacer()

                    if !errorMessage.isEmpty {
                        Text(errorMessage)
                            .foregroundColor(.red)
                    }
                }
            }
            
        }
    }

    func signIn() async {
        isLoading = true
        errorMessage = ""

        do {
            try await Auth.auth().signIn(withEmail: email, password: password)
        } catch {
            errorMessage = error.localizedDescription
            print(errorMessage)
        }

        isLoading = false
    }
}

#Preview{
    LoginView()
}

