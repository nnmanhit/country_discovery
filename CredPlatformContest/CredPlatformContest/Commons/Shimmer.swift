//
//  Shimmer.swift
//  CredPlatformContest
//
//  Created by Manh Nguyen on 9/19/25.
//

import Combine
import Foundation
import SwiftUI

struct Shimmer: ViewModifier {
    @State private var phase: CGFloat = -0.5

    func body(content: Content) -> some View {
        content
            .overlay(
                GeometryReader { geo in
                    Rectangle()
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color.white.opacity(0),
                                    Color.white.opacity(0.6),
                                    Color.white.opacity(0)
                                ]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .rotationEffect(.degrees(30))
                        .offset(x: geo.size.width * phase)
                }
                .clipped()
            )
            .onAppear {
                withAnimation(
                    .linear(duration: 1.5)
                    .repeatForever(autoreverses: false)
                ) {
                    phase = 1.5
                }
            }
    }
}

extension View {
    func shimmering() -> some View {
        self.modifier(Shimmer())
    }
}
