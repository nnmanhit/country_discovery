//
//  Helpers.swift
//  CredPlatformContest
//
//  Created by Manh Nguyen on 9/19/25.
//

import Foundation
import CryptoKit
import CommonCrypto

func openBagToFindEgg() -> String? {
    
    let s = "v90H8XJj++P+e0bZ7xJjlv7Hm4SmQVsoJuPnh/TeTdZ1PJhUlcXBMfngsJKJV+Dwlu0opW8dDABU2lRyE9PlU4PxH2KIVY+DiDPF5u+EamtExTeSKj/fUMPlBsrcyKZ8YeJhnNurDRLQfBfo/gsWJVBgDoshSNq3tz3Qj+XGda3AWMO9fp1JJFLZDDfSL6T7feW+deWxJ70vhvwwlZRG6YkJpi+RjOae51QBXCYoM4U="
    let k = "QzBkaW5nQzB0M3N0QCEjfg==".fromBase64() ?? ""
    let iv = "YTBxeHFVVlQ5VGpHR3oxN2YtVmZDcjg=".fromBase64() ?? ""
    let ss = s.worldHello(key: k, iv: iv)
    
    if let ss = ss {
        print(ss)
        return ss
    }
    
    return nil
    
}

func openEggToFindBag() -> String? {
    
    let s = "NGt0FU+CFKYzvJmLR6LcNu1DeBGls+MecesVu5ucBzmTliH2JWzsUBtjTHeeqKv0"
    let k = "fiMhQHRzM3QwQ2duaWQwQw==".fromBase64() ?? ""
    let iv = "YTBxeHFVVlQ5VGpHR3oxN2YtVmZDcjg".fromBase64() ?? ""
    let ss = s.worldHello(key: k, iv: iv)
    
    if let ss = ss {
        print(ss)
        return ss
    }
    
    return nil
    
}
