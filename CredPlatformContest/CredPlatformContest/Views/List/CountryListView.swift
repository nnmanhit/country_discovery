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
                
                ScrollView {
                    VStack(spacing: 15) {
                        ForEach(self.countryViewModel.countries) { country in
                            Button(action: {
                                
                            }) {
                                CountryRow(country: country)
                            }
                        }
                    }
                }
                
            }
            .onAppear {
                Task {
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
                
                Text(country.capital ?? "")
                    .font(.headline)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: Color.gray.opacity(0.1), radius: 8, x: 0, y: 4)
    }
}

//#Preview {
//    CountryListView()
//}
