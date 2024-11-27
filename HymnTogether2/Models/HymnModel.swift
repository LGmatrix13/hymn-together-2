//
//  HymnModel.swift
//  HymnTogether
//
//  Created by Liam Grossman on 11/11/24.
//

import Foundation


struct HymnModel : Decodable {
    var id: Int = 0
    var title: String = ""
    var author: String = ""
    var music: String = ""
    var score: String = ""
    var lyrics: [[String]] = [[]]
}
