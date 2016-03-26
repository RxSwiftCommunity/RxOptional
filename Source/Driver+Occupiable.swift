import Foundation
import RxCocoa

public extension Driver where Element: Occupiable {
    /**
     Filters out empty elements.

     - returns: `Driver` of source `Driver`'s elements, with empty elements filtered out.
     */
    @warn_unused_result(message="http://git.io/rxs.uo")
    public func filterEmpty() -> Driver<Element> {
        return self.flatMap { element -> Driver<Element> in
            guard element.isNotEmpty else {
                return Driver<Element>.empty()
            }
            return Driver<Element>.just(element)
        }
    }

    /**
     Replaces empty elements with result returned by `handler`.

     - parameter handler: empty handler function that returns `Driver` of non-empty elements.

     - returns: `Driver` of the source `Driver`'s elements, with empty elements replaced by the handler's returned non-empty elements.
     */
    @warn_unused_result(message="http://git.io/rxs.uo")
    public func catchOnEmpty(handler: () -> Driver<Element>) -> Driver<Element> {
        return self.flatMap { element -> Driver<Element> in
            guard element.isNotEmpty else {
                return handler()
            }
            return Driver<Element>.just(element)
        }
    }
}
