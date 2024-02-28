//
//  BackgroundImageView.swift
//  weather_proj
//
//  Created by Chan on 2/24/24.
//

import SwiftUI

struct BackgroundImageView: View {
    var body: some View {
        Image("Background")
            .resizable()
            .ignoresSafeArea()
            .opacity(0.7)
            .overlay(
                Color(UIColor.systemBackground).opacity(0.5)
            )
    }
}

struct BackgroundHelper: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        DispatchQueue.main.async {
            var parent = view.superview
            repeat {
                if parent?.backgroundColor != nil {
                    parent?.backgroundColor = UIColor.clear
                    break
                }
                parent = parent?.superview
            } while (parent != nil)
        }
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}
