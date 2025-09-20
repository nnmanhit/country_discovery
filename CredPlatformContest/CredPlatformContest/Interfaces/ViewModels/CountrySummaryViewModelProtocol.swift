//
//  CountrySummaryViewModelProtocol.swift
//  CredPlatformContest
//
//  Created by Manh Nguyen on 9/20/25.
//

import SwiftUI

protocol CountrySummaryViewModelProtocol : ObservableObject {
    func generateCountryFunFact(question: String?) async
}
