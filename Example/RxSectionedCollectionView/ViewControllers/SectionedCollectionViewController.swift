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
    
    let disposeBag = DisposeBag()
    
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
        sectionedCollectionView.setupView()
        
        let sections = [
            MySectionOfCustomData(header: "Management", items: [MyCustomData(name: "FOH management", selected: false), MyCustomData(name: "Bar management", selected: false), MyCustomData(name: "Kitchen management", selected: false), MyCustomData(name: "Baking management", selected: false) ]),
            MySectionOfCustomData(header: "Front of house", items: [MyCustomData(name: "Bartending", selected: false), MyCustomData(name: "Barista", selected: false), MyCustomData(name: "Serving", selected: false), MyCustomData(name: "Host/Hostess", selected: false), MyCustomData(name: "Sommelier", selected: false), MyCustomData(name: "Cashier", selected: false), MyCustomData(name: "Bar backing", selected: false), MyCustomData(name: "Bussing", selected: false), MyCustomData(name: "Bouncer or security", selected: false), MyCustomData(name: "Coat check", selected: false), MyCustomData(name: "Expo / Food runner", selected: false), MyCustomData(name: "Garde manger / salad", selected: false)]),
            MySectionOfCustomData(header: "Back of house", items: [MyCustomData(name: "Prepping", selected: false), MyCustomData(name: "Hot line cook", selected: false), MyCustomData(name: "Pastry", selected: false), MyCustomData(name: "Baking", selected: false), MyCustomData(name: "Sushi", selected: false), MyCustomData(name: "Dishwashing", selected: false)])
        ]
        
        Observable.just(sections)
            .bind(to: sectionedCollectionView.rx.items)
            .disposed(by: disposeBag)
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
    }
    
}
