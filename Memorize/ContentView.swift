//
//  ContentView.swift
//  Memorize
//
//  Created by Aadithya Jayakaran on 24/01/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack{
            HStack{
                CardView()
                CardView()
                CardView()
                CardView()
            }
            HStack{
                CardView()
                CardView()
                CardView()
                CardView()
            }
            
        }

        .foregroundColor(.blue)
    }
}

struct CardView: View {
    @State var isFaceup : Bool = false
    var body: some View {
        ZStack {
            if(isFaceup){
                RoundedRectangle(cornerRadius: 23)
                    .stroke(lineWidth: 3)
                RoundedRectangle(cornerRadius: 23)
                    .fill(.white)
                Text("🙃")
                    .font(.largeTitle)
            }
            else{
                RoundedRectangle(cornerRadius: 23)
                    .stroke(lineWidth: 3)
                RoundedRectangle(cornerRadius: 23)
                    .fill(.red)
            }
        }
        .padding()
        .onTapGesture {
            isFaceup.toggle()
        }
    }
}

#Preview {
    ContentView()
}
