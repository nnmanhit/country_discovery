//
//  CountrySummaryView.swift
//  CountryDiscovery
//
//  Created by Manh Nguyen on 9/18/25.
//

import SwiftUI
import Combine

struct CountrySummaryView : View {
    
    let country : Country
    @ObservedObject var countryViewModel : CountryViewModel
    
    @State private var showingAlert = false
    @State private var userQuestion : String = ""
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text(country.name)
                    .font(.largeTitle)
                    .bold()
                Text("Capital: \(country.capital ?? "")")
                    .font(.title2)
                Text(countryViewModel.countryFunFact?.funFact ?? "")
                Spacer()
                Button(action: {
                    showingAlert = true
                }) {
                    Text("Ask a question")
                }
            }
            .padding()
            .navigationTitle(country.name)
            .navigationBarTitleDisplayMode(.inline)
            .task {
                self.countryViewModel.countryFunFact?.funFact = ""
                
                Task.detached {
                    await self.countryViewModel.generateCountryFunFact(country: country, question: nil)
                }
            }
            .alert("Ask a Question", isPresented: $showingAlert) {
                TextField("Type your question here", text: $userQuestion)
                
                Button("Submit", action: {
                    
                    Task {
                        await self.countryViewModel.generateCountryFunFact(country: country, question: userQuestion)
                    }
                    
                })

                Button("Cancel", role: .cancel) {
                    userQuestion = ""
                }
            } message: {
                Text("What would you like to ask?")
            }
        }
        
    }
}
