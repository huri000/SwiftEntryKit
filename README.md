# SwiftEntryKit

[![Platform](http://img.shields.io/badge/platform-iOS-blue.svg?style=flat)](https://developer.apple.com/iphone/index.action)
[![Language](http://img.shields.io/badge/language-Swift-brightgreen.svg?style=flat)](https://developer.apple.com/swift)
[![License](http://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat)](http://mit-license.org)

THIS LIBRARY IS CURRENTLY WIP...

SwiftEntryKit is a pop-up/banner presenter library for iOS.

## Features
- **Entry Position** - Entries can be displayed at the top or the bottom of the screen.
- **Presets** - SwiftEntryKit offers various beautiful entry presets that can be themed with your app colors and fonts.
- **Entries are highly customizable**
  - Entries can have a border, drop-shadow and round corners.
  - Entries background can be blurred, colorred or a gradient style.
  - The screen background can be dimmed.
  - Entries push and pop animations the can be customized.
  - User interaction with the entry or the screen can dismiss the entry or be ignored and pass forward  to the application window.
- **Status Bar** - Status bar style can be replaced once the entry shows and gets it's previous style again when the entry animates out.
- **Haptic Feedback** - Automatically supported (with device restrictions).
- **Screen Transitions** - The entries are displayed in a designated UIWindow above the application window (The window level is customizable as well), so the user can navigate the app freely while entries are being displayed.
- **Custom Views** Supports custom views / programmatically initialized views / nib initialized views.

## Example

Taken from the Example project, here are some presets and abilities that can be used.

Toasts | Notes | Floats | Custom Message | Custom Nib
--- | --- | --- | --- | ---
![demo_01](https://github.com/huri000/SwiftEntryKit/blob/master/Example/Assets/toasts.gif) | ![demo_02](https://github.com/huri000/SwiftEntryKit/blob/master/Example/Assets/notes.gif) | ![demo_03](https://github.com/huri000/SwiftEntryKit/blob/master/Example/Assets/floats.gif) | ![demo_04](https://github.com/huri000/SwiftEntryKit/blob/master/Example/Assets/animated_custom.gif) | ![demo_05](https://github.com/huri000/SwiftEntryKit/blob/master/Example/Assets/custom_nib.gif)

The example project contains a Playground in which you can investigate preferable displays of entries.

### Playground - noun: a place where people can play :-)

The example app contains a playground screen - an interface that enable you to customize and create entries.
the playground screen has some limitations but you can easily modify the internal logic to suit your needs.


Here are some playground samples:

Screen | Top Float | Bottom Float
--- | --- | ---
![demo_01](https://github.com/huri000/SwiftEntryKit/blob/master/Example/Assets/playground.gif) | ![demo_02](https://github.com/huri000/SwiftEntryKit/blob/master/Example/Assets/playground_top.jpeg) | ![demo_03](https://github.com/huri000/SwiftEntryKit/blob/master/Example/Assets/playground_bottom.jpeg)


To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

The library has not been tested with iOS 8 or lower.

## Installation

This library is still WIP and will be formally released very soon.

## Usage

### Basic usage:

```Swift
// Create a basic toast that appears at the top
let attributes = EKAttributes.topToast

// Set it's background to white
attributes.entryBackground = .color(color: .white)

// Animate in with 0.3s duration using translation and scale
attributes.entranceAnimation = .init(duration: 0.3, types: [.translate, .scale(from: 0.5, to: 1)])

// Animate out using translation only
attributes.exitAnimation = .translation

let contentView = UIView()
/*
... Customize to view as you like (See example project for more info)
*/

// Change the state of EKWindowProvider to .message and inject the contentView and the attributes
EKWindowProvider.shared.state = .message(view: contentView, attributes: attributes)
```

### Using SwiftEntryKit's presets - an example:

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

// Show contentView
EKWindowProvider.shared.state = .message(view: contentView, attributes: attributes)
```

### How to deal with orientation change:

For example - create a top floating entry, And set it's width to be offset of 20pts from the screen width.
In order to limit the view's width, you can give it maximum width, likewise:

```Swift
let attributes = EKAttributes.topFloat
attributes.positionConstraints.width = .offset(value: 20)

let maxWidth = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height)
attributes.positionConstraints.maximumWidth = .constant(value: maxWidth)

let contentView = UIView()
/*
... Customize to view as you like (See example project for more info)
*/

// Change the state of EKWindowProvider to .message and inject the contentView and the attributes
EKWindowProvider.shared.state = .message(view: contentView, attributes: attributes)
```

Oriantation Change Demonstration |
--- |
![demo_01](https://github.com/huri000/SwiftEntryKit/blob/master/Example/Assets/orientation.gif)


## Author

Daniel Huri, huri000@gmail.com

## License

SwiftEntryKit is available under the MIT license. See the LICENSE file for more info.
