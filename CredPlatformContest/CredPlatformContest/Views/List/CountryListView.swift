//
//  CountryListView.swift
//  CountryDiscovery
//
//  Created by Manh Nguyen on 9/18/25.
//

import SwiftUI

struct CardView<Content: View>: View {
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        content
            .padding()
            .background(.ultraThickMaterial) // A semi-transparent background
            .cornerRadius(12)
            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
            .padding(.horizontal)
            .padding(.vertical, 8) // Add vertical spacing between cards
    }
}

// Updated CountryRow for the new card style
struct CountryRow: View {
    let country: Country

    var body: some View {
        HStack(spacing: 15) {
            // Add a flag emoji for visual interest
            Text(country.emoji ?? "")
                .font(.largeTitle)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(country.name)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                
                Text(country.capital ?? "")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Text(country.currency ?? "")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer() // Pushes content to the left
        }
    }
}

struct CountryListView: View {
    @StateObject var countryListViewModel: CountryListViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.gray.opacity(0.1)
                    .edgesIgnoringSafeArea(.all)
                
                if countryListViewModel.isLoading {
                    ScrollView {
                        LazyVStack(spacing: 0) {
                            ForEach(0..<30, id: \.self) { _ in
                                CardView {
                                    ShimmeringCountryRow()
                                }
                            }
                        }
                    }
                } else {
                    ScrollView {
                        LazyVStack(spacing: 0) {
                            ForEach(countryListViewModel.countries, id: \.self) { country in
                                CardView {
                                    HStack {
                                        NavigationLink(destination: CountrySummaryView(country: country, countrySummaryViewModel: CountrySummaryViewModel(country: country, llmService: OpenAIService(apiKey: Config.OAK ?? "", model: "gpt-3.5-turbo")))) {
                                            CountryRow(country: country)
                                        }
                                        
                                        Button(action: {
                                            Task {
                                                await countryListViewModel.toggleFavorite(country)
                                            }
                                        }) {
                                            Image(systemName: country.isFavorited == true ? "star.fill" : "star")
                                                .resizable()
                                                .frame(width: 24, height: 24)
                                                .aspectRatio(contentMode: .fit)
                                                .foregroundStyle(country.isFavorited == true ? Color.yellow : Color.gray)
                                        }
                                        .buttonStyle(.plain)
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Countries")
        }
    }
}
