//
//  CountryListView.swift
//  CountryDiscovery
//
//  Created by Manh Nguyen on 9/18/25.
//

import SwiftUI

struct CountryListView : View {
    
    @StateObject var countryViewModel : CountryViewModel
    
    var body: some View {
        
        NavigationStack {
            VStack {
                
                List {
                    
                    if countryViewModel.isLoading {
                        
                        ForEach(0..<50, id: \.self) { _ in
                            SkeletonRow()
                        }
                        
                    } else {
                        ForEach(countryViewModel.countries, id: \.self) { country in
                            HStack {
                                NavigationLink(destination: CountrySummaryView(country: country, countryViewModel: countryViewModel)) {
                                    CountryRow(country: country)
                                }

                                Button(action: {
                                    Task {
                                        await countryViewModel.toggleFavorite(country)
                                    }
                                }) {
                                    Image(systemName: country.isFavorited == true ? "star.fill" : "star")
                                        .resizable()
                                        .frame(width: 32, height: 32)
                                        .aspectRatio(contentMode: .fit)
                                        .foregroundStyle(country.isFavorited == true ? Color.yellow : Color.blue)
                                }
                                .buttonStyle(.plain)
                                
                            }
                        }
                        
                    }
                    
                }
                .navigationTitle("Countries")
                
            }
            .task {
                Task.detached {
                    await self.countryViewModel.loadCountries()
                }
            }
        }
        
    }
    
}

struct CountryRow: View {
    let country: Country
    
    var body: some View {
        HStack(spacing: 15) {
            VStack(alignment: .leading, spacing: 5) {
                Text(country.name)
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundStyle(.primary)
                
                Text(country.capital ?? "")
                    .font(.headline)
                    .foregroundColor(.secondary)
            }
        }
    }
}

//#Preview {
//    CountryListView()
//}
