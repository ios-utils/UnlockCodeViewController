//
//  UnlockCodeViewController
//  Reece Como
//
//  Created by Reece Como on 21/4/18.
//  Copyright © 2018 Reece Como. All rights reserved.
//

import UIKit

internal extension UIView {
    
    ///
    /// Shake Animation (rapiddg)
    /// Source: https://www.rapiddg.com/blog/shaking-animation-swift
    ///
    @discardableResult
    internal func shake(repeatCount: Float = 0) -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = repeatCount
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 10, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 10, y: self.center.y))
        self.layer.add(animation, forKey: "position")
        return animation
    }
    
}
