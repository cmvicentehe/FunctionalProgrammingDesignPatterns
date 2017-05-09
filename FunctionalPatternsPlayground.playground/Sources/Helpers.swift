import Foundation
import UIKit

public enum DownloadError: Error {
    case unexpectedError
}

public struct Helpers {
    
    // MARK - MONADs AND FUNCTOR
    public static func usersTransformation(user: User) -> String {
        return user.map (function: Helpers.transformation)
    }
    
    public static func transformation(user: User) -> String {
        return ("\(user.name) \(user.lastName)")
    }
    
    public static func checkNilInteger(value: Maybe<Int>) -> Int? {
        switch value {
        case .just(let value): return value
        case .nothing: return nil
        }
    }
    
     public static func checkMaybeInteger(value: Maybe<Int>) -> Maybe<Int> {
        switch value {
        case .just(let value): return .just(value)
        case .nothing: return .nothing
        }
    }
    
    public static func timesByFour<Type: Addable>(addable: Type) -> Type where Type.AddableType == Type {
        return Type.times(element: addable, times: 4)
    }
    
    // MARK - APPLICATIVE
    public static func functionToTestApplicative(value: Int) -> Int {
        return value
    }
    
    // MARK - READER
    public static func updateCarModel(model: String, newModel: String) -> Reader<Environment, Car> {
        return Reader<Environment, Car> { environment in
            let database = DataBase(path: environment.path)
            let car = database.findCar(with: model)
            let newCar = Car(brand: car.brand, model: newModel, year: car.year)
            database.updateCar(car: newCar)
            
            return newCar
        }
    }
    
    public static func brandForCar(car: Car) -> String {
        return car.brand
    }
    
    public static func carTransform(enviroment: Environment) -> Car {
        return Car(brand: "Renault", model: "Clio", year: 2010)
    }
    
    // MARK - FUTURE
    public static func downloadFile(url: URL) -> Future<Data, DownloadError> {
        return Future<Data, DownloadError>() { (completion:@escaping (_ result: Result<Data, DownloadError>) -> ())  in
            DispatchQueue.global().async() {
                let result: Result<Data, DownloadError>
                do {
                    let data = try Data(contentsOf: url)
                    result = Result.success(Info(value: data))
                } catch {
                    result = Result.error(DownloadError.unexpectedError)
                }
                completion(result)
            }
        }
    }
    
    public static func requestUserInfo(userId: String) -> Future<UserWithAvatar, DownloadError> {
        if let url = Bundle.main.url(forResource: userId, withExtension: "png") {
            return Future(value: UserWithAvatar(avatarUrl: url))
        }
        else {
            return Future(error: DownloadError.unexpectedError)
        }
    }
    
    public static func imageFromData(data: Data) -> UIImage {
        return UIImage(data: data) ?? UIImage()
    }
    
    public static func downloadImage(url: URL) -> Future<UIImage, DownloadError> {
        return Helpers.downloadFile(url: url)
            .map(function: Helpers.imageFromData)
    }
    
    
    public static func loadAvatar(userId: String) -> Future<UIImage, DownloadError> {
        return Helpers.requestUserInfo(userId: userId)
            .map (function: Helpers.avatarUrl)
            .andThen(function: downloadImage)
    }
    
    public static func avatarUrl(userWithAvatar: UserWithAvatar) -> URL {
        return userWithAvatar.avatarUrl
    }

}
