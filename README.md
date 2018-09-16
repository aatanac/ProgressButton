# ProgressButton

[![CI Status](https://img.shields.io/travis/aatanac/ProgressButton.svg?style=flat)](https://travis-ci.org/aatanac/ProgressButton)
[![Version](https://img.shields.io/cocoapods/v/ProgressButton.svg?style=flat)](https://cocoapods.org/pods/ProgressButton)
[![License](https://img.shields.io/cocoapods/l/ProgressButton.svg?style=flat)](https://cocoapods.org/pods/ProgressButton)
[![Platform](https://img.shields.io/cocoapods/p/ProgressButton.svg?style=flat)](https://cocoapods.org/pods/ProgressButton)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

Because of current error in Cocoapod please insert this chunk of code if you want to use IBDesignable.
https://github.com/CocoaPods/CocoaPods/issues/7606#issuecomment-381279098

```ruby
post_install do |installer|
    installer.pods_project.build_configurations.each do |config|          
      config.build_settings.delete('CODE_SIGNING_ALLOWED')
      config.build_settings.delete('CODE_SIGNING_REQUIRED')
    end
end
```

## Installation

ProgressButton is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'ProgressButton'
```

## Author

aatanac, aatanac@gmail.com

## License

ProgressButton is available under the MIT license. See the LICENSE file for more info.
