//
//  CustomNavigation.swift
//  Project1_WeSplit
//
//  Created by Kane on 22/12/2023.
//

import SwiftUI

struct CustomNavigation<Content>: View where Content: View {
    @ViewBuilder var content: () -> Content

    var body: some View {
        if #available(iOS 16, *) {
            NavigationStack(root: content)
        } else {
            NavigationView(content: content)
        }
    }
}
