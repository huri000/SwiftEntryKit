# SwiftEntryKit <img align="left" src="https://github.com/huri000/assets/blob/master/swift-entrykit/project-icon.png">
[![Platform](http://img.shields.io/badge/platform-iOS-blue.svg?style=flat)](https://developer.apple.com/iphone/index.action)
[![Language](http://img.shields.io/badge/language-Swift-brightgreen.svg?style=flat)](https://developer.apple.com/swift)
[![License](http://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat)](http://mit-license.org)

* **[Overview](#overview)**
  * [Features](#features)
* **[Example Project](#example-project)**
  * [Presets](#presets)
  * [Playground](#playground)
* **[Requirements](#requirements)**
* **[Installation](#installation)**
* **[Usage](#usage)**
  * [EKAttributes](#ekattributes)
  * [Presets Usage Example](#presets-usage-example)
  * [Custom View Usage Example](#custom-view-usage-example)
  * [How to deal with the screen Safe Area](#how-to-deal-with-the-screen-safe-area)
  * [How to deal with orientation change](#how-to-deal-with-orientation-change)
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
  - [x] Entries have display priority attribute. That means that an entry cannot be dismissed by other entries with lower display priority.
  - [x] The status bar style is settable for the display duration of the entry.
  - [x] SwiftEntryKit supports [custom views](#custom-view-usage-example) as well.

## Example Project

The example project contains various presets and examples you can use and modify as your like.

### Presets

Toasts | Notes | Floats | Custom Message | Custom Nib
--- | --- | --- | --- | ---
![toasts_example](https://github.com/huri000/assets/blob/master/swift-entrykit/toasts.gif) | ![notes_example](https://github.com/huri000/assets/blob/master/swift-entrykit/notes.gif) | ![floats_example](https://github.com/huri000/assets/blob/master/swift-entrykit/floats.gif) | ![animated_custom_example](https://github.com/huri000/assets/blob/master/swift-entrykit/animated_custom.gif) | ![custom_nib_example](https://github.com/huri000/assets/blob/master/swift-entrykit/custom_nib.gif)


### Playground

#### noun: a place where people can play 🏈

The example app contains a playground screen, an interface that allows you to customize your preferable entries.
The playground screen has some limitations (allows to select constant values) but you can easily modify the code to suit your needs. Check it out!

Screen | Top Float | Bottom Float
--- | --- | ---
![playground_example](https://github.com/huri000/assets/blob/master/swift-entrykit/playground.gif) | ![play_1](https://github.com/huri000/assets/blob/master/swift-entrykit/playground_top.jpeg) | ![play2](https://github.com/huri000/assets/blob/master/swift-entrykit/playground_bottom.jpeg)

## Requirements

- iOS 9 or any higher version.
- Xcode 9 or any higher version.
- Swift 4.0 or any higher version.
- The library has not been tested with iOS 8 or a lower version.
- SwiftEntryKit leans heavily on [QuickLayout](https://github.com/huri000/QuickLayout) - A lightwight library written in Swift that is used to easily layout views programmatically.

## Installation

SwiftEntryKit is still WIP and will be formally released very soon.

## Usage

### EKAttributes:

*EKAttributes* is the entry's descriptor. Each time an entry is displayed, an EKAttributes object is necessary to describe the entry's presentation, position inside the screen, the display duration, it's frame constraints (if needed), it's styling (corners, border and shadow), the user interaction events, the animations (in / out) and more.

Below are most of the attributes that can be modified:

**Window Level** - The entry's window level. Can be above the application main window, above the status bar, above the alerts window or even have a custom level (UIWindowLevel).

**Display Position** - The entry can be displayed either at the top or the bottom of the screen.

**Display Priority** - The display priority of the entry determines whether it can dismiss other entries or be dismissed by them. An entry can be dismissed only by an enry with equal or higher display-priority.

**Display Duration** - The display duration of the entry (Counted from the moment the entry has finished the entrance animation).

**Position Constraints** - Constraints that tie the entry tightly to the screen contexts, for example: Height, Width, Max Width, Additional Vertical Offset & Safe Area related info.

**Background Style** - The entry and the screen can have various background styles, such as blur, color, gradient and even an image.

**User Interaction** - The entry and the screen can be interacted by the user. User interaction be can intercepted in various ways, such as: dismiss the entry, be ignored, pass the touch forward to the lower level window, and more.

**Shadow** - The shadow that surrounds the entry.

**Round Corners** - Round corners around the entry.

**Border** - The border around the entry.

**Entrance Animation** - Describes how the entry animates into the screen.

**Exit Animation** - Describes how the entry animates out of the screen.

**Pop Behavior** - Describes the entry behavior when it's being popped (dismissed by an entry with equal / higher display-priority.

**Scroll Behavior** - Describes the entry behavior when it's being scrolled, that is, dismissal by a swipe gesture and a rubber band effect similar to a UIScrollView.

**[Haptic Feedback](https://developer.apple.com/ios/human-interface-guidelines/user-interaction/feedback/)** - The device can produce a haptic feedback, thus adding an additional sensory depth to each entry.

**Status Bar Style** - The status bar style can be modified during the display of the entry. In order to enable this feature, set *View controller-based status bar appearance* to *NO* in your project's info.plist file.

EKAttributes' interface is as follows:

```Swift
public struct EKAttributes

    // Display
    public var windowLevel: WindowLevel
    public var position: Position
    public var displayPriority: DisplayPriority
    public var displayDuration: TimeInterval
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

```Swift
// Generate top note entry - located below the status bar.
let attributes = EKAttributes.topNote
attributes.entryBackground = .color(color: .white)

// Set dark status bar style as long as the entry shows
attributes.statusBarStyle = .default

// Set the style of the note
let text = "Doing some testing over here!"
let style = EKProperty.Label(font: UIFont.systemFont(ofSize: 14), color: .black)
let labelContent = EKProperty.LabelContent(text: text, style: style)

// Create the note view
let contentView = EKNoteMessageView(with: labelContent)

// Use class method of SwiftEntryKit to display the view using the desired attributes
SwiftEntryKit.display(entry: contentView, using: attributes)
```

### Custom View Usage Example:

```Swift
// Create a basic toast that appears at the top
let attributes = EKAttributes.topToast

// Set it's background to white
attributes.entryBackground = .color(color: .white)

// Animate in with 0.3s duration using translation and scale
attributes.entranceAnimation = .init(duration: 0.3, types: [.translate, .scale(from: 0.5, to: 1)])

// Animate out using translation only
attributes.exitAnimation = .translation

let customView = CustomView()
/*
... Customize the view as you like ...
*/

// Use class method of SwiftEntryKit to display the view using the desired attributes
SwiftEntryKit.display(entry: customView, using: attributes)
```

### Swipe Out & Rubber Band - Demonstration

Entries can be panned vertically (This ability can be enabled using the *scroll* attributes). 
Thefore it's only natural that an entry can be dismissed using a swipe-like gesture.
Entries behave like a rubber band once they are panned toward their opposite direction. Demonstration follows:

Swipe | Stretch
--- | ---
![swipe_example](https://github.com/huri000/assets/blob/master/swift-entrykit/swipe.gif) | ![band_example](https://github.com/huri000/assets/blob/master/swift-entrykit/rubber_band.gif)

### How to deal with the screen Safe Area:

*EKAttributes.PositionConstraints.SafeArea* may be used to override the safe area with the entry's content, or to fill the safe area with a background color (like [Toasts](https://github.com/huri000/assets/blob/master/swift-entrykit/toasts.gif) do), or even leave the safe area empty (Like [Floats](https://github.com/huri000/assets/blob/master/swift-entrykit/floats.gif) do).

SwiftEntryKit supports iOS 11.x.y and is backward compatible to iOS 9.x.y, so the status bar area is treated as same as the safe area in earlier iOS versions.

### How to deal with orientation change:

SwiftEntryKit identifies orientation changes and adjust the entry's layout to those changes.
Therefore, if you wish to limit the entries's width, you are able to do so by giving it a maximum value, likewise:

```Swift
let attributes = EKAttributes.topFloat

// Give the entry the width of the screen minus 20pts from each side.
attributes.positionConstraints.width = .offset(value: 20)

// Give the entry maximum width of the screen minimum edge - thus the entry won't grow much when the device orientation changes from portrait to landscape mode.
let maxWidth = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height)
attributes.positionConstraints.maximumWidth = .constant(value: maxWidth)

let customView = CustomView()
/*
... Customize the view as you like ...
*/

// Use class method of SwiftEntryKit to display the view using the desired attributes
SwiftEntryKit.display(entry: contentView, using: attributes)
```

Orientation Change Demonstration |
--- |
![orientation_change](https://github.com/huri000/assets/blob/master/swift-entrykit/orientation.gif)

## Known Issues

## Contributing

Forks, patches and other feedback will be available once the library is formally released and registered in CocoaPods.

## Author

Daniel Huri, huri000@gmail.com

## License

SwiftEntryKit is available under the MIT license. See the LICENSE file for more info.
