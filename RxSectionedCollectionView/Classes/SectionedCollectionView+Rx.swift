//
//  SectionedCollectionView+Rx.swift
//  Pods-RxSectionedCollectionView_Example
//
//  Created by Esteban Arrua on 6/19/18.
//

import Foundation
import RxSwift
import RxCocoa
import SectionedCollectionView

extension Reactive where Base: SectionedCollectionView {
    
    public var delegate: DelegateProxy<SectionedCollectionView, SectionedCollectionViewDelegate> {
        return RxSectionedCollectionViewDelegateProxy.proxy(for: base)
    }
    
    public var items: Binder<[SectionOfCustomData]> {
        return Binder(self.base) { (view, sections) -> () in
            view.setDataSource(sections: sections)
        }
    }
    
    public func selectedItems<T: Selectable>() -> Observable<[T]> {
        return self.delegate.methodInvoked(#selector(SectionedCollectionViewDelegate.selectedItems(selected:)))
            .map{ a in
                guard let selected = a[0] as? [T] else {
                    return []
                }
                return selected
            }
    }
    
    public var limitReached: Observable<Void> {
        return self.delegate.methodInvoked(#selector(SectionedCollectionViewDelegate.limitReached))
            .map{ _ in
                return ()
            }
    }
    
}

extension SectionedCollectionView: HasDelegate {
    public typealias Delegate = SectionedCollectionViewDelegate
}

open class RxSectionedCollectionViewDelegateProxy: DelegateProxy<SectionedCollectionView, SectionedCollectionViewDelegate>, DelegateProxyType, SectionedCollectionViewDelegate {
    
    /// Typed parent object.
    public weak private(set) var sectionedCollectionView: SectionedCollectionView?
    
    /// - parameter tabBar: Parent object for delegate proxy.
    public init(sectionedCollectionView: ParentObject) {
        self.sectionedCollectionView = sectionedCollectionView
        super.init(parentObject: sectionedCollectionView, delegateProxy: RxSectionedCollectionViewDelegateProxy.self)
    }
    
    // Register known implementations
    public static func registerKnownImplementations() {
        self.register { RxSectionedCollectionViewDelegateProxy(sectionedCollectionView: $0) }
    }
    
}
