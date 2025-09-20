//
//  CountrySummaryView.swift
//  CountryDiscovery
//
//  Created by Manh Nguyen on 9/18/25.
//

import SwiftUI
import Combine

// Reusable DataRow for key information
struct DataRow: View {
    let iconName: String
    let label: String
    let value: String?
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: iconName)
                .foregroundStyle(.secondary)
                .font(.headline)
                .frame(width: 25)
            
            Text(label)
                .font(.headline)
                .foregroundStyle(.primary)
            
            Spacer()
            
            Text(value ?? "N/A")
                .font(.body)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.trailing)
        }
        .padding(.vertical, 4)
    }
}

// The main, refactored view
struct CountrySummaryView : View {
    
    let country: Country
    @ObservedObject var countryViewModel: CountryViewModel
    
    @State private var userQuestion: String = ""
    // Tracks if a user's question is being processed
    @State private var isLoadingAnswer = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                
                VStack(spacing: 8) {
                    Text(country.emoji ?? "")
                        .font(.system(size: 80))
                        .shadow(color: .gray.opacity(0.4), radius: 5, x: 0, y: 5)
                    
                    Text(country.name)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundStyle(.primary)
                    
                    Text(country.capital ?? "")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundStyle(.secondary)
                }
                .padding(.top)
                
                CardView {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("General Information")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundStyle(.primary)
                        
                        Divider()
                        
                        DataRow(iconName: "mappin.and.ellipse", label: "Continent", value: country.continent?.name ?? "")
                        DataRow(iconName: "person.2.fill", label: "Capital", value: country.capital ?? "")
                        DataRow(iconName: "globe", label: "Language", value: country.languages.first?.name ?? "")
                        DataRow(iconName: "dollarsign.circle.fill", label: "Currency", value: country.currency)
                    }
                }
                
                CardView {
                    VStack(alignment: .leading, spacing: 15) {
                        HStack {
                            Text("Fun Fact")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundStyle(.primary)
                            
                            Spacer()
                            
                            if countryViewModel.isLoading {
                                ProgressView()
                                    .controlSize(.small)
                            }
                        }
                        
                        if let fact = countryViewModel.countryFunFact?.funFact, !fact.isEmpty {
                            Text(fact)
                                .font(.body)
                                .lineSpacing(5)
                                .foregroundStyle(.primary)
                        } else {
                            Text("A fun fact about \(country.name) will appear here!")
                                .font(.body)
                                .foregroundStyle(.secondary)
                        }
                        
                        Divider()
                        
                        // User input field
                        TextField("Ask a question about \(country.name)", text: $userQuestion)
                            .textFieldStyle(.roundedBorder)
                            .disabled(isLoadingAnswer)
                        
                        Button(action: {
                            guard !userQuestion.isEmpty, !isLoadingAnswer else { return }
                            
                            isLoadingAnswer = true
                            
                            Task {
                                await self.countryViewModel.generateCountryFunFact(country: country, question: userQuestion)
                                isLoadingAnswer = false
                            }
                        }) {
                            HStack {
                                Spacer()

                                if isLoadingAnswer {
                                    ProgressView()
                                        .tint(.white)
                                } else {
                                    Text("Get an answer")
                                }
                                Spacer()
                            }
                            .padding()
                            .background(isLoadingAnswer ? Color.blue.opacity(0.6) : Color.blue)
                            .foregroundStyle(.white)
                            .font(.headline)
                            .cornerRadius(12)
                        }
                        .buttonStyle(.plain)
                        .disabled(isLoadingAnswer)
                    }
                }
            }
            .navigationTitle(country.name)
            .navigationBarTitleDisplayMode(.inline)
            .task {
                
                self.countryViewModel.countryFunFact?.funFact = ""
                
                Task.detached {
                    await self.countryViewModel.generateCountryFunFact(country: country, question: nil)
                }
            }
        }
    }
}
