# UnlockCodeViewController

A simple drop-in Unlock Code view controller.

[![Codacy Badge](https://api.codacy.com/project/badge/Grade/4f2d0af666c4407091fcff2363aff515)](https://app.codacy.com/app/reececomo/UnlockCodeViewController?utm_source=github.com&utm_medium=referral&utm_content=reececomo/UnlockCodeViewController&utm_campaign=Badge_Grade_Dashboard)
[![CodeCov Badge](https://codecov.io/gh/reececomo/UnlockCodeViewController/branch/master/graph/badge.svg)](https://codecov.io/gh/reececomo/UnlockCodeViewController)
[![Build Status](https://travis-ci.org/reececomo/UnlockCodeViewController.svg?branch=master)](https://travis-ci.org/reececomo/UnlockCodeViewController)
[![Version](https://img.shields.io/cocoapods/v/UnlockCodeViewController.svg?style=flat)](https://cocoapods.org/pods/UnlockCodeViewController)
[![License](https://img.shields.io/cocoapods/l/UnlockCodeViewController.svg?style=flat)](https://cocoapods.org/pods/UnlockCodeViewController)
[![Platform](https://img.shields.io/cocoapods/p/UnlockCodeViewController.svg?style=flat)](https://cocoapods.org/pods/UnlockCodeViewController)

<p align="center">
<img src="https://raw.githubusercontent.com/reececomo/UnlockCodeViewController/master/UnlockCodeViewController.jpg" alt="UnlockCodeViewController" width="625" style="max-width:625px;width:auto;height:auto;"/>
</p>

## Usage

### Basic Usage
```swift
// Create the view controller
let viewController = UnlockCodeViewController(unlockCode: myCode)

// Present the view controller
navigationController.setViewControllers([viewController], animated: false)

// Set the unlock action (this can also be set in the constructor)
viewController.whenUnlocked { _ in
    navigationController.setViewControllers([myLockedContentViewController], animated: true)
}
```

### Additional Config
```swift
// (Optional) Additional config
viewController.pinCharacter = "*"           // default: "●"
viewController.blankCharacter = "_"         // default: "○"
viewController.playsSound = false           // default: `true`
viewController.autoDismissOnUnlock = false  // default: `false`
viewController.autoDismissOnFailure = true  // default: `false`
viewController.maxAttemptsAllowed = 5       // default: 3
```

### Generating an UnlockCode
- Ideally you would set the unlock code remotely, and load it into your app.
- Then next best option would be to use a pre-generated code. Otherwise anyone can decompile your application and read your code in plaintext.
```swift
// Using a pre-generated code (e.g. "123456")
let myCode = UnlockCode(
    hash: "2DBD6C5C6085CB173C76E0856CF2EB85DB6A464264704528187E18A808A0D569",
    salt: "O%0jc@_Qy)gAa9d",
    length: 6,
    isNumeric: true
)

// Or generate one on the fly (*Not Recommended*)
let myGeneratedCode = try! UnlockCode(generateFor: "123456")
```

## Example Project

To run the example project, clone the repo, and run in Xcode 10 or greater.

## Installation

### CocoaPods

UnlockCodeViewController is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'UnlockCodeViewController'
```

## Author

Reece Como, reece.como@gmail.com

## License

UnlockCodeViewController is available under the MIT license. See the LICENSE file for more info.
