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

example("filterNil") {
    Observable<String?>.of("One", nil, "two")
        .filterNil()
        .subscribe { print($0) }
}

example("fatalErrorOnNil") {
    Observable<String?>
        .just(nil)
        .fatalErrorOnNil()
        .subscribe { print($0) }
}

example("errorOnNil") {
    Observable<String?>
        .just(nil)
        .errorOnNil(RxError.Unknown)
        .subscribe { print($0) }
}

example("catchOnNil") {
    Observable<String?>
        .just(nil)
        .catchOnNil {
            return Observable<String>.just("A String from a new Observable")
        }
        .subscribe { print($0) }
}
