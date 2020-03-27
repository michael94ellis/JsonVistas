# Auto Layout Visual Format
---
## What is this?
The purpose of this project is to better understand Auto Layout Visual Format and to make it easier to use. Ironically this project is made in SwiftUI for macOS. This single page app creates Visual Format Strings that are only useful for what SwiftUI is intended to replace.

[Here is the Apple Auto-Layout Visual Format Documentation](https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/VisualFormatLanguage.html)


## Grammar of Visual Format Strings
---
### Each Visual Format String is comprised from the following syntax:

* Orientation
    * Optional, ignoring this implies horizontal
    * `H:` or `V:`
* Superview
    * `|` No hyphen suggests the view should touch the superview/container
    * `|-`, or `-|` A hyphen provides >=8 units of space away from the superview/container
* Connection
    * `-units@priority-` This will create a distance of the number of units at the given priority
* View
    * `(unique_id_string)` This will relate to a view of the same name, the id string should be unique
    
```
(<orientation>:)?(<superview><connection>)?<view>(<connection><view>)*(<connection><superview>)?
```
#### Replacement version of the former explanation:
* ? indicates 0 or 1 are allowed
* Asterisk(*) indicates 1 or more are necessary
* orientation: `H:`, `V:`
* superview: `|`
* connection: ``, `-`, `-(value)-`
* view: `(unique_string_id)`


## Error Handling
---
If you make a syntactic mistake, an exception is thrown with a diagnostic message. For example:
```
Expected ':' after 'V' to specify vertical arrangement
V|[backgroundBox]|
 ^
 
A predicate on a view's thickness must end with ')' and the view must end with ']'
|[whiteBox1][blackBox4(blackWidth][redBox]|
                                 ^
 
Unable to find view with name blackBox
|[whiteBox2][blackBox]
                     ^
 
Unknown relation. Must be ==, >=, or <=
V:|[blackBox4(>30)]|
               ^
```
