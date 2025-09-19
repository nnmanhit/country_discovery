//
//  Shimmer.swift
//  CredPlatformContest
//
//  Created by Manh Nguyen on 9/19/25.
//

import Combine
import Foundation
import SwiftUI

import SwiftUI

struct ShimmerModifier: ViewModifier {
    @State private var phase: CGFloat = 0

    var gradient: LinearGradient {
        LinearGradient(
            gradient: Gradient(stops: [
                .init(color: Color.gray.opacity(0.3), location: phase),
                .init(color: Color.gray.opacity(0.1), location: phase + 0.1),
                .init(color: Color.gray.opacity(0.3), location: phase + 0.2)
            ]),
            startPoint: .leading,
            endPoint: .trailing
        )
    }

    func body(content: Content) -> some View {
        content
            .mask(
                gradient
            )
            .onAppear {
                withAnimation(
                    .linear(duration: 1.5)
                    .repeatForever(autoreverses: false)
                ) {
                    phase = 1.0
                }
            }
    }
}

extension View {
    func shimmer() -> some View {
        self.modifier(ShimmerModifier())
    }
}
