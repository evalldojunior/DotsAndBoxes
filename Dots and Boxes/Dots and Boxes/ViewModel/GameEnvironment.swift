//
//  GameEnvironment.swift
//  Dots and Boxes
//
//  Created by Evaldo Garcia de Souza Júnior on 12/04/21.
//
public enum chosenLineType {
    case top, bottom, left, right
}

import Foundation
import SwiftUI
import UIKit

class GameEnvironment: ObservableObject {
    @Published var player1Color: Color = Color(UIColor.systemIndigo)
    @Published var player2Color: Color = Color(UIColor.systemIndigo)
    @Published var turn: turn = .player1
    @Published var player1Points: Int?
    @Published var player2Points: Int?
    @Published var player1Name: String = "socorro"
    @Published var player2Name: String = "socorro"
    @Published var player1ExtraLife: [Bool]?
    @Published var player2ExtraLife: [Bool]?
    @Published var endGame: Bool = false
    @Published var winner: turn?
    @Published var pause: Bool?
    
    @Published var secondsRemaining: CGFloat = 1.0
    @Published var secondsRemainingInt: Int = 5
    var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var timerFloat = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var colorTurn: Color?
    var rowCount: Int?
    var colCount: Int?
    
    var chosenBoxIndexX: Int?
    var chosenBoxIndexY: Int?
    
    var allBoxes: [[Box]] = []
    
    var totalPointsCount: Int = 0
    var totalPoints: Int?
    var endExtraLife: Bool = false
    
    init(rowCount: Int, colCount: Int, player1Name: String, player2Name: String, player1Color: Color, player2Color: Color) {
        self.rowCount = rowCount
        self.colCount = colCount
        self.totalPoints = rowCount * colCount
        
        self.player1Name = player1Name
        self.player2Name = player2Name
        self.player1Color = player1Color
        self.player2Color = player2Color
        
        var auxBox: [Box] = []
        for _ in 0...rowCount-1 {
            auxBox = []
            for _ in 0...colCount-1 {
                auxBox.append(Box())
            }
            allBoxes.append(auxBox)
        }
        
        self.colorTurn = player1Color
        self.player1Points = 0
        self.player2Points = 0
        self.player1ExtraLife = [true, true, true]
        self.player2ExtraLife = [true, true, true]
        
        self.pause = true
    }
    
    enum turn {
        case player1, player2
    }
    
    func resetGame(){
        allBoxes.removeAll()
        var auxBox: [Box] = []
        for _ in 0...rowCount!-1 {
            auxBox = []
            for _ in 0...colCount!-1 {
                auxBox.append(Box())
            }
            allBoxes.append(auxBox)
        }
        self.turn = .player1
        self.colorTurn = player1Color
        self.player1Points = 0
        self.player2Points = 0
        self.player1ExtraLife = [true, true, true]
        self.player2ExtraLife = [true, true, true]
        self.pause = false
        self.endGame = false
        self.totalPointsCount = 0
        self.endExtraLife = false
        self.startCountDown()
    }
    
    func switchTurn() {
        if self.turn == .player1 {
            self.turn = .player2
            withAnimation(){
                self.colorTurn = player2Color
            }
        } else {
            self.turn = .player1
            withAnimation(){
                self.colorTurn = player1Color
                
            }
        }
    }
    
    func pauseGame() {
        AudioPlayer.shared.play(name: "pauseSound", volume: 0.5, delay: 0.0)
        if pause! {
            self.timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
            self.timerFloat = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
        } else {
            self.timer.upstream.connect().cancel()
            self.timerFloat.upstream.connect().cancel()
        }
        withAnimation(){
            self.pause!.toggle()
        }
    }
    
    func updatePoints() {
        AudioPlayer.shared.play(name: "boxSound", volume: 0.2, delay: 0.0)
        if self.turn == .player1 {
            self.player1Points! += 1
            self.totalPointsCount += 1
            self.objectWillChange.send()
        } else {
            self.player2Points! += 1
            self.totalPointsCount += 1
            self.objectWillChange.send()
        }
        if (totalPointsCount == totalPoints) {
            self.timer.upstream.connect().cancel()
            self.timerFloat.upstream.connect().cancel()
            if self.player1Points! > self.player2Points! {
                self.winner = .player1
            } else if self.player2Points! > self.player1Points! {
                self.winner = .player2
            } else {
                // if player1Count == player2Count, the winner is the player2 (this balances the advantage of the first move)
                self.winner = .player2
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                AudioPlayer.shared.play(name: "winSound", volume: 0.4, delay: 0.0)
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                withAnimation() {
                    self.endGame = true
                }
            }
        }
    }
    
    func checkNext(indexX: Int, indexY: Int)  -> Bool{
        if allBoxes[indexX][indexY].checkCompleteBox(colorBox: self.colorTurn!) {
            self.updatePoints()
            return true
        } else {
            return false
        }
    }
    
    func updateBoxes(indexX: Int, indexY: Int, lineBox: chosenLineType) {
        let isComplete = allBoxes[indexX][indexY].checkCompleteBox(colorBox: self.colorTurn!)
        if isComplete {
            self.updatePoints()
        }
        var isCompleteNext = false
        
        if lineBox == .top {
            if indexX > 0 {
                allBoxes[indexX-1][indexY].bottom = true
                self.objectWillChange.send()
                // check next
                isCompleteNext = checkNext(indexX: indexX-1, indexY: indexY)
            }
        } else if lineBox == .bottom {
            if indexX < self.rowCount!-1 {
                allBoxes[indexX+1][indexY].top = true
                self.objectWillChange.send()
                // check next
                isCompleteNext = checkNext(indexX: indexX+1, indexY: indexY)
            }
        } else if lineBox == .left {
            if indexY > 0 {
                allBoxes[indexX][indexY-1].right = true
                self.objectWillChange.send()
                // check next
                isCompleteNext = checkNext(indexX: indexX, indexY: indexY-1)
            }
        } else if lineBox == .right {
            if indexY < self.colCount!-1 {
                allBoxes[indexX][indexY+1].left = true
                self.objectWillChange.send()
                // check next
                isCompleteNext = checkNext(indexX: indexX, indexY: indexY+1)
            }
        }
        if !isComplete && !isCompleteNext {
            self.switchTurn()
        }
    }
    
    func countDownExtraLife() {
        AudioPlayer.shared.play(name: "lostExtraLifeSound", volume: 0.4, delay: 0.0)
        if self.turn == .player1 {
            if !self.player1ExtraLife![0] {
                self.timer.upstream.connect().cancel()
                self.timerFloat.upstream.connect().cancel()
                self.winner = .player2
                self.endExtraLife = true
                AudioPlayer.shared.play(name: "winSound", volume: 0.4, delay: 0.0)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                }
                withAnimation(){
                    self.endGame = true
                }
            } else {
                for n in (0...player1ExtraLife!.count-1).reversed() {
                    if self.player1ExtraLife![n] {
                        self.player1ExtraLife![n] = false
                        self.startCountDown()
                        break
                    }
                }
            }
        } else {
            if !self.player2ExtraLife![2] {
                self.timer.upstream.connect().cancel()
                self.timerFloat.upstream.connect().cancel()
                self.winner = .player1
                self.endExtraLife = true
                AudioPlayer.shared.play(name: "winSound", volume: 0.4, delay: 0.0)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                }
                withAnimation(){
                    self.endGame = true
                }
            } else {
                for n in (0...player2ExtraLife!.count-1) {
                    if self.player2ExtraLife![n] {
                        self.player2ExtraLife![n] = false
                        self.startCountDown()
                        break
                    }
                }
            }
        }
    }
    
    // timer
    public func startCountDown() {
        self.timer.upstream.connect().cancel()
        self.timerFloat.upstream.connect().cancel()
        withAnimation(){
            self.secondsRemaining = 1.0
            self.secondsRemainingInt = 5
        }
        self.timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
        self.timerFloat = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    }
}

