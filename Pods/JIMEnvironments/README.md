# JIMEnvironments

A simple solution to handle environment specific settings. It uses the current `Build Configuration` name to retrieve settings from a `Plist` file.

## Installation

Via CocoaPods

```ruby
pod "JIMEnvironments", "~> 1.0.0"
```

Or, just drag the class files into your project, also the `Environments.plist` file, there's no need to create an instance of it, it's a self-instantiating singleton.

## Setup

1. Add a new row to your `Info.plist` application file.
2. Set this key `JIMEnvironmentsTargetBuildConfigurationName` and this value `$(CONFIGURATION)`.
3. Create a new `Plist` file into your project, name it as `Environments`.
4. Per default, `Xcode` creates two build configurations, `Debug` and `Release`, so add two dictionaries, one for `Debug` and one for `Release`.

## Plist Example

```plist
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>Debug</key>
	<dict>
	    <key>ApiUrl</key>
        <string>https://dev.example.com/api</string>
	</dict>
	<key>Release</key>
	<dict>
        <key>ApiUrl</key>
		<string>https://production.example.com/api</string>
	</dict>
</dict>
</plist>
```

## Usage

Add as many keys you want for each build configuration dictionary, then, you can access each one this way:

```objc
[JIMEnvironments sharedInstance].environment[@"ApiUrl"]
```
