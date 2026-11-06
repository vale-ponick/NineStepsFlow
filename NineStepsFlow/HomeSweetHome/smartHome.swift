//
/// MARK: - «Smart home: living room»
// TS: Smart home controls the living room lamps.
// Each lamp: brightness == nil (broken), 0 (off), >0 (on).
// Tasks: (1) turn all on, (2) turn all off, (3) count active, (4) count broken, (5) report.

struct LightFixture { // любой стационарный светильник
    let name: String
    var brightness: Int?
}

struct LivingRoom {
    var fixtures: [LightFixture] = []
    
    mutating func turnOn() { // Включаем все исправные лампы на 100%
        for i in fixtures.indices where fixtures[i].brightness != nil {
            fixtures[i].brightness = 100
        }
    }
    
    mutating func turnOff() { // Выключаем все исправные лампы
        for i in fixtures.indices where fixtures[i].brightness != nil {
            fixtures[i].brightness = 0
        }
    }
    
    var activeCount: Int { // Подсчет активных (работающих и включенных) ламп
        // ИСПРАВЛЕНО: Заменено 'S0' на '$0' и добавлена пропущенная открывающая скобка
        fixtures.filter { ($0.brightness ?? 0) > 0 }.count
    }
    
    var brokenCount: Int { // Подсчет сломанных ламп
        // ИСПРАВЛЕНО: Заменено 'S0' на '$0' и добавлена пропущенная закрывающая скобка '}' для свойства
        fixtures.filter { $0.brightness == nil }.count
    } // <- ИСПРАВЛЕНО: Добавлена закрывающая скобка свойства

    func report() {
        for fixture in fixtures {
            if let brightness = fixture.brightness {
                print("💡 \(fixture.name): \(brightness)%") // ИСПРАВЛЕНО: Используем извлеченный brightness
            } else {
                print("❌ \(fixture.name): Broken") // Добавлено для наглядности сломанных ламп
            }
        }
        // ИСПРАВЛЕНО: Вывод статистики вынесен ЗА пределы цикла 'for'
        print(" Total Active: \(activeCount) / Working: \(fixtures.count - brokenCount) / Total: \(fixtures.count)\n")
    }
}

// ИСПРАВЛЕНО: Функция вынесена за пределы структуры LivingRoom (исправлен баланс скобок)
func runLivingRoom() {
    var room = LivingRoom(fixtures: [
        LightFixture(name: "Ceiling", brightness: 50),
        LightFixture(name: "Floor", brightness: 0),
        LightFixture(name: "Desk", brightness: nil)
    ])
    
    print("Initial active count: \(room.activeCount)") // 1
    print("Initial broken count: \(room.brokenCount)") // 1
    print("---")
    
    print("Turning ON all lights:")
    room.turnOn()
    room.report()
    
    print("Turning OFF all lights:")
    room.turnOff()
    room.report()
}

/**
 Initial active count: 1
 Initial broken count: 1
 ---
 Turning ON all lights:
 💡 Ceiling: 100%
 💡 Floor: 100%
 ❌ Desk: Broken
  Total Active: 2 / Working: 2 / Total: 3

 Turning OFF all lights:
 💡 Ceiling: 0%
 💡 Floor: 0%
 ❌ Desk: Broken
  Total Active: 0 / Working: 2 / Total: 3

 Program ended with exit code: 0
 */
