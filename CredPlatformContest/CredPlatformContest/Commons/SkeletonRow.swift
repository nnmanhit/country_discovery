//
//  SkeletonRow.swift
//  CredPlatformContest
//
//  Created by Manh Nguyen on 9/19/25.
//

import Combine
import Foundation
import SwiftUI

struct SkeletonRow: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 150, height: 32)

                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 100, height: 20)
            }
            
            Spacer()
            
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.gray.opacity(0.3))
                .frame(width: 50, height: 50)
        }
    }
}
