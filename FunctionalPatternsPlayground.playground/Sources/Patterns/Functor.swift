import Foundation

public protocol Functor {
    //MARK: Types
    associatedtype TypeParameter // it could be a function
    associatedtype TypeResult // it could be a function
    typealias Function = (TypeParameter) -> TypeResult
    
    func map(function: (Function)) -> TypeResult
}
