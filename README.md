# Combinative

## Description

**Combinative** is library for UI event handling using Apple's combine framework.
It not need some big dependencies because using built in framework.
And, You can use great apple's combine operators with UIKit.

## Usage

### UIButton

```
let button = UIButton()
button.cmb.tap.sink { (button) in
  // do something
}
```

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
