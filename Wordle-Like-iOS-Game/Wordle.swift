//
//  Wordle.swift
//  Wordle-Like-iOS-Game
//
//  Created by 莊智凱 on 2022/3/30.
//

import Foundation
import SwiftUI

struct Grid: Equatable {
    enum gridType { case blank, typing, correct, wrongSpot, notInAnswer }
    
    var value : Character
    var type : gridType
}

struct Wordle {
    enum game { case playing, win, lose }
    
    @AppStorage("played") var played = 0
    @AppStorage("winTime") var winTime = 0
    @AppStorage("lastWin") var lastWin = false
    @AppStorage("currentStreak") var currentStreak = 0
    @AppStorage("maxStreak") var maxStreak = 0
    @AppStorage("topic") var topic = "Animal"
    @AppStorage("letters") var letters = 5
    
    var grids = Array(repeating: Grid(value: " ", type: Grid.gridType.blank), count: 30)
    var index = 0
    var answer = ""
    var showAlert = false
    var showResult = false
    var win = game.playing
    var time = 300
    
    var keyBoardFirstRow = [Grid(value: "Q", type: Grid.gridType.blank), Grid(value: "W", type: Grid.gridType.blank), Grid(value: "E", type: Grid.gridType.blank), Grid(value: "R", type: Grid.gridType.blank), Grid(value: "T", type: Grid.gridType.blank), Grid(value: "Y", type: Grid.gridType.blank), Grid(value: "U", type: Grid.gridType.blank), Grid(value: "I", type: Grid.gridType.blank), Grid(value: "O", type: Grid.gridType.blank), Grid(value: "P", type: Grid.gridType.blank)]
    var keyBoardSecondRow = [Grid(value: "A", type: Grid.gridType.blank), Grid(value: "S", type: Grid.gridType.blank), Grid(value: "D", type: Grid.gridType.blank), Grid(value: "F", type: Grid.gridType.blank), Grid(value: "G", type: Grid.gridType.blank), Grid(value: "H", type: Grid.gridType.blank), Grid(value: "J", type: Grid.gridType.blank), Grid(value: "K", type: Grid.gridType.blank), Grid(value: "L", type: Grid.gridType.blank)]
    var keyBoardThirdRow = [Grid(value: "Z", type: Grid.gridType.blank), Grid(value: "X", type: Grid.gridType.blank), Grid(value: "C", type: Grid.gridType.blank), Grid(value: "V", type: Grid.gridType.blank), Grid(value: "B", type: Grid.gridType.blank), Grid(value: "N", type: Grid.gridType.blank), Grid(value: "M", type: Grid.gridType.blank)]
    
    mutating func gameStart() {
        keyBoardFirstRow = [Grid(value: "Q", type: Grid.gridType.blank), Grid(value: "W", type: Grid.gridType.blank), Grid(value: "E", type: Grid.gridType.blank), Grid(value: "R", type: Grid.gridType.blank), Grid(value: "T", type: Grid.gridType.blank), Grid(value: "Y", type: Grid.gridType.blank), Grid(value: "U", type: Grid.gridType.blank), Grid(value: "I", type: Grid.gridType.blank), Grid(value: "O", type: Grid.gridType.blank), Grid(value: "P", type: Grid.gridType.blank)]
        keyBoardSecondRow = [Grid(value: "A", type: Grid.gridType.blank), Grid(value: "S", type: Grid.gridType.blank), Grid(value: "D", type: Grid.gridType.blank), Grid(value: "F", type: Grid.gridType.blank), Grid(value: "G", type: Grid.gridType.blank), Grid(value: "H", type: Grid.gridType.blank), Grid(value: "J", type: Grid.gridType.blank), Grid(value: "K", type: Grid.gridType.blank), Grid(value: "L", type: Grid.gridType.blank)]
        keyBoardThirdRow = [Grid(value: "Z", type: Grid.gridType.blank), Grid(value: "X", type: Grid.gridType.blank), Grid(value: "C", type: Grid.gridType.blank), Grid(value: "V", type: Grid.gridType.blank), Grid(value: "B", type: Grid.gridType.blank), Grid(value: "N", type: Grid.gridType.blank), Grid(value: "M", type: Grid.gridType.blank)]
        grids = Array(repeating: Grid(value: " ", type: Grid.gridType.blank), count: letters * 6)
        index = 0
        win = .playing
        time = 300
        if let asset = NSDataAsset(name: "\(topic)\(letters)"),
           let content = String(data: asset.data, encoding: .utf8) {
            let words = content.split(separator: "\n").map({ substring in
                return String(substring)
            })
            answer = words.randomElement()!
        }
    }
    
    mutating func typing(key: Character) {
        if (
            index < letters * 6
            &&
            win == .playing
            &&
            (index == 0
             || index % letters != 0
             || index % letters == 0 && grids[index-1].type != .typing)
        ) {
            grids[index].value = key
            grids[index].type = .typing
            index += 1
        }
    }
    
    mutating func delete() {
        if (index != 0 && grids[index-1].type == .typing) {
            grids[index-1].value = " "
            grids[index-1].type = .blank
            index -= 1
        }
    }
    
    mutating func checkAnswer() {
        if (index != 0 && index % letters == 0) {
            var word = ""
            for i in 0..<letters {
                word += String(grids[index-(letters-i)].value)
            }
            if let asset = NSDataAsset(name: "\(topic)\(letters)"),
               let content = String(data: asset.data, encoding: .utf8) {
                let words = content.split(separator: "\n").map({ substring in
                    return String(substring)
                })
                if (!words.contains(word)) {
                    showAlert = true
                } else if (word == answer) {
                    for i in 0..<letters {
                        grids[index-(letters-i)].type = .correct
                        for idx in keyBoardFirstRow.indices {
                            if (keyBoardFirstRow[idx].value == grids[index-(letters-i)].value) {
                                keyBoardFirstRow[idx].type = .correct
                            }
                        }
                        for idx in keyBoardSecondRow.indices {
                            if (keyBoardSecondRow[idx].value == grids[index-(letters-i)].value) {
                                keyBoardSecondRow[idx].type = .correct
                            }
                        }
                        for idx in keyBoardThirdRow.indices {
                            if (keyBoardThirdRow[idx].value == grids[index-(letters-i)].value) {
                                keyBoardThirdRow[idx].type = .correct
                            }
                        }
                    }
                    win = game.win
                    showResult = true
                    played += 1
                    winTime += 1
                    if (lastWin) {
                        currentStreak += 1
                    } else {
                        currentStreak = 1
                    }
                    if (currentStreak > maxStreak) {
                        maxStreak = currentStreak
                    }
                    lastWin = true
                } else {
                    for i in 0..<letters {
                        if (grids[index-(letters-i)].value == Array(answer)[i]) {
                            grids[index-(letters-i)].type = .correct
                            for idx in keyBoardFirstRow.indices {
                                if (keyBoardFirstRow[idx].value == grids[index-(letters-i)].value) {
                                    keyBoardFirstRow[idx].type = .correct
                                }
                            }
                            for idx in keyBoardSecondRow.indices {
                                if (keyBoardSecondRow[idx].value == grids[index-(letters-i)].value) {
                                    keyBoardSecondRow[idx].type = .correct
                                }
                            }
                            for idx in keyBoardThirdRow.indices {
                                if (keyBoardThirdRow[idx].value == grids[index-(letters-i)].value) {
                                    keyBoardThirdRow[idx].type = .correct
                                }
                            }
                        } else if (answer.contains(grids[index-(letters-i)].value)) {
                            grids[index-(letters-i)].type = .wrongSpot
                            for idx in keyBoardFirstRow.indices {
                                if (keyBoardFirstRow[idx].value == grids[index-(letters-i)].value) {
                                    if (keyBoardFirstRow[idx].type == .blank) {
                                        keyBoardFirstRow[idx].type = .wrongSpot
                                    }
                                }
                            }
                            for idx in keyBoardSecondRow.indices {
                                if (keyBoardSecondRow[idx].value == grids[index-(letters-i)].value) {
                                    if (keyBoardSecondRow[idx].type == .blank) {
                                        keyBoardSecondRow[idx].type = .wrongSpot
                                    }
                                }
                            }
                            for idx in keyBoardThirdRow.indices {
                                if (keyBoardThirdRow[idx].value == grids[index-(letters-i)].value) {
                                    if (keyBoardThirdRow[idx].type == .blank) {
                                        keyBoardThirdRow[idx].type = .wrongSpot
                                    }
                                }
                            }
                        } else {
                            grids[index-(letters-i)].type = .notInAnswer
                            for idx in keyBoardFirstRow.indices {
                                if (keyBoardFirstRow[idx].value == grids[index-(letters-i)].value) {
                                    if (keyBoardFirstRow[idx].type == .blank) {
                                        keyBoardFirstRow[idx].type = .notInAnswer
                                    }
                                }
                            }
                            for idx in keyBoardSecondRow.indices {
                                if (keyBoardSecondRow[idx].value == grids[index-(letters-i)].value) {
                                    if (keyBoardSecondRow[idx].type == .blank) {
                                        keyBoardSecondRow[idx].type = .notInAnswer
                                    }
                                }
                            }
                            for idx in keyBoardThirdRow.indices {
                                if (keyBoardThirdRow[idx].value == grids[index-(letters-i)].value) {
                                    if (keyBoardThirdRow[idx].type == .blank) {
                                        keyBoardThirdRow[idx].type = .notInAnswer
                                    }
                                }
                            }
                        }
                    }
                    if (index == letters * 6) {
                        win = game.lose
                        showResult = true
                        played += 1
                        lastWin = false
                        currentStreak = 0
                    }
                }
            }
        }
    }
}
