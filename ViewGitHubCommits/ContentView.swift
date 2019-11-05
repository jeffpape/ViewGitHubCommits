//
//  ContentView.swift
//  ViewGitHubCommits
//
//  Created by Jeff Pape on 11/3/19.
//  Copyright © 2019 Pape Software. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    //  let sourceUrl = "https://api.github.com/repos/octocat/Hello-World/commits"
    //let sourceUrl = "https://api.github.com/repos/octocat/octocat.github.io/commits"
    let sourceUrl = "https://api.github.com/repos/tensorflow/tensorflow/commits"
    @State var commits: [GitCommitData]? = nil
    var body: some View {
        List {
            ForEach(commits ?? [], id: \.hash)
            {
                (commit: GitCommitData) in
                GitCommitView(commit: commit)
            }
        }.onAppear(perform: {GitCommitModelController.setUpGitHubRetrieve(sourceUrl: self.sourceUrl) {
            self.commits = $0
        }})
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


//struct SearchView : View {
//@State private var query: String = "Swift"
//@EnvironmentObject var repoStore: ReposStore
//
//var body: some View {
//    NavigationView {
//        List {
//            TextField("Type something...", text: $query, onCommit: fetch)
//            ForEach(repoStore.repos) { repo in
//                RepoRow(repo: repo)
//            }
//        }.navigationBarTitle(Text("Search"))
//    }.onAppear(perform: fetch)
//}
//
//private func fetch() {
//    repoStore.fetch(matching: query)
//}
