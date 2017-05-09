import Foundation

public enum Result <Value, ErrorElement: Error> {
    case success(Info<Value>)
    case error(ErrorElement)
}

public struct Future<Value, ErrorElement: Error> {
    
    //MARK: Types
    public typealias ResultType = Result<Value, ErrorElement>
    public typealias Completion = (ResultType) -> ()
    public typealias AsyncOperation = (_ completion: @escaping Completion) -> ()
    
    //MARK: Properties
    private let operation: AsyncOperation
    
    public init(operation: @escaping AsyncOperation) {
        self.operation = operation
    }
    
    public init(value: Value) {
        self.init(result: .success(Info(value: value)))
    }
    
    public init(error: ErrorElement) {
        self.init(result: .error(error))
    }
    
    public init(result: ResultType) {
        self.init(operation: { completion in
            completion(result)
        })
    }
    
    public func start(completion: @escaping Completion) {
        self.operation() { result in
            completion(result)
        }
    }
}

// MAP
extension Future {
    public func map<Element>(function: @escaping (Value) -> Element) -> Future<Element, ErrorElement> {
        return Future<Element, ErrorElement>(operation: { completion in
            self.start { result in
                switch result {
                    case .success(let value):
                        completion(.success(Info(value: function(value.value))))
                    case .error(let error):
                        completion(Result.error(error))
                }
            }
        })
    }
}


// AND_THEN (FLAT_MAP)
extension Future {
    public func andThen<Element>(function: @escaping (Value) -> Future<Element, ErrorElement>) -> Future<Element, ErrorElement> {
        return Future<Element, ErrorElement>(operation: { completion in
            self.start { result in
                switch result {
                case .success(let value):
                    function(value.value).start(completion: completion)
                case .error(let error):
                    completion(Result.error(error))
                }
            }
        })
    }
}

// ERROR Handling
extension Future {
    public func mapError<ErrorTransformed>(function: @escaping (ErrorElement) -> ErrorTransformed) -> Future<Value, ErrorTransformed> {
        return Future<Value, ErrorTransformed>(operation: { completion in
            self.start { result in
                switch result {
                case .success(let valueInfo): completion(Result.success(valueInfo))
                case .error(let error): completion(Result.error(function(error)))
                }
            }
        })
    }
}


