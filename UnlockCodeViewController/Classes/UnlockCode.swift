//
//  UnlockCodeViewController
//  Reece Como
//
//  Created by Reece Como on 21/4/18.
//  Copyright © 2018 Reece Como. All rights reserved.
//

import Foundation

/**
 An Unlock Code struct
 
 When creating Unlock Codes, you should pre-generate them where possible. If you don't
  pregenerate them, anyone can just decompile your App and read the code in plaintext.
 
 Obviously `length` and `isNumeric` properties greatly reduce the security of your code,
  but these are required to present a "4 digit pin" style interface. If your security requirements
  are greater, than this may not be the right library for your app.
 */
public struct UnlockCode {
    
    // MARK: - Properties
    
    /// The hash of the unlock code
    let hash: String
    
    /// Should be a sufficiently long salt
    let salt: String
    
    /// Length of the string
    /// - Note: This is required presentation meta-data
    public let length: Int
    
    /// Is numeric mode
    /// - Note: This is required presentation meta-data
    public let isNumeric: Bool
    
    // MARK: - Methods
    
    /// Compare against some `String`
    public func isEqualTo(_ string: String) -> Bool {
        return hash.uppercased() == string.sha256Hash(salt: salt)
    }
    
    // MARK: - Initialisers
    
    ///
    /// Init with a pre-generated code
    /// - Note: Must use SHA-256 hash
    ///
    public init(hash: String, salt: String, length: Int, isNumeric: Bool) {
        self.hash = hash
        self.salt = salt
        self.length = length
        self.isNumeric = isNumeric
    }
    
    ///
    /// Generate a new code on the fly
    /// - Note: It is recommended you do not use this, and instead use a pre-generated code.
    ///
    public init(generateFor string: String, withSalt salt: String = "") {
        guard let hash = string.sha256Hash(salt: salt) else {
            fatalError("Unable to generate a SHA256 hash for string: \"\(string)\"")
        }
        
        self.salt = salt
        self.hash = hash
        
        length = string.count
        isNumeric = CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: string))
    }
    
}
