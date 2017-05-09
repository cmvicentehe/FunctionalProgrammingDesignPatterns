import Foundation

public protocol Addable {
    //MARK: Types
    associatedtype AddableType
    
    //MARK: Properties
    static var empty: AddableType { get }
    static func add(firstOperand: AddableType, secondOperand: AddableType) -> AddableType
}

extension Addable {
    static func times(element: AddableType, times: Int) -> AddableType {
        func execute(result: AddableType, times: Int) -> AddableType {
            switch times {
                case 0: return empty
                case 1: return result
                default: return execute(
                    result: add(firstOperand: element, secondOperand: result),
                                  times: times-1
                )
            }
        }
        
        return execute(
            result: element,
            times: times
        )
    }
    
}

extension Int: Addable {
    
    //MARK: Properties
   public static var empty: Int { return 0 }
    
    //MARK: Addable protocol
   public static func add(firstOperand x: Int, secondOperand y: Int) -> Int {
        return x + y
    }
}

extension String: Addable {
    
    //MARK: Properties
    public static var empty: String { return "" }
    
    //MARK: Addable protocol
    public static func add(firstOperand x: String, secondOperand y: String) -> String {
        return x + y
    }
}
