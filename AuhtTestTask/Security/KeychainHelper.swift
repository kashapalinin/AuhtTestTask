//
//  KeychainHelper.swift
//  AuhtTestTask
//
//  Created by Павел Калинин on 04.09.2025.
//


import Foundation
import Security

final class KeychainService {

    static let shared = KeychainService()
    private init() {}

    @discardableResult
    func save(value: String, forKey key: String) -> Bool {
        guard let data = value.data(using: .utf8) else { return false }

        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecValueData as String: data
        ]

        SecItemDelete(query as CFDictionary)

        let status = SecItemAdd(query as CFDictionary, nil)

        return status == errSecSuccess
    }

    // MARK: - Получение данных

    /// Извлекает строку из Keychain по заданному ключу.
    /// - Parameter key: Ключ, по которому нужно извлечь строку.
    /// - Returns: Извлеченная строка, или `nil` если не найдено или произошла ошибка.
    func get(forKey key: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: kCFBooleanTrue!,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]

        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)

        guard status == errSecSuccess else { return nil }

        guard let data = item as? Data else { return nil }

        return String(data: data, encoding: .utf8)
    }

    // MARK: - Удаление данных

    /// Удаляет строку из Keychain по заданному ключу.
    /// - Parameter key: Ключ, по которому нужно удалить строку.
    /// - Returns: `true` если удаление успешно, иначе `false`.
    @discardableResult
    func delete(forKey key: String) -> Bool {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        
        return status == errSecSuccess
    }

    // MARK: - Обновление данных

    /// Обновляет существующее значение в Keychain или добавляет новое, если его нет.
    /// Этот метод более универсален, чем просто save, так как он пытается обновить, а затем добавить.
    /// - Parameters:
    ///   - value: Новое значение строки.
    ///   - key: Ключ, по которому нужно обновить или добавить значение.
    /// - Returns: `true` если операция успешна, иначе `false`.
    @discardableResult
    func update(value: String, forKey key: String) -> Bool {
        guard let data = value.data(using: .utf8) else { return false }
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key
        ]
        
        let attributesToUpdate: [String: Any] = [
            kSecValueData as String: data
        ]
        
        let status = SecItemUpdate(query as CFDictionary, attributesToUpdate as CFDictionary)
        
        if status == errSecSuccess {
            return true
        } else if status == errSecItemNotFound {
            return save(value: value, forKey: key)
        } else {
            return false
        }
    }
}
