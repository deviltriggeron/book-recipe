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
        container.register(Database.self) { _ in Database() }
        container.register(Controller.self) { _ in Controller() }
    }
    
    func resolve<T>(_ type: T.Type) -> T? {
        guard let instance = container.resolve(type) else {
            print("Error: Could not resolve \(type)")
            return nil
        }
        return instance
    }

}
