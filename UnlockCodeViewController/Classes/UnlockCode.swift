import Foundation

/**
 A hash representing the unlock code.
 
 If you need to store the Unlock Code directly in the app, you should pre-generate the SHA-256
  hash, so that you are not storing your code in plaintext.
 
 The `length` and `isNumeric` properties greatly reduce the difficulty of cracking the unlock
  code, but these are necessary to present the "4 digit pin" style interface.
 */
public struct UnlockCode {
    
    // MARK: - Properties
    
    /// The SHA-256 hash of the Unlock Code
    internal let hash: String
    
    /// The salt used to generate the hash
    /// - Note: This should be sufficiently long
    internal let salt: String
    
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
        self.hash = string.sha256Hash(salt: salt)
        self.salt = salt
        length = string.count
        isNumeric = CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: string))
    }
    
}
