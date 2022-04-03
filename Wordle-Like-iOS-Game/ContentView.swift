//
//  ContentView.swift
//  Wordle-Like-iOS-Game
//
//  Created by 莊智凱 on 2022/3/29.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("letters") var letters = 5
    
    @State private var wordle = Wordle()
    @State private var timer: Timer?
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                TitleView(wordle: $wordle)
                GameTypeView(wordle: $wordle)
                Spacer()
                GameGridsView(wordle: $wordle, geometry: geometry)
                Spacer()
                KeyBoardView(wordle: $wordle, timer: $timer)
            }
            .padding(.horizontal)
            .padding(.bottom)
            .onAppear {
                if (wordle.grids[0] == Grid(value: " ", type: Grid.gridType.blank)) {
                    wordle.gameStart()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
