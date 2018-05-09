# QuickLayout
[![Platform](http://img.shields.io/badge/platform-iOS-blue.svg?style=flat
)](https://developer.apple.com/iphone/index.action)
[![Language](http://img.shields.io/badge/language-Swift-brightgreen.svg?style=flat
)](https://developer.apple.com/swift)
[![Version](https://img.shields.io/cocoapods/v/QuickLayout.svg?style=flat-square)](http://cocoapods.org/pods/QuickLayout)
![](https://travis-ci.org/huri000/QuickLayout.svg?branch=master)
[![codecov](https://codecov.io/gh/huri000/QuickLayout/branch/master/graph/badge.svg)](https://codecov.io/gh/huri000/QuickLayout)
[![License](https://img.shields.io/cocoapods/l/QuickLayout.svg?style=flat-square)](http://cocoapods.org/pods/QuickLayout)
[![Total Downloads](https://img.shields.io/cocoapods/dt/QuickLayout.svg?style=social)](https://cocoapods.org/pods/QuickLayout)

Harness the power of QuickLayout to align your interface programmatically, without using the Interface Builder.
QuickLayout offers you a simple and easy way to assign and manage constraints via code.

![sample](Example/Screenshots/TableScreen_screenshot.png)
![sample](Example/Screenshots/ScrollScreen_screenshot.png)

## Example
The example project (xib/storyboard free) demonstrates the power of pragrammatic constraints with QuickLayout using several use cases.
To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements
Swift 4.0 and iOS 9.0 (or higher).

## Features
- Extension to `UIView`: Contains functionality that allows you to set constraints directly from the view itself.
- Extension to `Array of UIView`: Contains functionality that allows you to set constraints directly from array of views.

## Usage of `UIView+QuickLayout`

    // Create a view, add it to view hierarchy, and customize it
    let simpleView = UIView()
    simpleView.backgroundColor = .gray
    view.addSubview(simpleView)
    
#### Set constant height
    simpleView.set(.height, of: 50)
    
#### Make simpleView cling to the top of it's superview
    simpleView.layoutToSuperview(.top)
    
#### Make simpleView cling to the center of it's superview
    simpleView.layoutToSuperview(.centerX)
    
#### Make simpleView to stretch to 80% of the width of it's superview
    simpleView.layoutToSuperview(.width, ratio: 0.8)

#### Example for retrieving back constraint after setting it (Method's result is discardable, but you can access the constraint value after using invoking it):

    let constraint = simpleView.layoutToSuperview(.centerX)

#### Center simpleView in superview, and retrieve the x, y constraints in `QLCenterConstraints` object:

    let center = simpleView.centerInSuperview()
    
    // Move simpleView 20 dots down and right using x property of `QLCenterConstraints`
    center?.x.constant = 20
    center?.y.constant = 20

#### Size simpleView to it's superview, and retrieve the constraints in `QLSizeConstraints` object:

    let size = simpleView.sizeToSuperview()
    
    // Access width and height constraints easily
    size?.width.constant = -20
    
#### Make simpleView totally fill superview, and retrieve all constraints via `QLFillConstraints`:

    let constraints = simpleView.fillSuperview()
    
#### You can layout view in relation to another view, and optionally set constant distance between them:

    simpleView.layout(.left, to: .right, of: anotherView, offset: 20)

#### Use variatic parameter to easiliy install constraints for `simpleView`, simultaniouly.
    
    simpleView.layoutToSuperview(.top, .bottom, .left, .right)

## Usage of `UIViewArray+QuickLayout`

    // Create array of views and customize it
    var viewsArray: [UIView] = []
    for _ in 0...4 {
        let simpleView = UIView()
        view.addSubview(simpleView)
        viewsArray.append(simpleView)
    }

#### Set constant height for each element in `viewsArray`

    viewsArray.set(.height, of: 50)

#### Stretch each element of `viewsArray` horizontally to superview, with 30 margin from each side

    viewsArray.layoutToSuperview(axis: .horizontally, offset: 30)

#### Spread elements vertically in superview with 8 margin between them, laso layout first and last to superview with `stretchEdgesToSuperview`

    viewsArray.spread(.vertically, stretchEdgesToSuperview: true, offset: 8)

## Installation
    
#### CocoaPods
```
pod 'QuickLayout', '1.0.13'
```

#### Manually
Add the source files to your project.

## Contributing
Forks, patches and other feedback are welcome.

## Author
Daniel Huri (huri000@gmail.com)

## License

QuickLayout is available under the MIT license. See the LICENSE file for more info.
