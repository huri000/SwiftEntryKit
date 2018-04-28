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

Toasts | Notes | Floats | Custom1 | Custom2
--- | --- | --- | --- | ---
![demo_01](https://github.com/huri000/SwiftEntryKit/blob/master/Example/Assets/toasts.gif) | ![demo_02](https://github.com/huri000/SwiftEntryKit/blob/master/Example/Assets/notes.gif) | ![demo_03](https://github.com/huri000/SwiftEntryKit/blob/master/Example/Assets/floats.gif) | ![demo_04](https://github.com/huri000/SwiftEntryKit/blob/master/Example/Assets/animated_custom.gif) | ![demo_05](https://github.com/huri000/SwiftEntryKit/blob/master/Example/Assets/custom_nib.gif)

The example project contains a Playground in which you can investigate preferable displays of entries.

# Playground - noun: a place where people can play :-)

The Playground | Top Float Example | Bottom Float Example
--- | --- | ---
![demo_01](https://github.com/huri000/SwiftEntryKit/blob/master/Example/Assets/playground.gif) | ![demo_02](https://github.com/huri000/SwiftEntryKit/blob/master/Example/Assets/playground_top.jpeg) | ![demo_03](https://github.com/huri000/SwiftEntryKit/blob/master/Example/Assets/playground_bottom.jpeg)

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

SwiftEntryKit is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'SwiftEntryKit'
```

## Author

huri000@gmail.com, huri000@gmail.com

## License

SwiftEntryKit is available under the MIT license. See the LICENSE file for more info.
