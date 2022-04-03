//
//  ResultView.swift
//  Wordle-Like-iOS-Game
//
//  Created by 莊智凱 on 2022/3/30.
//

import SwiftUI

struct ResultView: View {
    
    @AppStorage("played") var played = 0
    @AppStorage("winTime") var winTime = 0
    @AppStorage("currentStreak") var currentStreak = 0
    @AppStorage("maxStreak") var maxStreak = 0
    @AppStorage("letters") var letters = 5
    
    @State private var resultEmojis = ""
    @State private var showCopyAlert = false
    
    @Binding var wordle : Wordle
    
    var body: some View {
        VStack(spacing: 20) {
            Text("STATISTICS")
                .bold()
                .font(.title)
            
            HStack(alignment: .top, spacing: 20) {
                VStack {
                    Text("\(played)")
                        .font(.largeTitle)
                    Text("Played")
                }
                VStack {
                    Text(played == 0 ? "0" : "\(Double(winTime)/Double(played)*100, specifier: "%.2f")")
                        .font(.largeTitle)
                    Text("Win %")
                }
                VStack {
                    Text("\(currentStreak)")
                        .font(.largeTitle)
                    Text("Current")
                    Text("Streak")
                }
                VStack {
                    Text("\(maxStreak)")
                        .font(.largeTitle)
                    Text("Max")
                    Text("Streak")
                }
            }
            
            HStack {
                VStack(spacing: 10) {
                    Text("WORDLE RECORD")
                        .bold()
                        .font(.title2)
                    
                    Text(resultEmojis)
                        .font(.title3)
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal)
                }
                
                if (wordle.win != .playing) {
                    Divider()
                        .background(.black)
                        .frame(height: 200)
                    
                    Text(wordle.answer)
                        .bold()
                        .font(.title)
                        .padding(.vertical, 15)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .background(.black)
                        .cornerRadius(5)
                        .padding(.horizontal)
                }
            }
            
            HStack {
                VStack(spacing: 10) {
                    Text("NEXT WORDLE")
                        .bold()
                        .font(.title2)
                    
                    Text("\(wordle.time/60)：\(String(format:"%02d",wordle.time%60))")
                        .bold()
                        .font(.largeTitle)
                }
                .frame(maxWidth: .infinity)
                
                Divider()
                    .background(.black)
                    .frame(height: 100)
                
                Button {
                    UIPasteboard.general.string = resultEmojis
                    showCopyAlert = true
                } label: {
                    Text("SHARE")
                        .bold()
                        .font(.title)
                        .padding(.vertical, 15)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .background(Color(red: 108/255, green: 170/255, blue: 100/255))
                        .cornerRadius(5)
                        .padding(.horizontal)
                }
                .alert("Copied results to clipboard", isPresented: $showCopyAlert, actions: {
                    Button("OK") {
                        showCopyAlert = false
                    }
                })
            }
            
            if (wordle.win != .playing && wordle.time == 0) {
                Button {
                    wordle.gameStart()
                    wordle.showResult = false
                } label: {
                    Text("NEXT WORDLE")
                        .bold()
                        .font(.title)
                        .padding(.vertical, 15)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .background(Color(red: 92/255, green: 120/255, blue: 244/255))
                        .cornerRadius(5)
                }
            }
            
            Spacer()
        }
        .padding()
        .onAppear {
            for row in 0..<6 {
                for column in 0..<letters {
                    switch wordle.grids[row*letters + column].type {
                    case .correct:
                        resultEmojis += "🟩"
                    case .wrongSpot:
                        resultEmojis += "🟨"
                    case .notInAnswer:
                        resultEmojis += "⬛️"
                    default:
                        resultEmojis += "⬜️"
                    }
                }
                if (row != 5) {
                    resultEmojis += "\n"
                }
            }
        }
    }
}
