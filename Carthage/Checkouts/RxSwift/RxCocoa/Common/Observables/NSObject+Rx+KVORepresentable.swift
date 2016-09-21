//
//  NSObject+Rx+KVORepresentable.swift
//  Rx
//
//  Created by Krunoslav Zaher on 11/14/15.
//  Copyright © 2015 Krunoslav Zaher. All rights reserved.
//

import Foundation
#if !RX_NO_MODULE
    import RxSwift
#endif

extension Reactive where Base: NSObject {

    /**
     Specialization of generic `observe` method.

     This is a special overload because to observe values of some type (for example `Int`), first values of KVO type
     need to be observed (`NSNumber`), and then converted to result type.

     For more information take a look at `observe` method.
     */
    // @warn_unused_result(message:"http://git.io/rxs.uo")
    public func observe<E: KVORepresentable>(_ type: E.Type, _ keyPath: String, options: NSKeyValueObservingOptions = [.new, .initial], retainSelf: Bool = true) -> Observable<E?> {
        return observe(E.KVOType.self, keyPath, options: options, retainSelf: retainSelf)
            .map(E.init)
    }
}

#if !DISABLE_SWIZZLING
    // KVO
    extension Reactive where Base: NSObject {
        /**
        Specialization of generic `observeWeakly` method.

        For more information take a look at `observeWeakly` method.
        */
        // @warn_unused_result(message:"http://git.io/rxs.uo")
        public func observeWeakly<E: KVORepresentable>(_ type: E.Type, _ keyPath: String, options: NSKeyValueObservingOptions = [.new, .initial]) -> Observable<E?> {
            return observeWeakly(E.KVOType.self, keyPath, options: options)
                .map(E.init)
        }
    }
#endif
