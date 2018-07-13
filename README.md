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
    MySectionOfCustomData(header: "Fuits", items: [MyCustomData(name: "Banana", selected: false), MyCustomData(name: "Apple", selected: false), MyCustomData(name: "Pear", selected: false), MyCustomData(name: "Orange", selected: false), MyCustomData(name: "Peach", selected: false), MyCustomData(name: "Lemon", selected: false)  ]),
    MySectionOfCustomData(header: "Vegetables", items: [MyCustomData(name: "Tomato", selected: false), MyCustomData(name: "Onion", selected: false), MyCustomData(name: "Carrot", selected: false), MyCustomData(name: "Lettuce", selected: false), MyCustomData(name: "Potatoes", selected: false), MyCustomData(name: "Broccoli", selected: false), MyCustomData(name: "Peas", selected: false), MyCustomData(name: "Pumpkin", selected: false), MyCustomData(name: "Pepper", selected: false), MyCustomData(name: "Eggplant", selected: false), MyCustomData(name: "Cucumber", selected: false), MyCustomData(name: "Mushroom", selected: false)]),
    MySectionOfCustomData(header: "Dairy Products", items: [MyCustomData(name: "Milk", selected: false), MyCustomData(name: "Cheese", selected: false), MyCustomData(name: "Yogurts", selected: false), MyCustomData(name: "Butter", selected: false), MyCustomData(name: "Cream", selected: false)]),
    MySectionOfCustomData(header: "Drinks", items: [MyCustomData(name: "Coke", selected: false), MyCustomData(name: "Wine", selected: false), MyCustomData(name: "Water", selected: false), MyCustomData(name: "Orange Juice", selected: false), MyCustomData(name: "Tea", selected: false), MyCustomData(name: "Beer", selected: false)])
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
