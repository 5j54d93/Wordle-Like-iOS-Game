//
//  GameTypeView.swift
//  Wordle-Like-iOS-Game
//
//  Created by 莊智凱 on 2022/3/30.
//

import SwiftUI

struct GameTypeView: View {
    
    @AppStorage("topic") var topic = "Animal"
    @AppStorage("letters") var letters = 5
    
    @Binding var wordle : Wordle
    
    var body: some View {
        HStack {
            Text("Topic：\(topic)")
                .padding(.vertical, 8)
                .frame(maxWidth: .infinity)
                .background(Color(red: 92/255, green: 120/255, blue: 244/255))
                .cornerRadius(7)
            
            Text("Letters：\(letters)")
                .padding(.vertical, 8)
                .frame(width: 140)
                .background(Color(red: 92/255, green: 120/255, blue: 244/255))
                .cornerRadius(7)
        }
        .font(.title2)
        .foregroundColor(.white)
    }
}
