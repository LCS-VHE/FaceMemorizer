//
//  level1.swift
//  FaceMemorizer
//
//  Created by Vincent He on 2022-11-03.
//

import SwiftUI

struct level1View: View {
    @ObservedObject var allData:AllData
    
    // Guessing Stuff
    @State private var guessIndex: [Int]
    @State private var correctIndex = Int.random(in:0..<3)
    
    // For Alert
    @State private var showAlert = false
    @State private var alertMessage = "You got it!"
    
    init(allData:AllData)
    {
        self.allData = allData
        self.guessIndex = [Int.random(in: 0..<allData.keycardSets[0].images.count),Int.random(in: 0..<allData.keycardSets[0].images.count),Int.random(in: 0..<allData.keycardSets[0].images.count)]
    }
    
    @State private var correctGuess: Int = Int.random(in:0..<3)
    
    var body: some View
    {
        VStack
        {
            ScrollView
            {
                Button(action: refresh, label: {Text("Debug - Refresh")})
                
                Text("Who is \(allData.keycardSets[0].names[guessIndex[correctIndex]])?")
                ScrollView(.horizontal)
                {
                    HStack
                    {
                        ForEach(0..<guessIndex.count, id:\.self)
                        {num in
                            
                            if guessIndex[num] == guessIndex[correctIndex]
                            {
                                Button(action: pressedCorrectButton(userSelectedIndex: guessIndex[num], actualIndex: guessIndex[correctIndex]), label: {allData.keycardSets[0].images[guessIndex[num]]})
                            }
                            else
                            {
                                Button(action: pressedIncorrectButton(userSelectedIndex: guessIndex[num], actualIndex: guessIndex[correctIndex]), label: {allData.keycardSets[0].images[guessIndex[num]]})
                            }
                        }
                    }
                }
            }
            
                .navigationBarTitle("Level One")
                .alert(self.alertMessage, isPresented: $showAlert) {
                    Button("OK", role: .cancel) { }
                }
        }
        
    }
    
    func pressedIncorrectButton(userSelectedIndex:Int, actualIndex:Int) -> () ->()
    {
        {
            // saving the answer to the list
            let userAnswer = UserAnswerLevelOne(actualAnswer: allData.keycardSets[0].names[actualIndex], userAnswer: allData.keycardSets[0].names[userSelectedIndex], isCorrect: false, actualAnswerImage: allData.keycardSets[0].images[actualIndex], userSelectedImage: allData.keycardSets[0].images[userSelectedIndex])
            
            allData.userAnswersLevelOne.append(userAnswer)
            
            alertMessage = "You don't got it! go to wrong answer tab to view correct answer"
            refresh()
        }
    }
    
    func pressedCorrectButton(userSelectedIndex:Int, actualIndex:Int) -> () -> ()
    {
        {
            // saving the answer to the list
            let userAnswer = UserAnswerLevelOne(actualAnswer: allData.keycardSets[0].names[actualIndex], userAnswer: allData.keycardSets[0].names[userSelectedIndex], isCorrect: true, actualAnswerImage: allData.keycardSets[0].images[actualIndex], userSelectedImage: allData.keycardSets[0].images[userSelectedIndex])
            
            allData.userAnswersLevelOne.append(userAnswer)
            
            alertMessage = "You got it"
            refresh()
        }
    }
    
    func refresh()
    {
        for i in 0..<3
        {
            guessIndex[i] = Int.random(in:0..<allData.keycardSets[0].images.count)
        }
        
        correctIndex = Int.random(in:0..<3)
        showAlert = true
    }
}

