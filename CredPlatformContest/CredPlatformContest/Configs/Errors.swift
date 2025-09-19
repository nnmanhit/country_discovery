//
//  Errors.swift
//  CredPlatformContest
//
//  Created by Manh Nguyen on 9/18/25.
//

import Foundation

struct Error {
    
    static let DATA_NOT_FOUND = -1
    static let INVALID_KEY = 403
    
    static let ErrorNotFound = NSError(domain: "", code: Error.DATA_NOT_FOUND, userInfo: [NSLocalizedDescriptionKey: "Data not found"])
    static let ErrorInvalidKey = NSError(domain: "", code: Error.INVALID_KEY, userInfo: [NSLocalizedDescriptionKey: "Invalid Key"])
    
}
