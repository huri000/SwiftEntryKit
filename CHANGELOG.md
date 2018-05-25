# Change Log
Any notable changes to this project will be documented in this file.

## 0.2.3

### Features

#### Status Bar Revised
* Instead of assigning the `UIStatusBarStyle`, use `EKAttributes.StatusBar` to define the status bar.
* The benefit is an absolute control over the status bar appearance.
* New statuses:
- `.hidden` - Hides the status bar.
-  `inferred` - Infer the style from the previous style.

## 0.2.2

### Features
Added Carthage Support

## 0.2.1

### Bug Fix
The text of the text-fields is accessible after tapping the button using `EKFormMessageView`. 
Use `output` property inside `EKProperty.TextFieldContent`.

## 0.2.0

### Features

#### Keyboard support
Keyboard support can be enabled using `EKAttributes.PositionConstraints.KeyboardRelation` enum.
```Swift
// 10pt bottom offset from keyboard and at least 5pts from the screen edge while the keyboard is displayed.
attributes.positionConstraints.keyboardRelation = .bind(offset: .init(bottom: 10, screenEdgeResistance: 5))
```

#### Is Displaying 

Inquire if SwiftEntryKit is currently displaying an entry:

```Swift
if SwiftEntryKit.isCurrentlyDisplaying {
    /* Do Something */
}
```

#### Naming

`EKProperty.LabelStyle` replaced `EKProperty.Label`.

