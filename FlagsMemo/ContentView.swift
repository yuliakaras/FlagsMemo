import SwiftUI

struct ContentView: View {
    
    @State private var countries = ["Argentina", "Bangladesh", "Brazil", "Canada", "Germany", "Greece", "Russia", "Sweden", "UK", "USA"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var score = 0
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    var body: some View {
        ZStack{
            LinearGradient(colors: [.gray, .teal], startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20){
                VStack{
                    Text("Choose flag: ")
                        .foregroundColor(Color.white)
                        .font(.headline)
                    Text(countries[correctAnswer])
                        .foregroundColor(Color.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                    }
                ForEach(0..<3){ number in
                    Button(action: {
                        self.flagTapped(number)
                        self.showingScore = true
                    })
                    {
                        Image(self.countries[number])
                            .renderingMode(.original)
                            .frame(width: 250, height: 125)
                            
                    }
                }
                
                Text("Score: \(score)")
                    .font(.largeTitle)
                    .fontWeight(.black)
                
                Spacer()
            }
        }.alert(isPresented: $showingScore){
            Alert(title: Text(scoreTitle), message: Text("Score: \(score)"), dismissButton: .default(Text("Continue")) {
                self.askQuestion() })
        }
    }
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func flagTapped(_ number: Int){
        if number == correctAnswer {
            scoreTitle = "Right answer!"
            score += 1
        } else {
            scoreTitle = "Wrong answer! This is flag of \(countries[number])"
            score -= 1
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
