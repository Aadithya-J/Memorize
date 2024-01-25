//
//  ContentView.swift
//  Memorize
//
//  Created by Aadithya Jayakaran on 24/01/24.
//

import SwiftUI

struct ContentView: View {
    let emojis : [String] = ["🚗", "🚁", "🚀", "🚤", "🛸", "🚲", "🛴", "🚚", "🚓", "🚑", "🚐", "🎃", "👻", "👽", "🤖", "🦄", "🧙‍♂️", "🧟‍♂️", "🚁", "🚢", "🛵", "🚋", "🚎", "🦕", "🦜", "🚡", "🎠", "🚖", "🏍️"]
    @State var num: Int = 4
    var body: some View {
        VStack{
            cards
            
            Spacer()
            
            HStack {
                cardRemover
                
                Spacer()
                
                cardAdder
            }
            .padding(.horizontal)
        }

        .foregroundColor(.blue)
        
    }
    var cards: some View {
        VStack {
            HStack{
                ForEach(0..<num, id : \.self){index in
                    CardView(content: emojis[index])
                }
            }
            HStack{
                ForEach(num..<num*2, id : \.self){index in
                    CardView(content: emojis[index])
                }
            }
            
        }
    }
    
    var cardRemover: some View {
        Button(action: {
            if(num > 0){
                num-=1
            }
        }, label: {
            Image(systemName: "minus.circle").font(.largeTitle)
            
        })
    }
    
    var cardAdder: some View {
        Button(action: {
            if(num < 7){
                num+=1
            }
        }, label: {
            Image(systemName: "plus.circle").font(.largeTitle)
            
        })
    }
}

struct CardView: View {
    var content = "🛸"
    @State var isFaceup : Bool = true
    var body: some View {
        ZStack {
            if(isFaceup){
                RoundedRectangle(cornerRadius: 23)
                    .stroke(lineWidth: 3)
                RoundedRectangle(cornerRadius: 23)
                    .fill(.white)
                Text(content)
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
