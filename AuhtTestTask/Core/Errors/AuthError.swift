//
//  AuthError.swift
//  AuhtTestTask
//
//  Created by Павел Калинин on 04.09.2025.
//
import Foundation

enum AuthError: LocalizedError {
    case noToken
    case noUser
    case rootControllerNotFound
    case invalidResponse
    case network
    case server
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .noToken:
            return "Не удалось получить токен. Попробуйте снова."
        case .noUser:
            return "Пользователь не найден. Авторизуйтесь ещё раз."
        case .rootControllerNotFound:
            return "Не удалось открыть экран авторизации. Попробуйте перезапустить приложение."
        case .invalidResponse:
            return "Сервис временно недоступен. Попробуйте позже."
        case .network:
            return "Проблемы с интернет-соединением. Проверьте сеть и попробуйте снова."
        case .server:
            return "Ошибка сервера. Попробуйте позже."
        case .unknown:
            return "Что-то пошло не так. Попробуйте снова."
        }
    }
}
