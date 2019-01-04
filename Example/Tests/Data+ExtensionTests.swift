//
//  Data+ExtensionTests.swift
//
//  Created by Reece Como on 4/1/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import XCTest
@testable import UnlockCodeViewController

/**
 Tests for `Data` extensions
 */
class DataExtensionTests: XCTestCase {
    
    /// Test that `.sha256.hexString` results in the expected hash
    func testSHA256ProducesExpectedHash() {
        let input = "Example"
        let expected = "D029F87E3D80F8FD9B1BE67C7426B4CC1FF47B4A9D0A8461C826A59D8C5EB6CD"
        let actual = input.data(using: .utf8)!.sha256.hexString
        
        XCTAssertEqual(expected, actual)
    }
    
    /// Test that two similar input strings with different cases produce different hashes
    func testResultingSHA256IsInputCaseSensitive() {
        let input1 = "Example"
        let input2 = "example"
        
        let actual1 = input1.data(using: .utf8)!.sha256.hexString
        let actual2 = input2.data(using: .utf8)!.sha256.hexString
        
        XCTAssertNotEqual(actual1, actual2)
    }
    
}
