//
//  UserModel.swift
//  CoreModels
//
//  Created by Yo'ldoshev Asadbek on 13/08/2025.
//

import SwiftUI

public struct UserModel: Codable, Equatable {
    public var name: String
    public var email: String
    public var telephoneNumber: String
    
    public init(name: String, email: String, telephoneNumber: String) {
        self.name = name
        self.email = email
        self.telephoneNumber = telephoneNumber
    }
}
