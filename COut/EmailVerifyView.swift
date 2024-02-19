//
//  EmailVerifyView.swift
//  COut
//
//  Created by Aadithya Jayakaran on 19/02/24.
//

import SwiftUI
import FirebaseAuth

func userinit() async throws {
    let user = Auth.auth().currentUser
    try await userManager.shared.createNewUser(u_id:user!.uid,email: user?.email ?? "" )
}
struct EmailVerifyView: View {
    
    var body: some View {
        Text("Email not verified")
        Button(action: {
          Task {
            try await userinit()
          }
        }, label: {
          Text("Verify")
        })

    }
}

#Preview {
    EmailVerifyView()
}
