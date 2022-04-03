//
//  KeyBoardView.swift
//  Wordle-Like-iOS-Game
//
//  Created by 莊智凱 on 2022/3/30.
//

import SwiftUI

struct KeyBoardView: View {
    
    @AppStorage("topic") var topic = "Animal"
    
    @Binding var wordle : Wordle
    @Binding var timer : Timer?
    
    var body: some View {
        HStack {
            ForEach(wordle.keyBoardFirstRow.indices, id: \.self) { i in
                Button {
                    if (wordle.index == 0 && timer == nil) {
                        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (_) in
                            wordle.time -= 1
                            if(wordle.time == 0) {
                                self.timer?.invalidate()
                            }
                        }
                    }
                    wordle.typing(key: wordle.keyBoardFirstRow[i].value)
                } label: {
                    switch wordle.keyBoardFirstRow[i].type {
                    case .correct:
                        CorrectKeyView(key: wordle.keyBoardFirstRow[i].value)
                    case .wrongSpot:
                        WrongSpotKeyView(key: wordle.keyBoardFirstRow[i].value)
                    case .notInAnswer:
                        NotInAnswerKeyView(key: wordle.keyBoardFirstRow[i].value)
                    default:
                        DefaultKeyView(key: wordle.keyBoardFirstRow[i].value)
                    }
                }
                .cornerRadius(4)
            }
        }
        
        HStack {
            ForEach(wordle.keyBoardSecondRow.indices, id: \.self) { i in
                Button {
                    if (wordle.index == 0 && timer == nil) {
                        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (_) in
                            wordle.time -= 1
                            if(wordle.time == 0) {
                                self.timer?.invalidate()
                            }
                        }
                    }
                    wordle.typing(key: wordle.keyBoardSecondRow[i].value)
                } label: {
                    switch wordle.keyBoardSecondRow[i].type {
                    case .correct:
                        CorrectKeyView(key: wordle.keyBoardSecondRow[i].value)
                    case .wrongSpot:
                        WrongSpotKeyView(key: wordle.keyBoardSecondRow[i].value)
                    case .notInAnswer:
                        NotInAnswerKeyView(key: wordle.keyBoardSecondRow[i].value)
                    default:
                        DefaultKeyView(key: wordle.keyBoardSecondRow[i].value)
                    }
                }
                .cornerRadius(4)
            }
        }
        .padding(.horizontal, 20)
        
        HStack {
            Button {
                wordle.checkAnswer()
            } label: {
                Text("ENTER")
                    .font(.headline)
                    .foregroundColor(.black)
                    .frame(width: 70)
                    .padding(.vertical, 15)
                    .alert("Not a \(topic) word", isPresented: $wordle.showAlert, actions: {
                        Button("OK") {
                            wordle.showAlert = false
                        }
                    })
                    .sheet(isPresented: $wordle.showResult) {
                        ResultView(wordle: $wordle)
                    }
            }
            .background(.quaternary)
            .cornerRadius(4)
            
            ForEach(wordle.keyBoardThirdRow.indices, id: \.self) { i in
                Button {
                    if (wordle.index == 0 && timer == nil) {
                        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (_) in
                            wordle.time -= 1
                            if(wordle.time == 0) {
                                self.timer?.invalidate()
                            }
                        }
                    }
                    wordle.typing(key: wordle.keyBoardThirdRow[i].value)
                } label: {
                    switch wordle.keyBoardThirdRow[i].type {
                    case .correct:
                        CorrectKeyView(key: wordle.keyBoardThirdRow[i].value)
                    case .wrongSpot:
                        WrongSpotKeyView(key: wordle.keyBoardThirdRow[i].value)
                    case .notInAnswer:
                        NotInAnswerKeyView(key: wordle.keyBoardThirdRow[i].value)
                    default:
                        DefaultKeyView(key: wordle.keyBoardThirdRow[i].value)
                    }
                }
                .cornerRadius(4)
            }
            
            Button {
                wordle.delete()
            } label: {
                Text(Image(systemName: "delete.left"))
                    .bold()
                    .font(.title3)
                    .foregroundColor(.black)
                    .frame(width: 35)
                    .padding(.vertical, 15)
            }
            .background(.quaternary)
            .cornerRadius(4)
        }
    }
}

struct DefaultKeyView: View {
    
    var key : Character
    
    var body: some View {
        Text(String(key))
            .font(.headline)
            .foregroundColor(.black)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 15)
            .background(Color(red: 212/255, green: 214/255, blue: 218/255))
    }
}

struct CorrectKeyView: View {
    
    @AppStorage("correctColor") var correctColor = Color(red: 108/255, green: 170/255, blue: 100/255)
    
    var key : Character
    
    var body: some View {
        Text(String(key))
            .font(.headline)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 15)
            .background(correctColor)
    }
}

struct WrongSpotKeyView: View {
    
    @AppStorage("wrongSpotColor") var wrongSpotColor = Color(red: 200/255, green: 180/255, blue: 88/255)
    
    var key : Character
    
    var body: some View {
        Text(String(key))
            .font(.headline)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 15)
            .background(wrongSpotColor)
    }
}

struct NotInAnswerKeyView: View {
    
    @AppStorage("notInAnswerColor") var notInAnswerColor = Color.gray
    
    var key : Character
    
    var body: some View {
        Text(String(key))
            .font(.headline)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 15)
            .background(notInAnswerColor)
    }
}
