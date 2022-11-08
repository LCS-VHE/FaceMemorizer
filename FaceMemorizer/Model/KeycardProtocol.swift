//
//  KeycardProtocol.swift
//  FaceMemorizer
//
//  Created by Vincent He on 2022-11-03.
//

import Foundation
import SwiftUI

protocol KeycardProtocol
{
    var images:[Image] {get set}
    var names:[String] {get set}
}

struct KeycardSet: KeycardProtocol
{
    var images:[Image]
    var names: [String]
}

