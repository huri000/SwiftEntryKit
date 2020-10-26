# Change Log
Any notable changes to this project will be documented in this file.

## 1.2.6

### Features

https://github.com/huri000/SwiftEntryKit/pull/307

### Fixes

Setting key window correctly:
See https://github.com/huri000/SwiftEntryKit/issues/308 and https://github.com/huri000/SwiftEntryKit/pull/309.

## 1.2.5

### Accessibility

- https://github.com/huri000/SwiftEntryKit/issues/222
- https://github.com/huri000/SwiftEntryKit/issues/294

## 1.2.4

### Fixes
- Remove scene from window: https://github.com/huri000/SwiftEntryKit/pull/299
- Added size option for EKRatingSymbolsContainerView: https://github.com/huri000/SwiftEntryKit/pull/266
- Access the foreground active window using connectedScenes: https://github.com/huri000/SwiftEntryKit/pull/257

### Chore
- Fix CI: https://github.com/huri000/SwiftEntryKit/pull/300

## 1.2.3
Fix #253 - force unwrap for `EKMessageContentView`'s `subtitleContent` when `nil` is provided.

## 1.2.1
Expose `EKWindow` publicly as `UIWindow`.
Add a warning for misuse of `EKAttributes.PopBehavior`.

## 1.2.0
Adjustment for iOS projects are are using `SwiftUI` as their default setup in their `plist`.


## 1.1.4
Fixes: #231 (iPad + iOS13) entries background is not interactable. 

## 1.1.3
Fix `SPM` release

## 1.1.2
Fix: `EKTextField` crashes once no `tintColor` is provided.  

## 1.1.1
iOS 13 color fix

## 1.1.0

### Support dark mode  (breaking change)
Fully support dark mode pre iOS 13. New requirments were introduced:
- `UIColor` was replaced with `EKColor` to allow specifying colors for light and dark modes.
- `UIBlurEffect.Style` was replacd with `EKAttributes.BackgroundStyle.BlurStyle` to allow specifying visual effects for light and dark modes.
- `EKAttributes` contains a new attribute named `displayMode: DisplayMode`. `displayMode` has the default value `.inferred`, which means that the display mode will be inferred from the user interface style. If the running iOS version is lower than 13, the display mode will be inferred as light mode.
- All the presets support the new display mode by allowing to specify `displayMode` for their `EKProperty`

The list of `EKProperty` constructs that contain `displayMode`: 
- `ButtonContent` - button descriptor
- `LabelStyle` - label style descriptor
- `ImageContent` - image view descriptor
- `TextFieldContent` - text field descriptor
- `ButtonBarContent`  - button bar descriptor

### Revamp coding style
The project coding style was revamped to be more friendly and readable.

## 1.0.4

### Issues:
- #191 - customized components support accessibility.

## 1.0.2

### Issues: 
- #187 - ButtonBarContent` initialized with multiple buttons received as either variadic parameter or array.

## 1.0.1

### Bug Fixes:

#### #171
[Issue #171](https://github.com/huri000/SwiftEntryKit/issues/171) - Unable to dismiss a ViewControllerEntry in Xcode 10.2 (work in Xcode 10.1).
Diagnosis: 
Only on Xcode 10.2. Probably be a Swift compiler bug. 
Reproduced using Release configuration. 
The compiler mistreats `UserInteraction.isResponsive` thus it always returns `false` when used on `attributes.screenInteraction`.

## 1.0.0

Swift 5 / Xcode 10.2 compatible.

## 0.8.9

### Features:

#### #155 
[Issue #155](https://github.com/huri000/SwiftEntryKit/issues/155) - Setting textfield cursor color for EKProperty.TextFieldContent.

`TextFieldContent` receives `tintColor` from now on.

#### #160
[Issue #160](https://github.com/huri000/SwiftEntryKit/issues/160) - Animation with sequence of images

From now on developers are able to sequence-animate and transform-animate every image within the presets using one of the designated public initializers available for `EKProperty.ImageContent`.

## 0.8.8

### Bug Fixes:

#### #109
[Issue #109](https://github.com/huri000/SwiftEntryKit/issues/109) - StatusBar appareance when moving to another UIViewController. Added another tatus bar type - `.ignored`. Using this ignores the status bar when the entry enters/exits the screen.

#### #143
[Issue #143](https://github.com/huri000/SwiftEntryKit/issues/143) - Orientation incorrect when set to .portraitUpsideDown on iPhone. 
Changed `isRotationEnabled` to `Rotation` structure. 

```Swift
/** Rotation related position constraints */
public struct Rotation {

    /** Attributes of supported interface orientations */
    public enum SupportedInterfaceOrientation {

        /** Uses standard supported interface orientation (target specification in general settings) */
        case standard

        /** Supports all orinetations */
        case all
    }

    /** Autorotate the entry along with the device orientation */
    public var isEnabled: Bool

    /** The screen autorotates with accordance to this option */
    public var supportedInterfaceOrientations: SwiftEntryKit.EKAttributes.PositionConstraints.Rotation.SupportedInterfaceOrientation
}
```

#### Button Bar Horizontal Distribution Threshold
`EKProperty.ButtonBarContent` supports an upper horizontal threshold for its button distribution.
`EKProperty.ButtonBarContent` has an `Int` property named `horizontalDistributionThreshold`. It must be positive.

## 0.8.7

### Bug Fixes:

[Issue #117](https://github.com/huri000/SwiftEntryKit/issues/117) - Round buttons in alert.

## 0.8.6
[Issue #121](https://github.com/huri000/SwiftEntryKit/issues/121) - Long title for alert buttons.

## 0.8.4

### Bug Fixes:
[Issue #131](https://github.com/huri000/SwiftEntryKit/issues/131) - `EKAttributes.PositionConstraints` initializer parameter isn't referenced in implementation.

## 0.8.3

### Bug Fixes:
[Issue #132](https://github.com/huri000/SwiftEntryKit/issues/132) - Background dimmed view is NOT animating.

## 0.8.2

### Bug Fixes:
[Issue #119](https://github.com/huri000/SwiftEntryKit/issues/119) - Entry tap gesture doesn't cancel touches inside the entry view. 

## 0.8.1

Apply a necessary fix for Xcode 10 and older than 4.2 Swift version compatibility.

## 0.8.0

### Enhancements

Adjustments for Swift 4.2. 

Related Issue: [Swift 4.2 Support #108](https://github.com/huri000/SwiftEntryKit/issues/108)

## 0.7.2

### Bug Fixes

[numberOfLines property #111](https://github.com/huri000/SwiftEntryKit/issues/111) - Allow multiple lines in image notes.

## 0.7.1

### Feature - Add a way to make a specific text field first responder in `EKFormMessageView`

Related issue: [Best way to present keyboard #107](https://github.com/huri000/SwiftEntryKit/issues/107).
The window must be a key window, so setting `presentInsideKeyWindow` to `true` is necessary to achieve that goal. Likewise:

```Swift
SwiftEntryKit.display(entry: formMessageView, using: attributes, presentInsideKeyWindow: true)
```

It is recommended to set `lifecycleEvents.didAppear` to  perform the keyboard showing action. For example:

```Swift
attributes.lifecycleEvents.didAppear = {
    formMessageView.becomeFirstResponder(with: 0)
}
```

## 0.7.0

### Feature - Queue of Entries

`displayPriority` is no longer nested inside `EKAttributes`. It has been replaced by another construct called `precedence`.
`precedence` defines the manner in which a new entry is treated in case there already is another displayed entry. 

- See [Issue #103](https://github.com/huri000/SwiftEntryKit/issues/103) for feature basic requirements.
- Please review the README.md and the API documentation to gain additional information.

#### Backward Compatibility

Be aware that `0.7.0` breaks previous releases.
In order to adjust previous usage to current behavior, just replace any instance of:

```Swift
attributes.displayPriority = value
````
To the following:

```Swift
attributes.precedence = .override(priority: value, dropEnqueuedEntries: false)
````

## 0.6.1

### Adjustments for Xcode 10.

## 0.6.0

### Autorotation flag for entries - [pull-request](https://github.com/huri000/SwiftEntryKit/pull/80)
### Additional documentation in README.md.

## 0.5.9

### Issue [#85](https://github.com/huri000/SwiftEntryKit/pull/86)
Lifecycle event `willDisappear` does not get called on swipe and prompt removeal of entry.

## 0.5.8

### Issues Resolved:

#### Allow injecting content into text field in form entry preset
[How to set the value (not placeholder) to textfield for Forms preset? #79](https://github.com/huri000/SwiftEntryKit/issues/79)

To support text injection to `EKTextField`, some minor changes have been done:
1. `EKTextField`'s `text` property has a setter now.
2. `TextFieldContent`'s `output` has been changed to `textContent` and has a setter now.
3. `outputWrapper` - changed to `contentWrapper`.

## 0.5.7

### Changes:

Dismiss entries using `touchesEnded` instead of `touchesBegan`. 

### Issues Fixed

[Deployment target is 9.3, not 9.0 #78](https://github.com/huri000/SwiftEntryKit/issues/78)

## 0.5.6

### Bug Fixes:

[App freezes on iOS 9.3.2 when displaying an entry and there is one shown already #73](https://github.com/huri000/SwiftEntryKit/issues/73)

## 0.5.5

### Bug Fix

#### Status Bar Visibility
Status bar visibility using a view controller based status bar appearance

### Improvements

#### Entry Name
Entry can have a name. That property can be optionally set.
Also,  `SwiftEntryKit` is added a new method:

```Swift 
public class func isCurrentlyDisplaying(entryNamed name: String? = default) -> Bool
````

It can be used to inquire if a certain entry is currently displayed. 
It might prove helpful to troubleshoot some issues using it, and it also a boilerplate for future developments.

## 0.5.4

### Changes

#### Status Bar Style Appearance 
SwiftEntryKit supports applications that defines status bar behaviour that is based on the presented view controller. The related [issue](https://github.com/huri000/SwiftEntryKit/issues/66).

#### Key Window
Setting the entry window is key is not the default behavior anymore. The API 
`public class func display(entry view: UIView, using attributes: EKAttributes, presentInsideKeyWindow: Bool = default, rollbackWindow: RollbackWindow = default)`
`public class func display(entry viewController: UIViewController, using attributes: EKAttributes, presentInsideKeyWindow: Bool = default, rollbackWindow: RollbackWindow = default)`

#### Visual Effect View Mask (Entry Background)
Performed only when really needed

## 0.5.3

### Feature:
- [EKNotificationMessage has broken layout #64](https://github.com/huri000/SwiftEntryKit/issues/64) - Add margins to `EKNotificationMessage`.

### Bug Fixes:
- Animations of alert and EKRatingMessageView.
- Constraints conflict in EKRatingMessageView

## 0.5.2

### Bug Fixes:
- [iPhone X issue with presenting Alert right after previous was closed #62](https://github.com/huri000/SwiftEntryKit/issues/62)

## 0.5.1

Rollback window bug fix

## 0.5.0

### Features

Handled the issue *[Exclude keyWindow occupancy #56](https://github.com/huri000/SwiftEntryKit/issues/56)* by adding an additional parameter `rollbackWindow` to `SwiftEntryKit.display` methods.

The  revised interface is as follows:

`public class func display(entry view: UIView, using attributes: EKAttributes, rollbackWindow: UIWindow = default)`
`public class func display(entry viewController: UIViewController, using attributes: EKAttributes, rollbackWindow: UIWindow = default)`

After the entry has been dismissed, SwiftEntryKit rolls back to the given window value. By default it is the application key window.

## 0.4.3

### Bug Fixes

- [Shadow won't work with round corners #55](https://github.com/huri000/SwiftEntryKit/issues/55)
- Small fix related to `EKRatingMessageView` initial presentation.

## 0.4.2

### Features

[Feature request: Callback when presented and dismissed #50](https://github.com/huri000/SwiftEntryKit/issues/50)

- Added a `LifecycleEvents` construct to `EKAttributes`. It contains the following optional callbacks: willAppear, didAppear, willDisappear, didDisappear for the currently displayed entry.
- Added an optional completion handler for `SwiftEntryKit`'s `dismiss` method.

## 0.4.1

### Issues Handled

[Keep Background Unchanged when 2 Consecutive Entry Screen Backgrounds Match #46](https://github.com/huri000/SwiftEntryKit/issues/46)

## 0.4.0

### Features

#### [Use UIViewController as an entry #40](https://github.com/huri000/SwiftEntryKit/issues/40)
Developers can now use a customized view controller as an entry.
A sample has been added to the custom presets section in example project.

## 0.3.3

### Issues Handled:
* [Multiple button support? #19](https://github.com/huri000/SwiftEntryKit/issues/19)

### Changes:

EKButtonBarView exposes `func expand()`, it

## 0.3.2

### Bug Fixes

* [EKAlertMessageView fail to layout all of the ButtonContents inside EKAlertMessage #41](https://github.com/huri000/SwiftEntryKit/issues/41)

## 0.3.1

### Features

* Alert & Notification Entries are image-less as well. The image parameter is optional, in case it has a `nil` value, the entry is generated without it.
* Added `numberOfLines` to `EKProperty.LabelStyle`. 

## 0.3.0

### Bug Fixes

#### Typos
`EKAttributes.PositionConstraints.SafeArea.isOverriden` to `EKAttributes.PositionConstraints.SafeArea.isOverridden`
`EKAttributes.PositionConstraints.SafeArea.overriden` to `EKAttributes.PositionConstraints.SafeArea.overridden`

### Features

#### Added an entry transform feature (ALPHA FEATURE)

Developers are able to transform an entry to another entry using the same attributes.

```Swift
let view = UIView()
// Customize
SwiftEntryKit.transform(to: view)
```

#### Rating Popup 

Added a rating popup (See custom presets).
See also: `EKRatingMessage` and `EKRatingMessageView`


### Other Changes:

#### Image-less popups

`EKPopUpMessage` can be image-less by simply setting `themeImage` to `nil` (or leaving its default value as is).

```Swift
/** Popup theme image */
public struct ThemeImage {

    /** Position of the theme image */
    public enum Position {
        case topToTop(offset: CGFloat)
        case centerToTop(offset: CGFloat)
    }

    /** The content of the image */
    public var image: EKProperty.ImageContent

    /** The psotion of the image */
    public var position: Position
}

public init(themeImage: ThemeImage? = default, title: EKProperty.LabelContent, description: EKProperty.LabelContent, button: EKProperty.ButtonContent, action: @escaping EKPopUpMessageAction)
```

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
