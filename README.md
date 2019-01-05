# UnlockCodeViewController

[![Codacy Badge](https://api.codacy.com/project/badge/Grade/4f2d0af666c4407091fcff2363aff515)](https://app.codacy.com/app/reececomo/UnlockCodeViewController?utm_source=github.com&utm_medium=referral&utm_content=reececomo/UnlockCodeViewController&utm_campaign=Badge_Grade_Dashboard)
[![Build Status](https://travis-ci.org/reececomo/UnlockCodeViewController.svg?branch=master)](https://travis-ci.org/reececomo/UnlockCodeViewController)
[![Version](https://img.shields.io/cocoapods/v/UnlockCodeViewController.svg?style=flat)](https://cocoapods.org/pods/UnlockCodeViewController)
[![License](https://img.shields.io/cocoapods/l/UnlockCodeViewController.svg?style=flat)](https://cocoapods.org/pods/UnlockCodeViewController)
[![Platform](https://img.shields.io/cocoapods/p/UnlockCodeViewController.svg?style=flat)](https://cocoapods.org/pods/UnlockCodeViewController)

<p align="center">
<img src="https://raw.githubusercontent.com/reececomo/UnlockCodeViewController/master/UnlockCodeViewController.jpg" alt="UnlockCodeViewController" style="max-width:625px;width:auto;height:auto;"/>
</p>

## Usage
```swift
// Create an unlock code somewhere
let myCode = UnlockCode(generateFor: "MyCode123", withSalt: "$sP%2mK!2Df")

// Create the view controller
let myCodeViewController = UnlockCodeViewController(unlockCode: myCode) { _ in
    // Optionally put anything here that will get called when the code has finished unlocking
    navigationController.setViewControllers([myLockedContentViewController], animated: true)
}

// Provide any additional config
myCodeViewController.pinCharacter = "*"
myCodeViewController.blankCharacter = "_"
myCodeViewController.playsSound = false
myCodeViewController.autoDismissOnUnlock = false
myCodeViewController.autoDismissOnFailure = true
myCodeViewController.maxAttemptsAllowed = 5

// Present the view controller
navigationController.setViewControllers([myCodeViewController], animated: false)
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
