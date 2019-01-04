//
//  UnlockCodeTests.swift
//
//  Created by Reece Como on 4/1/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import XCTest
@testable import UnlockCodeViewController

/**
 Tests for `UnlockCode`
 */
class UnlockCodeTests: XCTestCase {
    
    /// Unlock code
    /// - Note: For value "123456"
    private let unlockCode = UnlockCode(
        hash: "2DBD6C5C6085CB173C76E0856CF2EB85DB6A464264704528187E18A808A0D569",
        salt: "O%0jc@_Qy)gAa9d",
        length: 6,
        isNumeric: true
    )
    
    /// Test that hash/salt combinations can be successfully compared to plaintext
    func testIsEqualToIsTrueWhenMatched() {
        XCTAssert(unlockCode.isEqualTo("123456"),
                  "isEqualTo returns false when matching hash/salt and plaintext are compared")
    }
    
    /// Test that hash/salt combinations doesn't return a false positive
    func testIsEqualToIsFalseWhenMismatched() {
        XCTAssert(!unlockCode.isEqualTo("654321"),
                  "isEqualTo returns false when mismatched hash/salt and plaintext are compared")
    }
    
}
