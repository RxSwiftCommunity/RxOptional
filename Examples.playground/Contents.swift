import RxSwift
import RxCocoa
import RxOptional

/*:
 Steps to Run
 
 - Run `pod install` in Example directory
 - Select RxOptional Examples target
 - Build
 - Show Debug Area (cmd+shift+Y)
 - Click blue play button in Debug Area
 
 */

public func example(description: String, action: Void -> Void) {
    print("\n--- \(description) example ---")
    action()
}

//: All operators are also available on `Driver`, unless otherwise noted.


//: ## Optionals

example("filterNil") {
    _ = Observable<String?>
        .of("One", nil, "Three")
        .filterNil()
        // Type is now Observable<String>
        .subscribe { print($0) }
}

example("replaceNilWith") {
    _ = Observable<String?>
        .of("One", nil, "Three")
        .replaceNilWith("Two")
        // Type is now Observable<String>
        .subscribe { print($0) }
}

#if !swift(>=3.3) || (swift(>=4.0) && !swift(>=4.1))
example("distinctUntilChanged") {
    _ = Observable<Int?>
        .of(5, 6, 6, nil, nil, 3)
        .distinctUntilChanged()
        .subscribe { print($0) }
}
#endif

/*:
 Unavailable on `Driver`, because `Driver`s cannot error out.
 
 By default, errors with `RxOptionalError.FoundNilWhileUnwrappingOptional`.
 */
example("errorOnNil") {
    _ = Observable<String?>
        .of("One", nil, "Three")
        .errorOnNil()
        // Type is now Observable<String>
        .subscribe { print($0) }
}

example("catchOnNil") {
    _ = Observable<String?>
        .of("One", nil, "Three")
        .catchOnNil {
            Observable<String>.just("A String from a new Observable")
        }
        // Type is now Observable<String>
        .subscribe { print($0) }
}

//: ## Occupilables

example("filterEmpty") {
    _ = Observable<[String]>
        .of(["Single Element"], [], ["Two", "Elements"])
        .filterEmpty()
        .subscribe { print($0) }
}

/*:
 Unavailable on `Driver`, because `Driver`s cannot error out.
 
 By default, errors with `RxOptionalError.EmptyOccupiable`.
 */
example("errorOnEmpty") {
    _ = Observable<[String]>
        .of(["Single Element"], [], ["Two", "Elements"])
        .errorOnEmpty()
        .subscribe { print($0) }
}

example("catchOnEmpty") {
    _ = Observable<[String]>
        .of(["Single Element"], [], ["Two", "Elements"])
        .catchOnEmpty {
            return Observable<[String]>.just(["Not Empty"])
        }
        .subscribe { print($0) }
}
