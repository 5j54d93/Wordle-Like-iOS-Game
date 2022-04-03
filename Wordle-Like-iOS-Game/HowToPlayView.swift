//
//  HowToPlayView.swift
//  Wordle-Like-iOS-Game
//
//  Created by 莊智凱 on 2022/3/30.
//

import SwiftUI

struct HowToPlayView: View {
    
    @AppStorage("correctColor") var correctColor = Color(red: 108/255, green: 170/255, blue: 100/255)
    @AppStorage("wrongSpotColor") var wrongSpotColor = Color(red: 200/255, green: 180/255, blue: 88/255)
    @AppStorage("notInAnswerColor") var notInAnswerColor = Color.gray
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading, spacing: 20) {
                Group {
                    Text("HOW TO PLAY")
                        .bold()
                        .font(.title)
                        .frame(maxWidth: .infinity)
                    
                    (Text("Guess the ") + Text("WORDLE").bold() + Text(" in six tries."))
                    
                    Text("Each guess must be a valid five-letter word. Hit the enter button to submit.")
                    
                    Text("After each guess, the color of the tiles will change to show how close your guess was to the word.")
                    
                    Divider()
                }
                
                Group {
                    Text("Examples")
                        .bold()
                        .font(.title3)
                    
                    HStack {
                        Text("W")
                            .bold()
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            .frame(width:geometry.size.width/10, height: geometry.size.width/10)
                            .background(correctColor)
                        Text("E")
                            .bold()
                            .font(.largeTitle)
                            .frame(width:geometry.size.width/10, height: geometry.size.width/10)
                            .border(.gray, width: 3)
                        Text("A")
                            .bold()
                            .font(.largeTitle)
                            .frame(width:geometry.size.width/10, height: geometry.size.width/10)
                            .border(.gray, width: 3)
                        Text("R")
                            .bold()
                            .font(.largeTitle)
                            .frame(width:geometry.size.width/10, height: geometry.size.width/10)
                            .border(.gray, width: 3)
                        Text("Y")
                            .bold()
                            .font(.largeTitle)
                            .frame(width:geometry.size.width/10, height: geometry.size.width/10)
                            .border(.gray, width: 3)
                    }
                    
                    (Text("The letter ") + Text("W").bold() + Text(" is in the word and in the correct spot."))
                    
                    HStack {
                        Text("P")
                            .bold()
                            .font(.largeTitle)
                            .frame(width:geometry.size.width/10, height: geometry.size.width/10)
                            .border(.gray, width: 3)
                        Text("I")
                            .bold()
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            .frame(width:geometry.size.width/10, height: geometry.size.width/10)
                            .background(wrongSpotColor)
                        Text("L")
                            .bold()
                            .font(.largeTitle)
                            .frame(width:geometry.size.width/10, height: geometry.size.width/10)
                            .border(.gray, width: 3)
                        Text("L")
                            .bold()
                            .font(.largeTitle)
                            .frame(width:geometry.size.width/10, height: geometry.size.width/10)
                            .border(.gray, width: 3)
                        Text("S")
                            .bold()
                            .font(.largeTitle)
                            .frame(width:geometry.size.width/10, height: geometry.size.width/10)
                            .border(.gray, width: 3)
                    }
                    
                    (Text("The letter ") + Text("I").bold() + Text(" is in the word but in the wrong spot."))
                    
                    HStack {
                        Text("V")
                            .bold()
                            .font(.largeTitle)
                            .frame(width:geometry.size.width/10, height: geometry.size.width/10)
                            .border(.gray, width: 3)
                        Text("A")
                            .bold()
                            .font(.largeTitle)
                            .frame(width:geometry.size.width/10, height: geometry.size.width/10)
                            .border(.gray, width: 3)
                        Text("G")
                            .bold()
                            .font(.largeTitle)
                            .frame(width:geometry.size.width/10, height: geometry.size.width/10)
                            .border(.gray, width: 3)
                        Text("U")
                            .bold()
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            .frame(width:geometry.size.width/10, height: geometry.size.width/10)
                            .background(notInAnswerColor)
                        Text("E")
                            .bold()
                            .font(.largeTitle)
                            .frame(width:geometry.size.width/10, height: geometry.size.width/10)
                            .border(.gray, width: 3)
                    }
                    
                    (Text("The letter ") + Text("U").bold() + Text(" is not in the word in any spot."))
                    
                    Divider()
                }
                
                Text("A new WORDLE will be available each 5 minutes!")
                    .bold()
                
                Spacer()
            }
            .padding()
        }
    }
}
