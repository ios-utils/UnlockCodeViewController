//
//  UnlockCodeViewController
//  Reece Como
//
//  Created by Reece Como on 21/4/18.
//  Copyright © 2018 Reece Como. All rights reserved.
//

import Foundation

extension String {
    
    /// Hash using SHA256 (with salt)
    internal func sha256Hash(salt: String = "") -> String? {
        let saltedString = self + salt
        let encodedData = saltedString.data(using: .utf8)
        
        return encodedData?.sha256.hexString
    }
    
}
