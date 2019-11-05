//
//  GitCommitModelController.swift
//  ViewGitHubCommits
//
//  Created by Jeff Pape on 11/4/19.
//  Copyright © 2019 Pape Software. All rights reserved.
//

import Foundation

class GitCommitModelController {
    static var commits : [GitCommitData]? = nil
    
    static func setUpGitHubRetrieve(sourceUrl: String, completion: @escaping([GitCommitData]?) -> Void) {

        var headers = [String: String]()
        headers["Accept"] = "application/vnd.github.v3+json"
        // gitHubToken defined in secret file which should never be checked into to github
        headers["Authorization"] = "token \(gitHubToken)"
        var urlParameters = [String: String]()
        urlParameters["per_page"] = "25"
        let timeout = TimeInterval(1000)
        let restCompletion = {
            (data: Data?, urlResponse: URLResponse?, error: Error?) -> Void in
    //            debugPrint(urlResponse as Any)
            guard let data = data else {
                debugPrint("data is nil")
                return
            }
    //            debugPrint(String(data: data, encoding: .utf8) as Any)
            guard let jsonData = try? JSONSerialization.jsonObject(with: data, options: []) else {
                debugPrint("jsonData is nil")
                return
            }
    //            debugPrint(jsonData)
            guard let dictionaryData = jsonData as? [[String:Any]] else {
                debugPrint("typecase of jsonData to [[String:Any]]")
                return
            }
    //            debugPrint(dictionaryData)
            let commits = dictionaryData.compactMap{GitCommitData(from: $0)}
    //            debugPrint(commits)
                        
            // verify retrieved commit components
            for commit in commits {
                debugPrint("\(commit.author)   \(commit.hash)   \(commit.message)")
            }
            self.commits = commits
            
            completion(commits)
        }
        RestCalls.read(from: sourceUrl, headers: headers, urlParameters: urlParameters, timeout: timeout, completion: restCompletion)
        
   }
}
