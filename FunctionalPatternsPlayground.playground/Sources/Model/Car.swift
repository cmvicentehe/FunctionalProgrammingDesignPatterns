import Foundation

public struct Car {
    public let brand: String
    public let model: String
    public let year: Int
    
    public init(
        brand: String,
        model: String,
        year: Int) {
        self.brand = brand
        self.model = model
        self.year = year
    }
}

extension Car: CustomDebugStringConvertible {
    public var debugDescription: String {
        return "Car with brand: \(brand), model: \(model), year: \(year)"
    }
}
