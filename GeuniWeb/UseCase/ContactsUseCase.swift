//
//  ContactsUseCase.swift
//  GeuniWeb
//
//  Created by 60157085 on 2023/02/07.
//

import Foundation
import Contacts

public struct ContactsOutput {

    var contacts = [Contact]()
    var isPermissionAccess: Bool

    init(contacts: [Contact], isPermissionAccess: Bool) {
        self.contacts = contacts
        self.isPermissionAccess = isPermissionAccess
    }
}

public protocol ContactsUseCaseProtocol {
    func request(completion: @escaping (ContactsOutput) -> Void)
}

public class ContactsUseCase: ContactsUseCaseProtocol {
    public init() {
    }

    public func request(completion: @escaping (ContactsOutput) -> Void) {
        let store = CNContactStore()
        var contacts: [Contact] = []

        // 연락처에 요청할 항목
        let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey] as [CNKeyDescriptor]
        // Request 생성
        let request = CNContactFetchRequest(keysToFetch: keys)
        request.sortOrder = CNContactSortOrder.userDefault

        // 권한체크
        store.requestAccess(for: .contacts) { granted, error in
            guard granted else {
                completion(.init(contacts: [], isPermissionAccess: false))
                return
            }
            do {
                // 연락처 데이터 획득
                try store.enumerateContacts(with: request) { (contact, _) in
                    guard let phoneNumber = contact.phoneNumbers.first?.value.stringValue else { return }
                    let id = contact.identifier
                    let givenName = contact.givenName
                    let familyName = contact.familyName

                    let contactToAdd = Contact(
                        id: id,
                        firstName: familyName,
                        givenName: givenName,
                        phoneNumber: phoneNumber
                    )
                    contacts.append(contactToAdd)
                }
            } catch let error {
                print(error.localizedDescription)
            }
            completion(.init(contacts: contacts, isPermissionAccess: true))
        }
    }
}
