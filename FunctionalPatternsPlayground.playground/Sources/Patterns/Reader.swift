import Foundation

public class Reader<Environment, Type> {
    
    // MARK: Properties
    public let transform: (Environment) -> (Type)
    public init(transform: @escaping (Environment) -> (Type)) {
        self.transform = transform
    }
    
    public func apply(environment: Environment) -> Type {
        return transform(environment)
    }
    public func map<Result>(function: @escaping (Type) -> (Result)) -> Reader<Environment, Result> {
        return Reader<Environment, Result>{ environment in function(self.transform(environment)) }
    }
    public func flatMap<Result>(function: @escaping (Type) -> Reader<Environment, Result>) -> Reader<Environment, Result> {
        return Reader<Environment, Result>{ environment in function(self.transform(environment)).transform(environment) }
    }
}
