import Foundation

// FUNCTOR
public struct User: Functor {
    
    //MARK: Types
    public typealias TypeParameter = User
    public typealias TypeResult = String
    
    //MARK: Properties
    public let name: String
    public let lastName: String
    
    public init (name: String, lastName: String) {
        self.name = name
        self.lastName = lastName
    }
    
    //MARK: Functor protocol method
    public func map(function: ((User) -> String)) -> String {
        return function(self)
    }
}
