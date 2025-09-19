//
//  SkeletonRow.swift
//  CredPlatformContest
//
//  Created by Manh Nguyen on 9/19/25.
//

import Combine
import Foundation
import SwiftUI

struct ShimmeringCountryRow: View {
    var body: some View {
        HStack(spacing: 15) {
            // Placeholder for the flag emoji
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.gray.opacity(0.3))
                .frame(width: 50, height: 50)
            
            VStack(alignment: .leading, spacing: 5) {
                // Placeholder for the country name
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 200, height: 28) // Matches .title font size
                
                // Placeholder for the capital
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 150, height: 20) // Matches .headline font size
            }
            
            Spacer()
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
        .shimmer()
    }
}
