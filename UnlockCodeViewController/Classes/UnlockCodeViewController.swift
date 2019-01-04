//
//  UnlockCodeViewController
//  Reece Como
//
//  Created by Reece Como on 21/4/18.
//  Copyright © 2018 Reece Como. All rights reserved.
//

import UIKit
import AVFoundation

/**
 UnlockCodeViewController
 */
public class UnlockCodeViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - Configuration
    
    /// Pin character
    public var pinCharacter = "●"
    
    /// Blank character
    public var blankCharacter = "○"
    
    /* @required Set unlockCode during init/viewDidLoad */
    public var unlockCode: UnlockCode!
    
    /// Plays sound
    public var playsSound = true
    
    /// Hide on unlock
    public var autodismissOnUnlock = false
    
    /// Max attempts. -1 is unlimited.
    public var maxAttemptsAllowed = 3
    
    /// On unlock callback
    private var onUnlockClosure: ((_ code: String) -> Void)?
    
    // MARK: - Properties
    
    /// Whether or not the interface is currently enabled
    private(set) public var isEnabled = true
    
    /// Current attempt
    private(set) public var currentAttempt = 0
    
    // MARK: - Private properties
    
    /// Display label
    private var displayLabel: UILabel!
    
    /// Hidden input field
    private var hiddenInput: UITextField!
    
    /// Keyboard height offset
    private var keyboardHeightOffset: CGFloat = 0
    
    // MARK: - Initialisers
    
    ///
    /// Unlock code details
    ///
    public convenience init(unlockCode: UnlockCode, whenUnlocked onUnlockClosure: ((_ code: String) -> Void)? = nil) {
        self.init()
        self.unlockCode = unlockCode
        whenUnlocked(onUnlockClosure)
    }
    
    /// Deinit - remove the notification observer
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Methods
    
    /// Set an additional unlocked closure action
    public func whenUnlocked(_ closure: ((_ code: String) -> Void)?) {
        onUnlockClosure = closure
    }
    
    /// Attempt did unlock
    public func attemptDidUnlock() {
        hiddenInput.resignFirstResponder()
        
        if playsSound {
            // Lock click sound
            AudioServicesPlaySystemSound(1100)
        }
        
        if autodismissOnUnlock {
            dismissOrPop()
        }
        
        onUnlockClosure?(hiddenInput.text ?? "")
    }
    
    /// Attempt did fail
    public func attemptDidFail() {
        presentFailedAttemptFeedback()
        
        if maxAttemptsAllowed > 0, currentAttempt >= maxAttemptsAllowed {
            maxAttemptsReached()
        } else {
            resetField()
        }
        
        updateDisplayValue()
    }
    
    /// Maximum attempts reached
    public func maxAttemptsReached() {
        isEnabled = false
    }
    
    // MARK: - UIViewController
    
    /// View did load
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        title = title ?? "Unlock Code Required"
        view.backgroundColor = .groupTableViewBackground
        
        configureNavigationItems()
        configureDisplayLabel()
        configureHiddenInputField()
        
        // Listen for keyboard notification
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillChangeFrame),
                                               name: UIResponder.keyboardWillChangeFrameNotification,
                                               object: nil)
    }
    
    /// View will appear
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        hiddenInput.isEnabled = isEnabled
        
        if isEnabled {
            hiddenInput.becomeFirstResponder()
        }
        
        updateDisplayValue()
    }
    
    /// Will redraw
    override public func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        let xMargin: CGFloat = 64.0
        displayLabel.frame = CGRect(x: 0, y: 0, width: view.frame.size.width - xMargin, height: 44)
        displayLabel.center = CGPoint(x: view.center.x, y: (view.frame.size.height - keyboardHeightOffset)/2)
    }
    
    /// Cancel buttonw was tapped
    @objc func cancelButtonTapped(_ sender: Any) {
        dismissOrPop()
    }
    
    /// Text field value was changed
    @objc func textFieldDidChange() {
        updateDisplayValue()
        
        let inputValue = hiddenInput.text ?? ""
        
        if inputValue.count >= unlockCode.length {
            validateAttempt(with: inputValue, onSuccess: attemptDidUnlock, onFailure: attemptDidFail)
        }
    }
    
    // MARK: - Implementation
    
    /// Dismiss
    private func dismissOrPop(animated: Bool = true) {
        if let navigationController = navigationController, navigationController.viewControllers.count > 1 {
            navigationController.popViewController(animated: animated)
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
    
    /// Shakes the UI and vibrates
    private func presentFailedAttemptFeedback() {
        AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
        displayLabel.shake()
    }
    
    /// Create the cancel button and hide the back button
    private func configureNavigationItems() {
        // Cancel button
        let cancelButton = UIBarButtonItem(image: nil,
                                           style: .plain,
                                           target: self,
                                           action: #selector(cancelButtonTapped))
        cancelButton.title = "Cancel"
        navigationItem.rightBarButtonItem = cancelButton
        
        // Hide back button
        navigationItem.hidesBackButton = true
    }
    
    /// Prepare for another attempt
    private func resetField() {
        hiddenInput.text = ""
    }
    
    /// Create the display label and add it to the view heirachy
    private func configureDisplayLabel() {
        displayLabel = UILabel()
        displayLabel.textColor = .lightGray
        displayLabel.font = UIFont(name: "Menlo", size: 32.0)
        displayLabel.textAlignment = .center
        displayLabel.adjustsFontSizeToFitWidth = true
        displayLabel.minimumScaleFactor = 0.2
        
        view.addSubview(displayLabel)
    }
    
    /// Create hidden input field and add it to the view heirachy
    private func configureHiddenInputField() {
        hiddenInput = UITextField(frame: .zero)
        hiddenInput.delegate = self
        hiddenInput.isHidden = true
        hiddenInput.isSecureTextEntry = true
        hiddenInput.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        if unlockCode.isNumeric {
            hiddenInput.keyboardType = .numberPad
        }
        
        view.addSubview(hiddenInput)
    }
    
    /// Validate attempt
    private func validateAttempt(with attempt: String, onSuccess: () -> Void, onFailure: () -> Void) {
        currentAttempt += 1
        
        if unlockCode.isEqualTo(attempt) {
            onSuccess()
        } else {
            onFailure()
        }
    }
    
    /// Update display value
    private func updateDisplayValue() {
        if isEnabled {
            let value = hiddenInput.text ?? ""
            
            // String in the format: "XX____" (where "X" is `pinCharacter` and "_" is `blankCharacter`)
            let stringValue = String(repeating: pinCharacter, count: value.count) +
                String(repeating: blankCharacter, count: unlockCode.length - value.count)
            
            // Add a space between the characters
            displayLabel.text = stringValue
                .map { String($0) }
                .joined(separator: " ")
        } else {
            //
            // Show "Disabled" text instead
            //
            displayLabel.text = "Disabled"
            hiddenInput.resignFirstResponder()
        }
    }
    
    /// Resize container to center above keyboard
    @objc func keyboardWillChangeFrame(notification: NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        
        let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        let endFrameY = endFrame?.origin.y ?? 0
        let duration: TimeInterval = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
        let animationCurveRawNSN = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber
        let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIView.AnimationOptions.curveEaseInOut.rawValue
        let animationCurve = UIView.AnimationOptions(rawValue: animationCurveRaw)
        
        if endFrameY >= UIScreen.main.bounds.size.height {
            keyboardHeightOffset = 0.0
        } else {
            keyboardHeightOffset = endFrame?.size.height ?? 0.0
        }
        
        UIView.animate(withDuration: duration,
                       delay: 0,
                       options: animationCurve,
                       animations: { [weak self] in self?.view.layoutIfNeeded() },
                       completion: nil)
    }
    
    // MARK: - UITextFieldDelegate
    
    /// Should change characters in range
    public func textField(_ textField: UITextField,
                          shouldChangeCharactersIn range: NSRange,
                          replacementString string: String) -> Bool {
        guard let text = textField.text else { return false }
        return text.count + (string.count - range.length) <= unlockCode.length
    }
    
}
