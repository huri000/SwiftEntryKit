# QuickLayout

[![Platform](https://img.shields.io/cocoapods/p/QuickLayout.svg?style=flat)](http://cocoapods.org/pods/QuickLayout)
[![Language](http://img.shields.io/badge/language-Swift-brightgreen.svg?style=flat
)](https://developer.apple.com/swift)
![](https://travis-ci.org/huri000/QuickLayout.svg?branch=master)
[![Version](https://img.shields.io/cocoapods/v/QuickLayout.svg?style=flat-square)](http://cocoapods.org/pods/QuickLayout)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![codecov](https://codecov.io/gh/huri000/QuickLayout/branch/master/graph/badge.svg)](https://codecov.io/gh/huri000/QuickLayout)
[![License](https://img.shields.io/cocoapods/l/QuickLayout.svg?style=flat-square)](http://cocoapods.org/pods/QuickLayout)

![image](https://github.com/huri000/assets/blob/master/quick-layout/logo.png)

QuickLayout offers an additional way, to easily manage the Auto Layout using only code.
You can harness the power of QuickLayout to align your interface programmatically without even creating constraints explicitly.

* [The WHY](#the-why)
* [Naming Convension](#naming-convension)
* [Features](#features)
* [Example Project](#example-project)
* [Requirements](#requirements)
* [Installation](#installation)
  * [CocoaPods](#cocoapods)
  * [Carthage](#carthage)
  * [Manually](#manually)
* [Usage](#usage)
  * [Constant edges](#constant-edges)
  * [Layout to Superview](#layout-to-superview)
    * [Layout edge-x to superview edge-x](#layout-edge-x-to-superview-edge-x)
    * [Using the applied constraint](#using-the-applied-constraint)
    * [Ratio](#ratio)
    * [Offset](#offset)
    * [Center](#center)
    * [Size](#size)
    * [Fill](#fill)
    * [Axis](#axis)
  * [Layout to View](#layout-to-view)
    * [Edge-x to edge-x of another view](#edge-x-to-edge-x-of-another-view)
    * [Multiple edges](#multiple-edges)
  * [Content Wrap](#content-wrap)
  * [Array of QLView Elements](#array-of-uiview-elements)
    * [Constant edges](#constant-edges)
    * [Axis](#axis)
    * [Multiple edges](#multiple-edges)
    * [Spread views](#spread-views)
  * [More](#more)
    * [Priority](#priority)
    * [Relation](#relation)
    * [Ratio](#ratio)
    * [Offset](#offset)
  * [Explicit Layout](#explicit-layout)

## The **WHY**
Why should you use QuickLayout?
- QuickLayout  drastically shortens the amount of code in case you ever need to write the view hierarchy.
- It provides a common Auto Layout API for iOS, tvOS and macOS.
- QuickLayout contains most of the Auto Layout constructs an iOS App requires.
- The QuickLayout method declarations are very descriptive and clear. It is fully documented!
- Layout a `UIView` or `NSView` or an array of views using the instances themselves, without even creating a single NSLayoutConstraint instance.

## Naming Convension
As of version 2.0.0, QuickLayout supports tvOS and macOS as well as iOS. Therefore, a few adjustments have been made. 
- `QLView` replaces `UIView` or `NSView`.
- `QLPriority` replaces `NSLayoutConstraint.Priority` and `UILayoutPriority`
- `QLAttribute` replaces `NSLayoutConstraint.Attribute` and `NSLayoutAttribute`
- `QLRelation` replaces `NSLayoutConstraint.Relation` and `NSLayoutRelation`

## Features
- Extension to `QLView` that contains functionality that allows you to set constraints directly from the view itself.
- Extension to `Array of QLView` that contains functionality that allows you to set constraints directly from an array of views.

## Example Project
The example project demonstrates the benefits of using QuickLayout with several common use cases.
Have a look! 😎

## Requirements

Swift 4.0 or any higher version.

## Installation

### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

To integrate QuickLayout into your Xcode project using CocoaPods, specify the following in your `Podfile`:

```ruby
pod 'QuickLayout', '2.1.1'
```

Then, run the following command:

```bash
$ pod install
```

### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks.

You can install Carthage with [Homebrew](http://brew.sh/) using the following command:

```bash
$ brew update
$ brew install carthage
```

To integrate QuickLayout into your Xcode project using Carthage, specify the following in your `Cartfile`:

```ogdl
github "huri000/QuickLayout" == 2.1.1
```

#### Manually

Add the [source files](https://github.com/huri000/QuickLayout/tree/master/QuickLayout) to your project.


## Usage

Using QuickLayout is easy. No setup or preparation is required.
All the necessary methods are already available in any of the `QLView` instances, and are fully documented and highly descriptive.

**First, some boilerplate code**: Define `simpleView` of type `QLView` and add it to the view hierarchy.

```Swift
// Create a view, add it to view hierarchy, and customize it
let simpleView = QLView()
simpleView.backgroundColor = .gray
parentView.addSubview(simpleView)
```

### Constant edges

Set a constant edge of a view:
```Swift
simpleView.set(.height, of: 50)
```

You can set multiple constant edges using [variadic parameters](https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Functions.html):
```Swift
simpleView.set(.width, .height, of: 100)
```

### Layout to Superview

You can easily layout a view directly to its superview as long as it has one.

#### Layout edge-x to superview edge-x

Layout the top of a view to the top of its superview:
```Swift
simpleView.layoutToSuperview(.top)
```

Layout the centerX of a view to the centerX of its superview:
```Swift
simpleView.layoutToSuperview(.centerX)
```

#### Multiple edges

You can also layout multiple edges likewise, using [variadic parameters](https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Functions.html):
```Swift
simpleView.layoutToSuperview(.top, .bottom, .centerX, .width)
```

#### Using the applied constraint

All the layout methods return the applied constraints, but the returned values are [discardable](https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Attributes.html) so you can simply ignore them if you don't need them.
```Swift    
let topConstraint = simpleView.layoutToSuperview(.top)
```
```Swift
// Change the offset value by adding 10pts to it
topConstraint.constant += 10
```

#### Ratio

You can layout a view to 80% its superview width:
```Swift    
simpleView.layoutToSuperview(.width, ratio: 0.8)
```

#### Offset

You can layout a view to it's superview width minus 10pts offset:
```Swift    
simpleView.layoutToSuperview(.width, offset: -10)
```

#### Center

Layout view to the center of superview:
```Swift    
let center = simpleView.centerInSuperview()
```

You can optionally retreive the returned `QLCenterConstraints` instance.

```Swift
center?.y.constant = 20
```

That is the equivalent of doing the following, without getting the `QLCenterConstraints` instance (but an array of `NSLayoutConstraint` instead).
```Swift
simpleView.layoutToSuperview(.centerX, .centerY)
```

#### Size

Size to superview with optional ratio - It means that `simpleView` is 80% its superview size. 
```Swift    
let size = simpleView.sizeToSuperview(withRatio: 0.8)
```

You can optionally retreive the returned `QLSizeConstraints`  instance.

```Swift    
size?.width.constant = -20
```

That is the equivalent of doing the following, without getting the `QLSizeConstraints` instance (but an array of `NSLayoutConstraint` instead).
```Swift
simpleView.layoutToSuperview(.width, .height, ratio: 0.8)
```

#### Fill

```Swift    
let fillConstraints = simpleView.fillSuperview()
```

You can optionally retreive the returned `QLFillConstraints`  instance.

```Swift
fillConstraints?.center.y.constant = 5
```

#### Axis:

You can layout view to a certain axis, for example:

Horizontally:
```Swift
let axis = simpleView.layoutToSuperview(axis: .horizontally)
```

Vertically:
```Swift
simpleView.layoutToSuperview(axis: .vertically)
```

That is equivalent to (Horizontally):
```Swift
simpleView.layoutToSuperview(.left, .right)
```

Or (Vertically):

```Swift
simpleView.layoutToSuperview(.top, .bottom)
```

You can reteive the `QLAxisConstraints` instance as well and use it.

### Layout to View

It is possible to layout one view to another inside the view hierarchy.

#### Layout edge-x to edge-y of another view

You can layout an edge of a view to another. For example: 

Layout `simpleView`'s `left` edge to the `right` edge of  `anotherView`, with `20pts right offset`.

```Swift
simpleView.layout(.left, to: .right, of: anotherView, offset: 20)
```

#### Edge-x to edge-x of another view

Layout `simpleView`'s `top` edge to the `top` edge of  `anotherView`

```Swift
simpleView.layout(to: .top, of: anotherView)
```

####  Multiple edges

Layout `simpleView`'s left, right and centerY to `anotherView`'s left, right and centerY, respectively.

```Swift
simpleView.layout(.left, .right, .centerY, to: anotherView)
```

### Content Wrap

Content Hugging Oriority and Content Compression Resistance can be also mutated in code

Vertical example:
```Swift
let label = UILabel()
label.text = "Hi There!"
label.verticalCompressionResistancePriority = .required
label.verticalHuggingPriority = .required
```

You can set the compression resistence and the hugging priority, together. Thus, forcing both to be `.required` vertically and horizontally. 
```Swift
label.forceContentWrap()
```

You can force content wrap a specific axis:

```Swift
label.forceContentWrap(.vertically)
```

### Array of `QLView` Elements

You can generate an array of views and apply constraints on them all in one shot.

```Swift
// Create array of views and customize it
var viewsArray: [QLView] = []
for _ in 0...4 {
    let simpleView = QLView()
    view.addSubview(simpleView)
    viewsArray.append(simpleView)
}
```

#### Constant edges

Each element gets height of 50pts, using this single line of code.

```Swift
viewsArray.set(.height, of: 50)
```

#### Axis

Each element cling to left and right of its superview.

```Swift
viewsArray.layoutToSuperview(axis: .horizontally, offset: 30)
```

#### Multiple edges

Each element left, right, top, bottom edges is exactly fits another view.

```Swift
viewsArray.layout(.left, .right, .top, .bottom, to: parentView)
```

#### Spread views

You can spread the elements one below the other (vertically), the first stretches to the top of the superview and the last stretchs to the bottom of the superview. There is an offset of 1pt between each element. 

```Swift
viewsArray.spread(.vertically, stretchEdgesToSuperview: true, offset: 1)
```

### More

Every layout method has several optional parameters - see below:

####  Priority

- The priority of the applied constraint. 
- Included by all the layout methods.
- Default value: `.required`.

Other than the default system priorities,  QuickLayout offers one more - it has 999 value and it's called  `.must`.

You can tweak the priorities as you like in order to deal with breakage and redundancies.

Example for setting the constraints priority:

```Swift
let width = simpleView.set(.width, of: 100, priority: .must)
```

#### Relation

- The relation of a view to another view. 
- Included by most of the layout methods.
- Default value: `.equal`

#### Ratio

- The ratio of a view to another view. 
- Included by most of the layout methods.
- Default value: 1

#### Offset

- The offset of a view to another view. 
- Included by most of the layout methods.
- Default value: 0

### Explicit Layout

You can layout a view/s explicitly to a superview or another view when you need to.
Most paramters have a default value.

```Swift
simpleView.layout(.height, to: .width, of: anotherView, relation: .lessThanOrEqual, ratio: 0.5, offset: 10, priority: .defaultHigh)
```

## Contributing

Forks, patches and other feedback are welcome.

## Author

Daniel Huri (huri000@gmail.com)

## License

QuickLayout is available under the MIT license. See the LICENSE file for more info.

