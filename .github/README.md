![Combinative](https://github.com/noppefoxwolf/Combinative/blob/master/Resource/Logo.png)

## Description

**Combinative** is library for UI event handling using Apple's combine framework.
It not need some big dependencies because using built in framework.
And, You can use great apple's combine operators with UIKit.

## Usage

### UIButton

```swift
let button = UIButton()
button.cmb.tap.sink { (button) in
  // do something
}
```

### UITextField

```swift
@IBOutlet weak var textField: UITextField!

textField.cmb.text.sink { (text) in
  print(text)
}
```

## Requirements

Xcode Beta 11.0

Swift 5.1

iOS13+

## Installation

### Swift Package Manager

**Combinative** is available through [Swift Package Manager](https://github.com/apple/swift-package-manager). To install
it, simply add the following line to your Package.swift:

```swift
let package = Package(
  dependencies: [
    .package(url: "https://github.com/noppefoxwolf/Combinative.git", branch: "master"),
  ],
)
```

## Author

- [noppefoxwolf](http://twitter.com/noppefoxwolf)

## Contributing

We would love you to contribute to **Combinative**, check the [CONTRIBUTING](https://github.com/noppefoxwolf/Combinative/blob/master/CONTRIBUTING.md) file for more info.


## License

**Combinative** is available under the MIT license. See the [LICENSE](https://github.com/noppefoxwolf/Combinative/blob/master/LICENSE.md) file for more info.
