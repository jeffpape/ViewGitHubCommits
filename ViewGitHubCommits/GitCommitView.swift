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
        Text("\(commit.description)")
    }
}
/*
struct GitCommitView_Previews: PreviewProvider {
    static var previews: some View {
        GitCommitView()
    }
}
*/
