//
//  Injection.swift
//  Delicios notes for iOS advanced lvl
//
//  Created by Starfighter Dollie on 27.12.2024.
//

import Foundation
import Swinject

class Injection {
    
    static let shared = Injection()
    
    let container: Container
    
    init() {
        container = Container()
        setup()
    }
    
    func setup() {
        container.register(Database.self) { _ in Database.shared }
        container.register(AlamofireService.self) { resolver in
            let database = resolver.resolve(Database.self)!
            return AlamofireService(database: database)}
        container.register(Controller.self) { resolver in
            let service = resolver.resolve(AlamofireService.self)!
            let database = resolver.resolve(Database.self)!
            return Controller(service: service, database: database) }
    }
    
    func resolve<T>(_ type: T.Type) -> T? {
        guard let instance = container.resolve(type) else {
            print("Error: Could not resolve \(type)")
            return nil
        }
        return instance
    }

}
