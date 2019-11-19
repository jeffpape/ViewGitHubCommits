//
//  GitCommitView.swift
//  ViewGitHubCommits
//
//  Created by Jeff Pape on 11/4/19.
//  Copyright © 2019 Pape Software. All rights reserved.
//

import SwiftUI

struct GitCommitView: View {
  /*  @Binding*/ var commit: GitCommitData

    var body: some View {
        VStack {
            Text("\(commit.author)")
                .bold()
            Spacer()
                .frame(minHeight: 10, maxHeight: 20)
            Text("\(commit.hash)")
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                .foregroundColor(.blue)
                .font(Font.system(size: 14))
            Spacer()
                .frame(minHeight: 10, maxHeight: 20)
            Text("\(commit.message)")
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                .foregroundColor(.gray)
                .font(Font.system(size: 14))
            }
    }
}


struct GitCommitView_Previews: PreviewProvider {
    static var previews: some View {
        GitCommitView(commit:
            GitCommitData(
                author: "The Octocat",
                hash: "7fd1a60b01f91b314f59955a4e4d4e80d8edf11d",
                message: "Merge pull request #6 from Spaceghost/patch-1\n\nNew line at end of file."
            )
        )
    }
}
