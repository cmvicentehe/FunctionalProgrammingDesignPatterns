import Foundation

public struct DataBase {
    // MARK: Properties
    public let path: String
    
    public func findCar(with model: String) -> Car {
        return Car(brand:"BMW", model: model, year: 1987)
    }
    public func updateCar(car: Car) -> Void {
        print(car.model + " in: " + path)
    }
}
