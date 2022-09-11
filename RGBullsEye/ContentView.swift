import SwiftUI

struct ContentView: View {
    // MARK: - Properties
    @State var game = Game()
    @State var guess: RGB
    @State var showScore = false
    
    // MARK: - Body
    var body: some View {
        VStack {
            ColorCircle(rgb: game.target)
            if !showScore {
                Text("R: ??? G: ??? B: ???")
                    .padding()
            } else {
                Text(game.target.intString())
                    .padding()
            }
            ColorCircle(rgb: guess)
            Text(guess.intString())
                .padding()
            ColorSlider(value: $guess.red, trackColor: .red)
            ColorSlider(value: $guess.green, trackColor: .green)
            ColorSlider(value: $guess.blue, trackColor: .blue)
            Button {
                showScore = true
                game.check(guess: guess)
            } label: {
                Text("Hit me!")
            }
            .alert(isPresented: $showScore) {
                Alert(title: Text("Your score"), message: Text(String(game.scoreRound)), dismissButton: .default(Text("OK"), action: {
                    game.startNewRound()
                    guess = RGB()
                }))
            }

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(guess: RGB())
    }
}

struct ColorSlider: View {
    @Binding var value: Double
    var trackColor: Color
    
    var body: some View {
        HStack {
            Text("0")
            Slider(value: $value)
                .accentColor(trackColor)
            Text("255")
        }
        .padding(.horizontal)
    }
}

struct ColorCircle: View {
    var rgb: RGB
    var body: some View {
        Circle()
            .fill(Color(rgbStruct: rgb))
    }
}
