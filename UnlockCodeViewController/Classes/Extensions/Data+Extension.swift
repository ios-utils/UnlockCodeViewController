//
//  Data+Extension.swift
//  UnlockCodeViewController
//
//  Created by Reece Como on 4/1/19.
//

import Foundation
import CommonCrypto

internal extension Data {
    
    /// Hex String
    internal var hexString: String {
        var bytes = [UInt8](repeating: 0, count: count)
        copyBytes(to: &bytes, count: count)
        
        var hexString = ""
        for byte in bytes {
            hexString += String(format: "%02x", UInt8(byte))
        }
        
        return hexString.uppercased()
    }
    
    /// SHA-256 implementation
    internal var sha256: Data {
        var hash = [UInt8](repeating: 0, count: Int(CC_SHA256_DIGEST_LENGTH))
        withUnsafeBytes {
            _ = CC_SHA256($0, CC_LONG(count), &hash)
        }
        return Data(bytes: hash)
    }
    
}
