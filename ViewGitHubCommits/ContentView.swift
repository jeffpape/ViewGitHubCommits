//
//  ContentView.swift
//  ViewGitHubCommits
//
//  Created by Jeff Pape on 11/3/19.
//  Copyright © 2019 Pape Software. All rights reserved.
//

import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct ContentView: View {

//    let sourceRepository = "octocat/Hello-World"
//    let sourceRepository = "octocat/octocat.github.io"
//    let sourceRepository = "tensorflow/tensorflow"
    @State var commits: [GitCommitData]? = nil
    @State var sourceRepository: String = ""
    @State var error: String? = nil
    var body: some View {
        VStack {
            Text("View GitHub Commits")
                .font(.largeTitle)
                .bold()
            HStack {
                Spacer(minLength: 20)
                HStack {
                    TextField("user/repository", text: self.$sourceRepository,
                         onCommit: { GitCommitModelController.setUpGitHubRetrieve(sourceRepository: self.sourceRepository) {
                             self.commits = $0
                            self.error = GitCommitModelController.error
                         }})
                        .font(.title)
                        .foregroundColor(.blue)
                    Spacer()
                    Button(action: {
                        self.sourceRepository = ""
                        self.commits = []
                        self.error = nil
                        
                    }, label: {
                        Image(uiImage: #imageLiteral(resourceName: "CancelIcon")).renderingMode(.original)
                    })
                }.padding([.leading, .trailing], 20).padding([.top, .bottom], 10).background(Color.gray.opacity(0.2)).cornerRadius(10)
                Spacer(minLength: 20)
            }
            if error != nil {
                Text(error!)
            }
            List {
                ForEach(self.commits ?? [], id: \.hash)
                {
                    (commit: GitCommitData) in
                    GitCommitView(commit: commit)
                }
            }
        }.background()
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
