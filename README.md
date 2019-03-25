
# Bitcoin Converter

A simple POC app for showing the Cryptocurrency Bitcoin exchange rates for USD, EUR and GBP

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. 

### Prerequisites

Cocoapods are ignored in the .gitignore file, please run pod install before building

```
pod install
```

### Installing

Run the app using Xcode on a simulator or a real device, the app hosts an exchange history list for Bitcoin in EUR and a detail screen showing the rates in EUR, USD and GBP along with a Today Widget showing the current EUR exchange rate



## Running the tests

There are a couple of Unit Tests just for proving the concept, Dependency Injection can be used to Mock the Client protocol but the current tests are just for POC


## Built With

* [Alamofire](https://github.com/Alamofire/Alamofire) - For establishing network requests
* [EVReflection](https://github.com/evermeer/EVReflection) - For parsing JSON responses to Objects
* [ReactiveKit](https://github.com/DeclarativeHub/ReactiveKit) - For Reactive Programming and introducing MVVM

