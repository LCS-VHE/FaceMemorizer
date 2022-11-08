//
//  AllData.swift
//  FaceMemorizer
//
//  Created by Vincent He on 2022-11-03.
//

import Foundation
import SwiftUI

let placeholderFiles = ["Carsen Decker ", "Jaylynn Shields", "Cesar Gillespie", "Kaeden Wiley", "Miya Eaton", "Bruno Mckay", "Kareem Leon", "Ayaan Kane", "Reid Craig ", "Gary Richards"]


class AllData: ObservableObject
{
    init ()
    {
        // creating a placeholder keycard set
        keycardSets = []
        
        // Lakefield Images
        var images:[Image] = []
        var names:[String] = []
    
        for image_name in placeholderFiles
        {
            images.append(Image(image_name))
            names.append(image_name)
        }
        
        keycardSets.append(KeycardSet(images: images, names: names))
        
        // Empty sets
        self.userAnswersLevelOne = []
    }
    
    var keycardSets:[KeycardSet]
    @Published var userAnswersLevelOne:[UserAnswerLevelOne]
}


