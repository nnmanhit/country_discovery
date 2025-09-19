//
//  CountryListViewModelProtocol.swift
//  CountryDiscovery
//
//  Created by Manh Nguyen on 9/18/25.
//

import Combine

protocol CountryViewModelProtocol : ObservableObject {
    
    func loadCountries() async
    
}
