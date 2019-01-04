//
//  ViewController.swift
//  UnlockCodeViewController
//
//  Created by Reece Como on 01/03/2019.
//  Copyright (c) 2019 Reece Como. All rights reserved.
//

import UIKit
import UnlockCodeViewController

/**
 Example View Controller
 */
class ViewController: UIViewController {
    
    // MARK: - Properties
    
    /// Pre-generated Unlock Code hash
    /// - Password: "123456"
    private let myUnlockCode = UnlockCode(
        hash: "2DBD6C5C6085CB173C76E0856CF2EB85DB6A464264704528187E18A808A0D569",
        salt: "O%0jc@_Qy)gAa9d",
        length: 6,
        isNumeric: true
    )
    
    /// Has been unlocked?
    private var isUnlocked = false
    
    // MARK: - Methods
    
    /// Present the unlock code view controller
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if isUnlocked {
            print("Arrived at `viewDidAppear(_:)` with the content unlocked!")
        } else {
            whenUnlocked {
                print("Go to the locked content here!")
            }
        }
    }
    
    /// Perform the closure when the unlock code has been entered
    private func whenUnlocked(_ doTheThing: @escaping () -> Void) {
        guard !isUnlocked else { return }
        
        // Create view controller
        let viewController = UnlockCodeViewController(unlockCode: myUnlockCode) { [weak self] _ in
            self?.isUnlocked = true
            doTheThing()
        }
        
        // Dismiss when unlocked
        viewController.autodismissOnUnlock = true
        
        // Add view controller to the heirachy
        present(viewController, animated: false)
    }

}

