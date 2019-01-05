import Foundation

/**
 An Unlock Code
 
 You should pre-generate the Unlock Code where possible. If you didn't, anyone could just
  decompile your App and read your code in plaintext. Ideally this would come from a remote
  server, and then be stored in the keychain.
 
 Obviously giving the `length` and `isNumeric` properties greatly reduce the amount of time
  it takes to crack the unlock code, but these are required to present the "4 digit pin"
  style interface.
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
    public init(generateFor string: String, withSalt salt: String = "") throws {
        guard let hash = string.sha256Hash(salt: salt) else {
            throw NSError(domain: "Unable to generate a SHA256 hash for string: \"\(string)\"",
                          code: -1,
                          userInfo: nil)
        }
        
        self.salt = salt
        self.hash = hash
        
        length = string.count
        isNumeric = CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: string))
    }
    
}
