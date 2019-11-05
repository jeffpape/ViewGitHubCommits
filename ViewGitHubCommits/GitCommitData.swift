//
//  GitCommitData.swift
//  ViewGitHubCommits
//
//  Created by Jeff Pape on 11/4/19.
//  Copyright © 2019 Pape Software. All rights reserved.
//

import Foundation

class GitCommitData: CustomStringConvertible {
    var description: String {
        return "\(author) \(hash) \(message)"
    }
    
    let author : String
    let hash : String
    let message : String
    
    init?(from dictionary: [String: Any]) {
        guard let commitDictionary = dictionary["commit"] as? [String:Any] else {
            debugPrint("cannot read commit from top dictionary")
            return nil
        }
        guard let authorDictionary = commitDictionary["author"] as? [String:Any] else {
            debugPrint("cannot read author from commit dictionary")
            return nil
        }
        guard let authorName = authorDictionary["name"] as? String else {
            debugPrint("cannot read author name from author dictionary")
            return nil
        }
        guard let hash = dictionary["sha"] as? String else {
            debugPrint("cannot read sha from top dictionary")
            return nil
        }
        guard let message = commitDictionary["message"] as? String else {
            debugPrint("cannot read message from commit dictionary")
            return nil
        }
        self.author = authorName
        self.hash = hash
        self.message = message
        
        
    }
}
