//
//  SectionedCollectionViewController.swift
//  SectionedCollectionView
//
//  Created by Esteban Arrua on 6/7/18.
//  Copyright © 2018 Hattrick. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import SectionedCollectionView
import RxSectionedCollectionView

class SectionedCollectionViewController: UIViewController {
    
    @IBOutlet weak var sectionedCollectionView: SectionedCollectionView!
    @IBOutlet weak var reloadButton: UIButton!
    
    let disposeBag = DisposeBag()
    
    let sections = [
        MySectionOfCustomData(header: "Fuits", items: [MyCustomData(name: "Banana", selected: false), MyCustomData(name: "Apple", selected: false), MyCustomData(name: "Pear", selected: false), MyCustomData(name: "Orange", selected: false), MyCustomData(name: "Peach", selected: false), MyCustomData(name: "Lemon", selected: false)  ]),
        MySectionOfCustomData(header: "Vegetables", items: [MyCustomData(name: "Tomato", selected: false), MyCustomData(name: "Onion", selected: false), MyCustomData(name: "Carrot", selected: false), MyCustomData(name: "Lettuce", selected: false), MyCustomData(name: "Potatoes", selected: false), MyCustomData(name: "Broccoli", selected: false), MyCustomData(name: "Peas", selected: false), MyCustomData(name: "Pumpkin", selected: false), MyCustomData(name: "Pepper", selected: false), MyCustomData(name: "Eggplant", selected: false), MyCustomData(name: "Cucumber", selected: false), MyCustomData(name: "Mushroom", selected: false)]),
        MySectionOfCustomData(header: "Dairy Products", items: [MyCustomData(name: "Milk", selected: false), MyCustomData(name: "Cheese", selected: false), MyCustomData(name: "Yogurts", selected: false), MyCustomData(name: "Butter", selected: false), MyCustomData(name: "Cream", selected: false)]),
        MySectionOfCustomData(header: "Drinks", items: [MyCustomData(name: "Coke", selected: false), MyCustomData(name: "Wine", selected: false), MyCustomData(name: "Water", selected: false), MyCustomData(name: "Orange Juice", selected: false), MyCustomData(name: "Tea", selected: false), MyCustomData(name: "Beer", selected: false)])
    ]
    
    // MARK: - Lifecycle methods
    
    init() {
        super.init(nibName: String(describing: type(of: self)), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(code:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSectionedCollectionView()
        setupBindings()
    }
    
    fileprivate func setupSectionedCollectionView() {
        sectionedCollectionView.settings.viewCells.itemCollectionViewCellNibName = CustomItemCollectionViewCell.nibName
        sectionedCollectionView.settings.viewCells.itemCollectionViewCellReuseIdentifier = CustomItemCollectionViewCell.cellReuseIdentifier
        sectionedCollectionView.settings.viewCells.headerViewCellNibName = HeaderViewCell.nibName
        sectionedCollectionView.settings.viewCells.headerViewCellReuseIdentifier = HeaderViewCell.cellReuseIdentifier
        sectionedCollectionView.settings.viewCells.footerViewCellNibName = FooterViewCell.nibName
        sectionedCollectionView.settings.viewCells.footerViewCellReuseIdentifier = FooterViewCell.cellReuseIdentifier
        sectionedCollectionView.settings.data.selectedLimit = 5
        sectionedCollectionView.settings.style.scrollEnabled = false
        sectionedCollectionView.setupView()
        
        Observable.just(sections)
            .bind(to: self.sectionedCollectionView.rx.items)
            .disposed(by: self.disposeBag)
        
        // In this way we can select items programtically
        let indexes = [IndexPath(row: 0, section: 2), IndexPath(row: 0, section: 0), IndexPath(row: 2, section: 0)]
        Observable.just(indexes)
            .bind(to: self.sectionedCollectionView.rx.selectItems)
            .disposed(by: self.disposeBag)
    }
    
    fileprivate func setupBindings() {
        let selectedItems: Observable<[MyCustomData]> = sectionedCollectionView.rx.selectedItems()
        selectedItems.subscribe(onNext: { selected in
            print(selected)
        }).disposed(by: disposeBag)
        
        sectionedCollectionView.rx.limitReached
            .subscribe(onNext: { _ in
                print("Limit Reached")
            }).disposed(by: disposeBag)
        
        reloadButton.rx.tap
            .map { [weak self] _ in self?.sections ?? []}
            .bind(to: sectionedCollectionView.rx.items)
            .disposed(by: disposeBag)
    }
    
}
