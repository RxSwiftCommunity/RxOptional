import RxSwift
import RxCocoa
import RxOptional

/*:
Steps to Run

- Run `pod install` in Example directory
- Select RxOptional Examples Target
- Build
- Show Debug Area (cmd+shift+Y)
- Click blue play button in Debug Area

*/

public func example(description: String, action: () -> ()) {
    print("\n--- \(description) example ---")
    action()
}

//: All operators are available on Driver as well unless otherwise marked.


//: ## Optionals

example("filterNil") {
    let _ = Observable<String?>
        .of("One", nil, "Three")
        .filterNil() // Type is now Observable<String>
        .subscribe { print($0) }
}

example("replaceNilWith") {
    let _ = Observable<String?>
        .of("One", nil, "Three")
        .replaceNilWith("Two") // Type is now Observable<String>
        .subscribe { print($0) }
}

/*:
 Unavailable on Driver
 
 By default errors with `RxOptionalError.FoundNilWhileUnwrappingOptional`.
*/
example("errorOnNil") {
    let _ = Observable<String?>
        .of("One", nil, "Three")
        .errorOnNil()
        .subscribe { print($0) }
}

example("catchOnNil") {
    let _ = Observable<String?>
        .of("One", nil, "Three")
        .catchOnNil {
            return Observable<String>.just("A String from a new Observable")
        }  // Type is now Observable<String>
        .subscribe { print($0) }
}

//: ## Occupilables

example("filterEmpty") {
    let _ = Observable<[String]>
        .of(["Single Element"], [], ["Two", "Elements"])
        .filterEmpty()
        .subscribe { print($0) }
}

//: By default errors with `RxOptionalError.EmptyOccupiable`.
example("errorOnEmpty") {
    let _ = Observable<[String]>
        .of(["Single Element"], [], ["Two", "Elements"])
        .errorOnEmpty()
        .subscribe { print($0) }
}

example("catchOnEmpty") {
    let _ = Observable<[String]>
        .of(["Single Element"], [], ["Two", "Elements"])
        .catchOnEmpty {
            return Observable<[String]>.just(["Not Empty"])
        }
        .subscribe { print($0) }
}
