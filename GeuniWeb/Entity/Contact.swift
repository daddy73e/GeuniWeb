//
//  Contact.swift
//  GeuniWeb
//
//  Created by 60157085 on 2023/02/07.
//

import Foundation

struct Contact {
    public let id: String
    public let firstName: String
    public let givenName: String
    public let phoneNumber: String

    init(
        id: String,
        firstName: String,
        givenName: String,
        phoneNumber: String
    ) {
        self.id = id
        self.firstName = firstName
        self.givenName = givenName
        self.phoneNumber = phoneNumber
    }
}
