//
//  DynamicHeightList.swift
//  weather_proj
//
//  Created by Chan on 2/24/24.
//

import SwiftUI

struct DynamicHeightList<Content>: View where Content: View {
    var content: () -> Content
    var body: some View {
        ScrollView {
            VStack {
                content()
            }
        }
    }
}
