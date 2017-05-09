import Foundation

public protocol Functor {
    //MARK: Types
    associatedtype TypeParameter // it could be a function
    associatedtype TypeResult // it could be a function
    
    func map(function: ((TypeParameter) -> TypeResult)) -> TypeResult
}
