import Foundation

// MAYBE As a functor
public struct MaybeInteger: Functor {
    
    //MARK: Types
    public typealias TypeParameter = Maybe<Int>
    public typealias TypeResult = Int?
    
    //MARK: Properties
    public let value: Maybe<Int>
    
    public init(value: Maybe<Int>) {
        self.value = value
    }
    
    //MARK: Functor protocol method
    public func map(function: (Maybe<Int>) -> Int?) -> Int? {
        return function(value)
    }
}

// MAYBE As a Monad + Typeclass
extension MaybeInteger: Monad {
    
    //MARK: Types
    public typealias MonadType = Maybe<Int>
    
    //MARK: Monad protocol method
    public func flatmap(function: ((Maybe<Int>) -> Maybe<Int>)) -> Maybe<Int> {
        return function(value)
    }
}
