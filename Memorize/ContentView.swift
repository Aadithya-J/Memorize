import SwiftUI

struct ContentView: View {
    let fantasyEmojis: [String] = [
        "🧚", "🧙‍♂️", "🧜", "🔮", "🏰", "🗝️", "🚪", "🌈", "🦄", "👑",
        "🌟", "📜", "🕯️", "🦔", "🐉", "🌄", "🏹", "🕰️", "🗡️", "🎭",
        "🦇", "🌙", "🧞", "🔥", "👻", "🍄", "🎩", "👽", "⚔️", "🛡️",
    ]

    let spaceAlienEmojis: [String] = [
        "👽", "🛸", "🚀", "🌌", "🛰️", "💫", "🪐", "🌠", "🌕",
        "☄️", "🌠", "💫", "🛰️","👨‍🚀","👾","🔭","🌏"
    ]

    let techEmojis: [String] = [
        "💻", "🖥️", "📱", "⌚", "🖨️", "🕹️", "🔧", "🔌", "🛠️", "🔍",
        "📡", "🔗", "🔬", "📽️", "🎮", "🎧", "🎤", "📷", "🎥", "📹",
        "📼", "📺", "🕰️", "💡", "🔦", "🚀", "🚁",
    ]

    @State var emojis: [String] = []
    @State var themeColor: Color = .blue
    @State var count = 0
    @State var num: Int = 0
    

    var body: some View {
        VStack {
            Text("Memorize!")
                .font(.largeTitle)

            Spacer()

            if num == 0 {
                Text("Choose theme")
                    .font(.largeTitle)
            } else {
                cards
            }

            Spacer()

            VStack {
                HStack {
                    Spacer()
                    themeButton(themeEmojis: fantasyEmojis, icon: "🔮", color: .purple)
                    Spacer()
                    themeButton(themeEmojis: spaceAlienEmojis, icon: "🚀", color: Color(red: 25/255, green: 25/255, blue: 112/255))
                    Spacer()
                    themeButton(themeEmojis: techEmojis, icon: "💻", color: .gray)
                    Spacer()
                }
                .padding(.horizontal)
                shuffleButton
            }
        }
        .foregroundColor(themeColor)
    }

    var cards: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: CGFloat(count * 5)))], content: {
                    ForEach(0..<num, id: \.self) { index in
                        CardView(content: emojis[index], cardColor: themeColor).aspectRatio(2/3, contentMode: .fit)
                    }
                })
            }
        }
    }

    var shuffleButton: some View {
        Button(action: {
            self.emojis.shuffle()
        }, label: {
            RoundedRectangle(cornerRadius: 15)
                .strokeBorder(lineWidth: 3)
                .frame(width: 150, height: 40)
                .overlay(Text("Shuffle"))
        })
    }

    func themeButton(themeEmojis: [String], icon: String, color: Color) -> some View {
        Button(action: {
            let x = Int.random(in: 7...12)
            self.emojis = Array(themeEmojis.shuffled().prefix(x)) + Array(themeEmojis.shuffled().prefix(x))
            self.themeColor = color
            self.count = x * 2
            if num == 0 {
                num = emojis.count
            }
        }, label: {
            Circle()
                .strokeBorder(lineWidth: 3)
                .frame(width: 38, height: 40)
                .overlay(
                    Text(icon).font(.system(size: 20))
                )
        })
    }
}

struct CardView: View {
    var content = "🛸"
    var cardColor: Color = .white
    @State var isFaceup: Bool = false

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 23)
                .stroke(lineWidth: 3)
            RoundedRectangle(cornerRadius: 23)
                .fill(cardColor)
            ZStack {
                RoundedRectangle(cornerRadius: 23)
                    .fill(.white)
                Text(content)
                    .font(.largeTitle)
            }
            .opacity(isFaceup ? 1 : 0)
        }

        .padding()
        .onTapGesture {
            isFaceup.toggle()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

