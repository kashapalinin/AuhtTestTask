## Инструкция по запуску:
### Шаг 1: Клонирование репозитория

```bash
git clone https://github.com/kashapalinin/AuhtTestTask.git
```
### Шаг 2: Установка зависимостей

Если проект использует CocoaPods:

```bash
sudo gem install cocoapods
pod install
```

Если использует Swift Package Manager:

Откройте Xcode → File → Add Packages 

Дождитесь загрузки зависимостей

Список зависимостей:

https://github.com/google/GoogleSignIn-iOS

https://github.com/firebase/firebase-ios-sdk.git

### Шаг 3: Создание проекта в Firebase Console

Перейдите на Firebase Console

Нажмите "Создать проект"

Введите название проекта

Настройте Google Analytics (по желанию)

Нажмите "Создать проект"

### Шаг 4: Добавление iOS приложения в Firebase

В Firebase Console нажмите "Добавить приложение" → iOS

Заполните данные:

iOS bundle ID - найдите в Xcode: Target → General → Bundle Identifier

Название приложения - любое название

Нажмите "Зарегистрировать приложение"

### Шаг 5: Загрузка файла конфигурации

Скачайте файл GoogleService-Info.plist

Перетащите его в Xcode в корневую папку проекта

Убедитесь что в диалоге выбрана опция "Copy items if needed"

Выберите все targets которые используют Firebase

### Шаг 6: Настройка Firebase в коде(уже есть в проекте)

```swift
import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

@main
struct AuhtTestTaskApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            AppView()
        }
    }
}

```

### Шаг 7: Настройка необходимых сервисов Firebase

Authentication:

В Firebase Console перейдите в Authentication → Sign-in method

Включите необходимые методы входа (Google)

### Шаг 8: Настройка в Xcode
Убедитесь что GoogleService-Info.plist добавлен в:

Target → Build Phases → Copy Bundle Resources

## ВАЖНО: Для подключения "Sign In with Apple" нужно иметь подписку на Apple Developer Program. Ввиду неимения подписки данная функция не реализована.

## Архитектура: MVVM


