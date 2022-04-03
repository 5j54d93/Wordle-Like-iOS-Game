//
//  TitleView.swift
//  Wordle-Like-iOS-Game
//
//  Created by 莊智凱 on 2022/3/29.
//

import SwiftUI

struct TitleView: View {
    
    @State private var showHowToPlay = false
    @State private var showSettings = false
    @Binding var wordle : Wordle
    
    var body: some View {
        ZStack {
            Text("Wordle")
                .bold()
                .font(.largeTitle)
                .frame(maxWidth: .infinity)
            
            HStack(spacing: 5) {
                Button {
                    showHowToPlay = true
                } label: {
                    Text(Image(systemName: "questionmark.circle"))
                        .bold()
                        .foregroundColor(.black)
                }
                
                Spacer()
                
                Button {
                    wordle.showResult = true
                } label: {
                    Text(Image(systemName: "chart.bar"))
                        .bold()
                        .foregroundColor(.black)
                }
                
                Button {
                    showSettings = true
                } label: {
                    Text(Image(systemName: "gearshape.fill"))
                        .bold()
                        .foregroundColor(.black)
                }
            }
            .font(.title)
        }
        .sheet(isPresented: $showHowToPlay) {
            HowToPlayView()
        }
        .sheet(isPresented: $wordle.showResult) {
            ResultView(wordle: $wordle)
        }
        .fullScreenCover(isPresented: $showSettings) {
            SettingsView(wordle: $wordle, showSettings: $showSettings)
        }
    }
}
