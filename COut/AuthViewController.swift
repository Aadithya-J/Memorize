import SwiftUI
import FirebaseAuth

struct AuthViewController: View {
    @EnvironmentObject var firebaseUserObserver: FirebaseUserObserver
    @State var user_email = Auth.auth().currentUser
    @State var Truebool = true
    var body: some View {
        NavigationStack {
                VStack {
                    Spacer()
                    if(user_email == nil){
                        NavigationStack{
                            EmptyView()
                        }
                        .navigationDestination(isPresented: $Truebool) {
                            NewView()
                        }
                        
                    }
                    else{
                        if user_email?.isEmailVerified == nil {
                            EmailVerifyView()
                        }
                        else{
                            MainView()
                        }
                    }
                    
                    Spacer()
                }
            
        }
    }
}


class FirebaseUserObserver: ObservableObject {
    @Published var user: FirebaseAuth.User?

    init() {
        Auth.auth().addStateDidChangeListener { [weak self] auth, user in
            self?.user = user
        }
    }
}

struct AuthViewController_Previews: PreviewProvider {
    static var previews: some View {
        AuthViewController()
            .environmentObject(FirebaseUserObserver())
    }
}

