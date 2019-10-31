# WSDropdown

A simple way to display multiple selections on iOS.

![screenshot](https://github.com/yalcinozdemir/WSDropdown/blob/master/screenshots.gif?raw=true)

# Installation

1. Add `pod WSDropdown` to your Podfile.
2. Run `pod install`
3. Add `import WSDropdown` in classes where you want to display a dropdown.


Alternativaly, download source files and import into your project directly.


# Usage

Take a look at the WSDropdownExample project to learn how the dropdown can be implemented.

*WSDropdownButton* is a button to be place on your view to activate the dropdown.

```swift

let dropdownButton = WSDropdownButton()
dropdownButton.delegate = self
dropdownButton.setTitle("select here")
self.view.addSubview(dropdownButton)
```

Display dropdown when dropdown button is tapped by the user.

```swift

// MARK: DropdownButtonDelegate
    
func dropdownButtonTapped(_ sender: WSDropdownButton) {
  let dropdown = WSDropdown(attachedView: sender) // set a view to attach dropdown
  dropdown.width = 150 // set width according to your data
  dropdown.dropdownDelegate = self
  dropdown.options = ["Apple 🍎", "Cherry 🍒", "Banana 🍌", "Strawberry 🍓", "Tomato? 🍅", "Watermelon 🍉", "Kiwi 🥝", "Peach 🍑", "Grapes 🍇"] // set data to display on your dropdown 
  dropdownButton.dropdown = dropdown // assign a dropdown to your dropdown button.
  self.view.addSubview(dropdown)
}
```

*Take action after a selection is made on dropdown*
```swift

//MARK: DropdownDelegate
    
func optionSelected(dropdown: WSDropdown, option: String, index: Int) {
  // take action
}
```



