//
//  Background.swift
//  ViewGitHubCommits
//
//  Created by Jeff Pape on 11/18/19.
//  Copyright © 2019 Pape Software. All rights reserved.
//

import SwiftUI

extension View {
    func background() -> some View {
        return ResignFirstResponderTapGestureDetector{self}
    }
}


struct ResignFirstResponderTapGestureDetector<Content: View>: View {
    private var content: Content

    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content()
    }

    var body: some View {
        Color.white
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .overlay(content).onTapGesture {
            self.endEditing()
        }
    }
    
    private func endEditing() {
        UIApplication.shared.endEditing()
    }
}

