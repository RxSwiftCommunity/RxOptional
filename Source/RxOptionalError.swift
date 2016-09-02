import Foundation

public enum RxOptionalError: Error, CustomStringConvertible {
    case FoundNilWhileUnwrappingOptional(Any.Type)
    case EmptyOccupiable(Any.Type)

    public var description: String {
        switch self {
        case .FoundNilWhileUnwrappingOptional(let type):
          return "Found nil while trying to unwrap type <\(String(describing:type))>"
        case .EmptyOccupiable(let type):
            return "Empty occupiable of type <\(String(describing:type))>"
        }
    }
}
