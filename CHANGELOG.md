# Change Log
Any notable changes to this project will be documented in this file.

## 0.2.4

### Features

### Explicit direction of translation animation
`EKAttributes.Animation.Translate` is added an `anchorPosition: AnchorPosition` property:

That means that an entry can translate from the top and exit from the bottom, and vice versa.

```Swift
/** Describes the anchor position */
public enum AnchorPosition {

    /** Top position - the entry shows from top or exits towards the top */
    case top

    /** Bottom position - the entry shows from bottom or exits towards the bottom */
    case bottom

    /** Automatic position - the entry shows and exits according to EKAttributes.Position value. If the position of the entry is top, bottom, the entry's translation anchor is top, bottom - respectively.*/
    case automatic
}
```

`anchorPosition` is determined the direction of the translation animation and is `.automatic` by default, meaning that the anchor is set automatically according to its position - if the position (`EKAttributes.Position`) is `.top` / `bottom`, then the entry enters and exit from the top / bottom edge.

## 0.2.3

### Features

#### Status bar revised
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
