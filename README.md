# RxSectionedCollectionView

[![Version](https://img.shields.io/cocoapods/v/RxSectionedCollectionView.svg?style=flat)](https://cocoapods.org/pods/RxSectionedCollectionView)
[![License](https://img.shields.io/cocoapods/l/RxSectionedCollectionView.svg?style=flat)](https://cocoapods.org/pods/RxSectionedCollectionView)
[![Platform](https://img.shields.io/cocoapods/p/RxSectionedCollectionView.svg?style=flat)](https://cocoapods.org/pods/RxSectionedCollectionView)
![Swift 4.0](https://img.shields.io/badge/Swift-4.0.x-orange.svg)

## Usage 

This library is a reactive wrapper of the library [SectionedCollectionView](https://github.com/hattrick-it/SectionedCollectionView_Pod).

### Data Source 

```swift

let sections = [
    MySectionOfCustomData(header: "Management", items: [MyCustomData(name: "FOH management", selected: false), MyCustomData(name: "Bar management", selected: false), MyCustomData(name: "Kitchen management", selected: false), MyCustomData(name: "Baking management", selected: false) ]),
    MySectionOfCustomData(header: "Front of house", items: [MyCustomData(name: "Bartending", selected: false), MyCustomData(name: "Barista", selected: false), MyCustomData(name: "Serving", selected: false), MyCustomData(name: "Host/Hostess", selected: false), MyCustomData(name: "Sommelier", selected: false), MyCustomData(name: "Cashier", selected: false), MyCustomData(name: "Bar backing", selected: false), MyCustomData(name: "Bussing", selected: false), MyCustomData(name: "Bouncer or security", selected: false), MyCustomData(name: "Coat check", selected: false), MyCustomData(name: "Expo / Food runner", selected: false), MyCustomData(name: "Garde manger / salad", selected: false)]),
    MySectionOfCustomData(header: "Back of house", items: [MyCustomData(name: "Prepping", selected: false), MyCustomData(name: "Hot line cook", selected: false), MyCustomData(name: "Pastry", selected: false), MyCustomData(name: "Baking", selected: false), MyCustomData(name: "Sushi", selected: false), MyCustomData(name: "Dishwashing", selected: false)])
]

Observable.just(sections)
    .bind(to: sectionedCollectionView.rx.items)
    .disposed(by: disposeBag)

```

### Selected Items

To get the selected items you must subcribe to the `selectedItems` observable. 

```swift

let selectedItems: Observable<[MyCustomData]> = sectionedCollectionView.rx.selectedItems()
selectedItems.subscribe(onNext: { selected in
    //TODO: Implement that you want with the selected items. 
}).disposed(by: disposeBag)

```

Yo can subcribe to the `limitReached` observable to know when the user is trying to select an item but already reached the selection limit. 

```swift

sectionedCollectionView.rx.limitReached
    .subscribe(onNext: { _ in
        //TODO: Implement that you want when the limit is reached.
    }).disposed(by: disposeBag)

```

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

RxSectionedCollectionView is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'RxSectionedCollectionView'
```

## Author

estebanarrua, esteban.arrua@hattrick-it.com

## License

RxSectionedCollectionView is available under the MIT license. See the LICENSE file for more info.
