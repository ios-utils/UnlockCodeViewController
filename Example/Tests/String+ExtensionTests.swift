//
//  String+ExtensionTests.swift
//
//  Created by Reece Como on 4/1/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import XCTest
@testable import UnlockCodeViewController

/**
 Tests for `String` extension
 */
class StringExtensionTests: XCTestCase {
    
    /// Test that `.sha256Hash(salt:)` results in the expected hash
    func testSHA256HashResultsInExpectedHash() {
        let inputString = "exampleInput"
        let inputSalt = "my$alt1"
        let expected = "8C4FADDDF0AC67941B9493685CA97246DD7A3A14ECF2D05905D6F61F587FF8A9"
        
        let actual = inputString.sha256Hash(salt: inputSalt)
        
        XCTAssertEqual(expected, actual)
    }
    
    /// Test that two similar input strings with different cases produce different hashes
    func testResultingSHA256HashIsInputCaseSensitive() {
        let input1 = "exampleInput"
        let input2 = "exampleinput"
        let inputSalt = "my$alt1"
        
        let actual1 = input1.sha256Hash(salt: inputSalt)
        let actual2 = input2.sha256Hash(salt: inputSalt)
        
        XCTAssertNotEqual(actual1, actual2)
    }
    
    /// Test that `.sha256Hash(salt:)` results in different hashes for different salts
    func testResultingSHA256HashIsSaltSensitive() {
        let inputString = "exampleInput"
        let inputSalt1 = "my$alt1"
        let inputSalt2 = "cool$alt2"
        
        let actual1 = inputString.sha256Hash(salt: inputSalt1)
        let actual2 = inputString.sha256Hash(salt: inputSalt2)
        
        XCTAssertNotEqual(actual1, actual2)
    }
    
}
