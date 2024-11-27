//
//  GravatarService.swift
//  HymnTogether
//
//  Created by Liam Grossman on 11/11/24.
//

import Foundation
import CryptoKit


class GravatarService {
    private static func md5(_ text: String) -> String {
        let digest = Insecure.MD5.hash(data: Data(text.utf8))

        return digest.map {
            String(format: "%02hhx", $0)
        }.joined()
    }
    
    static func getAvatar(email: String) -> String {
        return "https://gravatar.com/avatar/\(self.md5(email))"
    }
}
