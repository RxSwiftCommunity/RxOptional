import RxSwift
import RxCocoa
import RxOptional

/*
Steps to Run

- Select RxOptional Examples Target
- Build
- Show Debug Area (cmd+shit+Y)
- Click blue play button in Debug Area

*/

public func example(description: String, action: () -> ()) {
    print("\n--- \(description) example ---")
    action()
}

// All operators are available on Driver as well unless otherwise marked.


// Optionals

example("filterNil") {
    let _ = Observable<String?>
        .of("One", nil, "Three")
        .filterNil()
        .subscribe { print($0) }
}

example("replaceNilWith") {
    let _ = Observable<String?>
        .of("One", nil, "Three")
        .replaceNilWith("Two")
        .subscribe { print($0) }
}

example("fatalErrorOnNil") {
    let _ = Observable<String?>
        .of("One", nil, "Three")
        .fatalErrorOnNil()  // Durring release fatalErrors will only be logged
        .subscribe { print($0) }
}

// Unavailable on Driver
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
        }
        .subscribe { print($0) }
}

// Occupilables

example("filterEmpty") {
    let _ = Observable<[String]>
        .of(["Single Element"], [], ["Two", "Elements"])
        .filterEmpty()
        .subscribe { print($0) }
}

example("fatalErrorOnEmpty") {
    let _ = Observable<[String]>
        .of(["Single Element"], [], ["Two", "Elements"])
        .fatalErrorOnEmpty()
        .subscribe { print($0) }
}


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
