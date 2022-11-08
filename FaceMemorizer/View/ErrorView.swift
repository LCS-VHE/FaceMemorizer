//
//  ErrorView.swift
//  FaceMemorizer
//
//  Created by Vincent He on 2022-11-03.
//

import SwiftUI

enum FilterBy
{
    case correct, incorrect
}

struct ErrorView: View {
    // for other stuff
    @ObservedObject var allData:AllData
    
    // for accessing other variables
    @State private var shouldFilter:Bool
    
    init(allData: AllData)
    {
        self.allData = allData
        self.shouldFilter = false
        
        self.filterSelection = "All Answers"
        self.filteredList = allData.userAnswersLevelOne
    }
    
    // For dealing with pickers
    @State private var filterSelection:String
    private var filterTableLookup = [
        "Correct Answers" : FilterBy.correct,
        "Incorrect Answers" : FilterBy.incorrect,
    ]
    
    private var filterBy:FilterBy {
        return filterTableLookup[filterSelection] ?? .correct
    }
    
    // filtered list
    @State private var filteredList:[UserAnswerLevelOne]
    
    
    var body: some View {
        VStack
        {
            HStack
            {
                Picker("Select Filter By", selection: $filterSelection)
                {
                    ForEach(0..<filterTableLookup.keys.count, id:\.self)
                    { index in
                        Text("\(Array(filterTableLookup.keys)[index])")
                            .tag(Array(filterTableLookup.keys)[index])
                    }
                }
                Picker("Should Filter", selection: $shouldFilter)
                {
                    Text("True")
                        .tag(true)
                    
                    Text("False")
                        .tag(false)
                }
            }
            
            Button(action: buttonCallback, label: {Text("Go!")})
            
            Text("\(self.filterSelection)")
            ScrollView
            {
                ForEach(0..<self.filteredList.count, id:\.self)
                {num in
                    HStack
                    {
                        VStack
                        {
                            Text("The actual answer")
                            self.filteredList[num].actualAnswerImage.resizable().frame(width: 150, height: 150)
                            Text("\(self.filteredList[num].actualAnswer)")
                        }
                        VStack
                        {
                            Text("You selected")
                            self.filteredList[num].userSelectedImage.resizable().frame(width: 150, height: 150)
                            Text("\(self.filteredList[num].userAnswer)")
                        }
                    }
                    
                }
            }
        }
    }
    
    func buttonCallback()
    {
        self.filteredList = filter(filterBy: self.filterBy, shouldFilter: self.shouldFilter)
        
    }
    
    func filter(filterBy:FilterBy, shouldFilter:Bool) -> [UserAnswerLevelOne]
    {
        if(!shouldFilter)
        {
            return allData.userAnswersLevelOne
        }
        
        var filteredResult:[UserAnswerLevelOne] = []
        for _answer in allData.userAnswersLevelOne
        {
            if filterBy == .correct && _answer.isCorrect
            {
                filteredResult.append(_answer)
            }
            
            if filterBy == .incorrect && !_answer.isCorrect
            {
                filteredResult.append(_answer)
            }
        }
        
        return filteredResult
        
        
    }
}

