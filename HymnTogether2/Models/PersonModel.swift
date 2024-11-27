//
//  PersonModel.swift
//  HymnTogether
//
//  Created by Liam Grossman on 11/11/24.
//

import Foundation

struct PersonModel : Decodable, Encodable {
    var id: String = ""
    var name: String = ""
    var bio: String = ""
    var followers: Int = 0
    var following: [String] = []
    var savedHymns: [Int] = []
    var email: String = ""
    var avatar: String = ""
    
    mutating func incrementFollowers() {
        self.followers += 1
    }
}
