# SwiftEntryKit <img align="left" height=42 src="https://github.com/huri000/assets/blob/master/swift-entrykit/project-icon.png">

[![Platform](http://img.shields.io/badge/platform-iOS-blue.svg?style=flat)](https://developer.apple.com/iphone/index.action)
[![Language](http://img.shields.io/badge/language-Swift-brightgreen.svg?style=flat)](https://developer.apple.com/swift)
[![License](http://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat)](http://mit-license.org)
[![Version](https://img.shields.io/cocoapods/v/SwiftEntryKit.svg?style=flat-square)](http://cocoapods.org/pods/SwiftEntryKit)
![](https://travis-ci.org/huri000/SwiftEntryKit.svg?branch=master)

* [Overview](#overview)
  * [Features](#features)
* [Example Project](#example-project)
  * [Presets](#presets)
  * [Playground](#playground)
* [Requirements](#requirements)
* [Installation](#installation)
* [Usage](#usage)
  * [Quick Usage](#quick-usage)
  * [Entry Attributes](#entry-attributes)
    * [Window Level](#window-level)
    * [Display Position](#display-position)
    * [Display Priority](#display-priority)
    * [Display Duration](#display-duration)
    * [Position Constraints](#position-constraints)
    * [User Interaction](#user-interaction)
    * [Scroll Behavior](#scroll-behavior)
    * [Haptic Feedback](#haptic-feedback)
    * [Background Style](#background-style)
    * [Shadow](#shadow)
    * [Round Corners](#round-corners)
    * [Border](#border)
    * [Animations](#animations)
    * [Pop Behavior](#pop-behavior)
    * [Status Bar Style](#status-bar-style)
  * [Presets Usage Example](#presets-usage-example)
  * [Custom View Usage Example](#custom-view-usage-example)
  * [Dismissing an Entry](#dismissing-an-entry)
  * [Swiping And Rubber Banding](#swiping-and-rubber-banding)
  * [Dealing With Safe Area](#dealing-with-safe-area)
  * [Dealing With Orientation Change](#dealing-with-orientation-change)
* [Known Issues](#known-issues)
* [Contributing](#contributing)
* [Author](#author)
* [License](#license)

## Overview

SwiftEntryKit is a simple and versatile pop-up presenter written in Swift.

### Features

Banners or Pop-Ups are called *Entries*.

- The entries are displayed in a separated UIWindow (of type EKWindow), so the user is able to navigate the app freely while entries are being displayed in a non intrusive manner.
- The kit offers some beautiful [presets](#presets) that can be themed with your app colors and fonts.
- **Customization**: Entries are highly customizable
  - [x] Can be displayed at the top or the bottom of the screen.
  - [x] Can be displayed within or outside the screen's safe area.
  - [x] Can be stylized: have a border, drop-shadow and round corners.
  - [x] Their content's and the screen's background can be blurred, dimmed, colored or have a gradient style.
  - [x] Transition animations are customizable - Entrance, Exit and Pop (by another entry).
  - [x] The user interactions with the entry or the screen can be intercepted.
  - [x] Entries have an optional rubber banding effect in panning.
  - [x] Entries can be optionally dismissed by a simple swipe gesture.
  - [x] Entries have display priority attribute. That means that an entry can be dismissed only be other entry with equal or higher priority. 
  - [x] The status bar style is settable for the display duration of the entry.
  - [x] SwiftEntryKit supports [custom views](#custom-view-usage-example) as well.

## Example Project

The example project contains various presets and examples you can use and modify as your like.

### Presets

Toasts | Notes | Floats | Popups | Custom1 | Custom2
--- | --- | --- | --- | --- | ---
![toasts_example](https://github.com/huri000/assets/blob/master/swift-entrykit/toasts.gif) | ![notes_example](https://github.com/huri000/assets/blob/master/swift-entrykit/notes.gif) | ![floats_example](https://github.com/huri000/assets/blob/master/swift-entrykit/floats.gif) | ![popup_example](https://github.com/huri000/assets/blob/master/swift-entrykit/popups.gif) | ![nibs](https://github.com/huri000/assets/blob/master/swift-entrykit/nibs.gif) | ![customization](https://github.com/huri000/assets/blob/master/swift-entrykit/customization.gif)


### Playground

**noun: a place where people can play 🏈**

The example app contains a playground screen, an interface that allows you to customize your preferable entries.
The playground screen has some limitations (allows to select constant values) but you can easily modify the code to suit your needs. Check it out!

The Playground Screen | Top Toast Sample
--- | ---
![playground_example](https://github.com/huri000/assets/blob/master/swift-entrykit/playground.gif) | ![playground-sample-1](https://github.com/huri000/assets/blob/master/swift-entrykit/playground-sample-1.jpeg)

## Requirements

- iOS 9 or any higher version.
- Xcode 9 or any higher version.
- Swift 4.0 or any higher version.
- The library has not been tested with iOS 8.x.y or a lower version.
- SwiftEntryKit leans heavily on [QuickLayout](https://github.com/huri000/QuickLayout) - A lightwight library written in Swift that is used to easily layout views programmatically.

## Installation

### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

To integrate SwiftEntryKit into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/cocoapods/specs.git'
platform :ios, '9.0'
use_frameworks!

pod 'SwiftEntryKit', '0.1.5'
```

Then, run the following command:

```bash
$ pod install
```

## Usage

### Quick Usage

No setup is needed! Each time you wish to display an entry, just create your view and initialize an EKAttributes struct.
See also the [preset usage example](#presets-usage-example), and the example project.
likewise:
```Swift
// Customized view
let customView = SomeCustomView()
/*
Do some customization on customView
*/

// Attributes struct that describes the display, style, user interaction and animations of customView.
var attributes = EKAttributes()
/*
Adjust preferable attributes
*/
```
And then, just call:
```Swift
SwiftEntryKit.display(entry: customView, using: attributes)
```
The kit will replace the application main window with the EKWindow instance and display the entry.

### Entry Attributes

*EKAttributes* is the entry's descriptor. Each time an entry is displayed, an EKAttributes struct is necessary to describe the entry's presentation, position inside the screen, the display duration, it's frame constraints (if needed), it's styling (corners, border and shadow), the user interaction events, the animations (in / out) and more.

Create a mutable EKAttributes structure likewise:
```Swift
var attributes = EKAttributes()
```

Below are the properties that can be modified in the *EKAttributes*:

#### Window Level
Entries can be displayed above the application main window, above the status bar, above the alerts window or even have a custom level (UIWindowLevel).

For example, set the window level to *normal*, likewise:
```Swift 
attributes.windowLevel = .normal
```
This causes the entry to appear above the application key window and below the status bar.

#### Display Position
The entry can be displayed either at the *top*, *center*, or the *bottom* of the screen.

For example, set the display position to *top*, likewise:
```Swift 
attributes.position = .top
```

#### Display Priority 
The display priority of the entry determines whether it dismisses other entries or be dismissed by them. 
An entry can be dismissed only by an entry with an equal or a higher display priority.

```Swift
let highPriorityAttributes = EKAttributes()
highPriorityAttributes.displayPriority = .high

let normalPriorityAttributes = EKAttributes()
normalPriorityAttributes.displayPriority = .normal

// Display high priority entry
SwiftEntryKit.display(entry: view1, using: highPriorityAttributes)

// Display normal priority entry (ignored!)
SwiftEntryKit.display(entry: view2, using: normalPriorityAttributes)
```

*view2* won't be displayed!

#### Display Duration
The display duration of the entry (Counted from the moment the entry has finished it's entrance animation and until the exit animation begins).

Display for 2 seconds:
```Swift
attributes.displayDuration = 2
```

Display for an infinate duration
```Swift
attributes.displayDuration = .infinity
```

#### Position Constraints 
Constraints that tie the entry tightly to the screen contexts, for example: Height, Width, Max Width, Max Height, Additional Vertical Offset & Safe Area related info.

For example:

Ratio edge - signifies that the ratio of the width edge has a ratio of 0.9 of the screen's width.
```Swift
let widthConstraint = EKAttributes.PositionConstraints.Edge.ratio(value: 0.9)
```

Intrinsic edge - signifies that the wanted height value is the content height - Decided by the entries vertical constraints
```Swift
let heightConstraint = EKAttributes.PositionConstraints.Edge.intrinsic
```

Create the entry size constraints likewise:
```Swift
attributes.positionConstraints.size = .init(width: widthConstraint, height: heightConstraint)
```
You can also set *attributes.positionConstraints.maxSize* in order to make sure the entry does not exceeds predefined limitations. This is useful on [device orientation change](#how-to-deal-with-orientation-change).

Safe Area - can be used to override the safe area or to color it (More examples are in the example project)
That snippet implies that the safe area insets should be kept and not be a part of the entry.
```Swift
attributes.positionConstraints.safeArea = .empty(fillSafeArea: false)
```

Vertical Offset - An additional offset that can be applied to the entry (Other than the safe area).
```Swift
attributes.positionConstraints.verticalOffset = 10
```

#### User Interaction
The entry and the screen can be interacted by the user. User interaction be can intercepted in various ways:

An interaction (Any touch whatsoever) with the entry delays it's exit by 3s:
```Swift
attributes.entryInteraction = .delayExit(by: 3)
```

A tap on the entry / screen dismisses it immediately:
```Swift
attributes.entryInteraction = .dismiss
attributes.screenInteraction = .dismiss
```

A tap on the entry is swallowed (ignored):
```Swift
attributes.entryInteraction = .absorbTouches
```

A tap on the screen is forwarded to the lower level window, in most cases the receiver will be the application window.
This is very useful when you want to display an unintrusive content like banners and push notification entries.
```Swift
attributes.screenInteraction = .forward
```

Pass additional actions that are invokes when the user taps the entry:
```Swift
let action = {
    // Do something useful
}
attributes.entryInteraction.customTapActions.append(action)
```

#### Scroll Behavior
Describes the entry behavior when it's being scrolled, that is, dismissal by a swipe gesture and a rubber band effect much similar to a UIScrollView.

Disable the pan and swipe gestures on the entry:
```Swift
attributes.scroll = .disabled
```

Enable swipe and stretch and pullback with jolt effect:
```Swift
attributes.scroll = .enabled(swipeable: true, pullbackAnimation: .jolt)
```

Enable swipe and stretch and pullback with an ease-out effect:
```Swift
attributes.scroll = .enabled(swipeable: true, pullbackAnimation: .easeOut)
```

Enable swipe but disable stretch:
```Swift
attributes.scroll = .edgeCrossingDisabled(swipeable: true)
```

#### [Haptic Feedback](https://developer.apple.com/ios/human-interface-guidelines/user-interaction/feedback/)
The device can produce a haptic feedback, thus adding an additional sensory depth to each entry.

#### Background Style
The entry and the screen can have various background styles, such as blur, color, gradient and even an image.

The default value is *.clear*. This example implies clear background for both the entry and the screen:
```Swift
attributes.entryBackground = .clear
attributes.screenBackground = .clear
```

Colored entry background and dimmed screen background:
```Swift
attributes.entryBackground = .color(color: .white)
attributes.screenBackground = .color(color: UIColor(white: 0.5, alpha: 0.5))
```

Gradient entry background (diagonal vector):
```Swift
let colors: [UIColor] = [.red, .green, .blue]
attributes.entryBackground = .gradient(gradient: .init(colors: colors, startPoint: .zero, endPoint: CGPoint(x: 1, y: 1)))
```

Visual Effect entry background:
```Swift
attributes.entryBackground = .visualEffect(style: .light)
```

#### Shadow
The shadow that surrounds the entry.

Enable shadow around the entry:
```Swift
attributes.shadow = .active(with: .init(color: .black, opacity: 0.3, radius: 10, offset: .zero))
```

Disable shadow around the entry:
```Swift
attributes.shadow = .none
```

#### Round Corners
Round corners around the entry.

Only top left and right corners with radius of 10:
```Swift
attributes.roundCorners = .top(radius: 10)
```

Only bottom left and right corners with radius of 10:
```Swift
attributes.roundCorners = .bottom(radius: 10)
```

All corners with radius of 10:
```Swift
attributes.roundCorners = .all(radius: 10)
```

No round corners:
```Swift
attributes.roundCorners = .none
```

#### Border
The border around the entry.

Add a black border with thickness of 0.5pts:
```Swift
attributes.border = .value(color: .black, width: 0.5)
```

No border:
```Swift
attributes.border = .none
```

#### Animations
Describes how the entry animates into and out of the screen. Each animation object can have 3 types of animations at the same time. You can combine animation to a complex one.

Example for a complex entrance animation that contains translation of the entry using spring animation, scale in and even fade in.
```Swift
attributes.entranceAnimation = .init(
                 translate: .init(duration: 0.7, spring: .init(damping: 1, initialVelocity: 0)), 
                 scale: .init(from: 0.6, to: 1, duration: 0.7), 
                 fade: .init(from: 0.8, to: 1, duration: 0.3))
```
#### Pop Behavior
Describes the entry behavior when it's being popped (dismissed by an entry with equal / higher display-priority.

The entry is being popped animatedly:
```Swift
attributes.popBehavior = .animated(animation: .init(translate: .init(duration: 0.2)))
```

The entry is being overriden (Disappears promptly):
```Swift
attributes.popBehavior = .overriden
```

#### Status Bar Style
The status bar style can be modified during the display of the entry. In order to enable this feature, set *View controller-based status bar appearance* to *NO* in your project's info.plist file.

Setting the status bar style is fairly simple
```Swift
attributes.statusBarStyle = .default
```
In case there is an already presenting entry with lower/equal display priority, the status bar will change it's style
When the entry is removed the status bar gets it's initial style back.

EKAttributes' interface is as follows:

```Swift
public struct EKAttributes

    // Display
    public var windowLevel: WindowLevel
    public var position: Position
    public var displayPriority: DisplayPriority
    public var displayDuration: DisplayDuration
    public var positionConstraints: PositionConstraints

    // User Interaction
    public var screenInteraction: UserInteraction
    public var entryInteraction: UserInteraction
    public var scroll: Scroll
    public var hapticFeedbackType: NotificationHapticFeedback

    // Theme & Style
    public var entryBackground: BackgroundStyle
    public var screenBackground: BackgroundStyle
    public var shadow: Shadow
    public var roundCorners: RoundCorners
    public var border: Border
    public var statusBarStyle: UIStatusBarStyle!
    
    // Animations
    public var entranceAnimation: Animation
    public var exitAnimation: Animation
    public var popBehavior: PopBehavior
}
```

### Presets Usage Example:

You can use one of the presets that come with SwiftEntryKit, doing these 4 simple steps:

1. Create your *EKAttributes* struct and set your preferrable properties.
2. Create *EKNotificationMessage* struct (The Content) and set the content.
3. Create *EKNotificationMessageView* (The View) and inject *EKNotificationMessage* struct to it.
4. Display the entry using *SwiftEntryKit* class method.

#### EKNotificationMessageView preset example:

```Swift
// Generate top floating entry and set some properties
var attributes = EKAttributes.topFloat
attributes.entryBackground = .gradient(gradient: .init(colors: [.red, .green], startPoint: .zero, endPoint: CGPoint(x: 1, y: 1)))
attributes.popBehavior = .animated(animation: .init(translate: .init(duration: 0.3), scale: .init(from: 1, to: 0.7, duration: 0.7)))
attributes.shadow = .active(with: .init(color: .black, opacity: 0.5, radius: 10, offset: .zero))
attributes.statusBarStyle = .default
attributes.scroll = .enabled(swipeable: true, pullbackAnimation: .jolt)
attributes.positionConstraints.maxSize = .init(width: .constant(value: UIScreen.main.minEdge), height: .intrinsic)

let title = EKProperty.LabelContent(text: titleText, style: .init(font: titleFont, color: textColor))
let description = EKProperty.LabelContent(text: descText, style: .init(font: descFont, color: textColor))
let image = EKProperty.ImageContent(image: UIImage(named: imageName)!, size: CGSize(width: 35, height: 35))
let simpleMessage = EKSimpleMessage(image: image, title: title, description: description)
let notificationMessage = EKNotificationMessage(simpleMessage: simpleMessage)

let contentView = EKNotificationMessageView(with: notificationMessage)
SwiftEntryKit.display(entry: contentView, using: attributes)
```

### Custom View Usage Example:

```Swift
// Create a basic toast that appears at the top
var attributes = EKAttributes.topToast

// Set it's background to white
attributes.entryBackground = .color(color: .white)

// Animate in and out using default translation
attributes.entranceAnimation = .translation
attributes.exitAnimation = .translation

let customView = UIView()
/*
... Customize the view as you like ...
*/

// Display the view with the configuration
SwiftEntryKit.display(entry: customView, using: attributes)
```

### Dismissing an Entry
You can dismiss an entry by simply invoke *dismiss* in the SwiftEntryKit class, likewise:
```Swift
SwiftEntryKit.dismiss()
```
This will dismiss the entry animatedly using it's *exitAnimation* attribute and on comletion it'll remove the window as well.

### Swiping and Rubber Banding
Entries can be panned vertically (This ability can be enabled using the *scroll* attributes). 
Thefore it's only natural that an entry can be dismissed using a swipe-like gesture.

Enable swipe gesture. When the swipe gesture fails (doesn't pass the velocity threshold) ease it back.
```Swift
attributes.scroll = .enabled(swipeable: true, pullbackAnimation: .easeOut)
```

Enable swipe gesture. When the swipe gesture fails throw it back out with a jolt.
```Swift
attributes.scroll = .enabled(swipeable: true, pullbackAnimation: .jolt)
```

The *PullbackAnimation* values (duration, damping & initialSpringVelocity) can be customized as well.

Swipe | Jolt
--- | ---
![swipe_example](https://github.com/huri000/assets/blob/master/swift-entrykit/swipe.gif) | ![band_example](https://github.com/huri000/assets/blob/master/swift-entrykit/rubber_band.gif)

### Dealing with safe area:
*EKAttributes.PositionConstraints.SafeArea* may be used to override the safe area with the entry's content, or to fill the safe area with a background color (like [Toasts](https://github.com/huri000/assets/blob/master/swift-entrykit/toasts.gif) do), or even leave the safe area empty (Like [Floats](https://github.com/huri000/assets/blob/master/swift-entrykit/floats.gif) do).

SwiftEntryKit supports iOS 11.x.y and is backward compatible to iOS 9.x.y, so the status bar area is treated as same as the safe area in earlier iOS versions.

### Dealing with orientation change:
SwiftEntryKit identifies orientation changes and adjust the entry's layout to those changes.
Therefore, if you wish to limit the entries's width, you are able to do so by giving it a maximum value, likewise:

```Swift
var attributes = EKAttributes.topFloat

// Give the entry the width of the screen minus 20pts from each side, the height is decided by the content's contraint's
attributes.positionConstraints.size = .init(width: .offset(value: 20), height: .intrinsic)

// Give the entry maximum width of the screen minimum edge - thus the entry won't grow much when the device orientation changes from portrait to landscape mode.
let edgeWidth = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height)
attributes.positionConstraints.maxSize = .init(width: .constant(value: edgeWidth), height: .intrinsic)

let customView = UIView()
/*
... Customize the view as you like ...
*/

// Use class method of SwiftEntryKit to display the view using the desired attributes
SwiftEntryKit.display(entry: customView, using: attributes)
```

Orientation Change Demonstration |
--- |
![orientation_change](https://github.com/huri000/assets/blob/master/swift-entrykit/orientation.gif)

## Known Issues

**Unable to find specification for SwiftEntryKit (=X.Y.Z)** - In case you get this error please review [this thread](https://github.com/huri000/SwiftEntryKit/issues/4).

## Author

Daniel Huri, huri000@gmail.com

## Credits

[**Icons Credits**](/CREDITS.md)

## License

SwiftEntryKit is available under the MIT license. See the [LICENSE](/LICENSE) file for more info.

### Exceptions
Please be aware that any use of the icons inside the project requires attribution to the creator. See [credits](/CREDITS.md) for the creators list.
