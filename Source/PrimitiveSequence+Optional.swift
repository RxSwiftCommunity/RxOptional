import Foundation
import RxSwift

public extension PrimitiveSequenceType where TraitType == SingleTrait, ElementType: OptionalType {
    /**
     Throws an error if the source `Single` contains an empty element; otherwise returns original source `Single` of non-empty elements.
     
     - parameter error: error to throw when an empty element is encountered. Defaults to `RxOptionalError.FoundNilWhileUnwrappingOptional`.
     
     - throws: `error` if an empty element is encountered.
     
     - returns: original source `Single` of non-empty elements if it contains no empty elements.
     */
    
    public func errorOnNil(_ error: Error = RxOptionalError.foundNilWhileUnwrappingOptional(ElementType.self)) -> PrimitiveSequence<SingleTrait, ElementType.Wrapped> {
        return self.map { element -> ElementType.Wrapped in
            guard let value = element.value else {
                throw error
            }
            return value
        }
    }
    
    /**
     Unwraps optional elements and replaces `nil` elements with `valueOnNil`.
     
     - parameter valueOnNil: value to use when `nil` is encountered.
     
     - returns: `Single` of the source `Single`'s unwrapped elements, with `nil` elements replaced by `valueOnNil`.
     */
    
    public func replaceNilWith(_ valueOnNil: ElementType.Wrapped) -> PrimitiveSequence<SingleTrait, ElementType.Wrapped> {
        return self.map { element -> ElementType.Wrapped in
            guard let value = element.value else {
                return valueOnNil
            }
            return value
        }
    }
    
    /**
     Unwraps optional elements and replaces `nil` elements with result returned by `handler`.
     
     - parameter handler: `nil` handler throwing function that returns `Single` of non-`nil` elements.
     
     - returns: `Single` of the source `Single`'s unwrapped elements, with `nil` elements replaced by the handler's returned non-`nil` elements.
     */
    
    public func catchOnNil(_ handler: @escaping () throws -> PrimitiveSequence<SingleTrait, ElementType.Wrapped>) -> PrimitiveSequence<SingleTrait, ElementType.Wrapped> {
        return self.flatMap { element -> PrimitiveSequence<SingleTrait, ElementType.Wrapped> in
            guard let value = element.value else {
                return try handler()
            }
            return PrimitiveSequence<SingleTrait, ElementType.Wrapped>.just(value)
        }
    }
}
