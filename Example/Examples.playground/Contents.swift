import RxSwift
import RxCocoa
import RxOptional


/*
Steps to Run

- Select RxOptional-Example Target
- Build
- Show Debug Area (cmd+shit+Y)
- Click blue play button in Debug Area

*/

public func example(description: String, action: () -> ()) {
    print("\n--- \(description) example ---")
    action()
}


example("filterNil") {
    Observable<String?>
        .just("test")
        .filterNil()
        .subscribe { print($0) }
}

example("fatalErrorOnNil") {
    Observable<String?>
        .just(nil)
        .fatalErrorOnNil()
        .subscribe { print($0) }
}
