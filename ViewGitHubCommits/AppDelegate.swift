//
//  AppDelegate.swift
//  ViewGitHubCommits
//
//  Created by Jeff Pape on 11/3/19.
//  Copyright © 2019 Pape Software. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
//        let sourceUrl = "https://api.github.com/repos/octocat/Hello-World/commits"
        let sourceUrl = "https://api.github.com/repos/octocat/octocat.github.io/commits"
        // let sourceUrl = "https://api.github.com"
        var headers = [String: String]()
        headers["Accept"] = "application/vnd.github.v3+json"
        // gitHubToken defined in secret file which should never be checked into to github
        headers["Authorization"] = "token \(gitHubToken)"
        let urlParameters = [String: String]()
        let timeout = TimeInterval(1000)
        let completion = {
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
            guard let dictionaryData = jsonData as? [[String:Any]] else {
                debugPrint("typecase of jsonData to [[String:Any]]")
                return
            }
            debugPrint(dictionaryData)
        }
        
        RestCalls.read(from: sourceUrl, headers: headers, urlParameters: urlParameters, timeout: timeout, completion: completion)
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

}

