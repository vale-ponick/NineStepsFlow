//
//  gandalfTeaWednesdaySimple.swift
//  NineStepsFlow
//
//  Created by Валерия Пономарева on 14.10.2026.
//

import Foundation

// MARK: - 'Gandalf Tea Wednesday' - Simple

//🎬 Plot: The dwarves visit Bilbo and sit down at the table. Each orders their favorite dish. Bilbo checks the pantry. He finds everything the guests requested, and together they set the table.

// 🛠 Task: Create a TeaGuests array, a TeaGuest structure storing properties (name, requested dish), and a HighTea structure with an array of guests. Write a function that prints information to the console (a string/block) about who has arrived and what they ordered.

/**
 1️⃣ Create the TeaGuest struct (properties: name, requestedDish) and HighTea struct (property: teaGuests: [TeaGuest]). Add private var nextId: Int = 1 to automatically increment guest IDs.

 3️⃣ Create a mutating func arrive(name: String, dish: String) function in HighTea that creates a TeaGuest object, adds it to teaGuests, and increments nextId.

 4️⃣ Create an array of guests within runTeaWendesday(). In the output, process them using arrays, enumerated() to number guests, and map / join(separator:) as needed.

 5️⃣ Use `CustomStringConvertible` for `TeaGuest` and `HighTea` to output a clear text block to the console: a title, a numbered list of guests, and their dishes.
 */

struct TeaGuest: CustomStringConvertible { // создала структуру с полями + подписала под протокол
    let name: String
    let race: String
    let requestedDishes: String
    
    var description: String { // создала вычисляемое "на лету" свойство (computed property) - в памяти не хранится
        "\(name) (\(race)) requests \(requestedDishes)"
    }
}

struct HighTea: CustomStringConvertible {
    
    private(set) var teaGuests: [TeaGuest] = [] // частный случай модификатор доступа (access modifier): "читать всем (set)!, менять — только внутри типа". // Есть и другие: private, internal, public
    
    mutating func arrive(name: String, race: String, dish: String) { // мутац. метод меняет свойства самой структуры (self)
        let guest = TeaGuest(name: name, race: race, requestedDishes: dish)
        teaGuests.append(guest)
    }
    var description: String {
        var result = "🍲 Gandalf Tea Wednesday:\n"
        result += teaGuests.enumerated()
            .map { "\($0.offset + 1). \($0.element)" }
            .joined(separator: "\n") // использовала method chaining - Цепочка: enumerated → map → joined. Каждый метод возвращает новое значение, на котором вызывается следующий.
        return result
    }
}
func runTeaWednesday() { // точка входа
    let tea: [TeaGuest] = [
        TeaGuest(name: "Balin", race: "dwarf", requestedDishes: "pie"),
        TeaGuest(name: "Dwalin", race: "dwarf", requestedDishes: "ale"),
        TeaGuest(name: "Bifur", race: "dwarf", requestedDishes: "jam"),
        TeaGuest(name: "Bofur", race: "dwarf", requestedDishes: "meat pies"),
        TeaGuest(name: "Bombur", race: "dwarf", requestedDishes: "pork pie"),
        TeaGuest(name: "Gandalf", race: "wizard", requestedDishes: "red wine")
    ]
    
    var highTea = HighTea()
    for guest in tea { // перебор массива tea, каждый guest — экземпляр TeaGuest
        highTea.arrive(name: guest.name, race: guest.race, dish: guest.requestedDishes)
    }
    
    print(highTea)
}
/** method chaining: enumerated → map → joined.
 [TeaGuest]                                    начальный массив
     │
     │ .enumerated()                           обернуть в пары
     ▼
 [(0, TeaGuest), (1, TeaGuest), (2, TeaGuest)]
     │
     │ .map { "\($0.offset + 1). \($0.element)" }   превратить в строки
     ▼
 ["1. Balin requests pie", "2. Dwalin requests ale", ...]
     │
     │ .joined(separator: "\n")                склеить в одну строку
     ▼
 "1. Balin requests pie\n2. Dwalin requests ale\n..."
     │
     │ return                                 вернуть из computed property
     ▼
 String
 
 Почему цепочка, а не цикл?
 Можно было так:

 var result = ""
 for (index, guest) in teaGuests.enumerated() {
     result += "\(index + 1). \(guest)\n"
 }
 Работает же. Зачем цепочка?

 Цикл                                   Цепочка
 Императивный — «делай шаг за шагом»    Декларативный — «что получи»
 Мутирует переменную (result += ...)    Не мутирует, создаёт новое
 Читается как инструкция                Читается как выражение
 Проще отладить                         Компактнее, идиоматичнее Swift
 
 NB: В Swift — цепочка предпочтительнее.    Функциональный стиль.
 
 Совет: при чтении — смотри на типы промежуточных значений. Они подсказывают, какой метод доступен следующим.
 
 Мнемоника — три группы по СМЫСЛУ
 Преобразование: map, compactMap, filter, reduce.
 Сборка: joined, sorted, enumerated.
 Поиск: first, contains, dict[key].
 */

/**
 🍲 Gandalf Tea Wednesday:
 1. Balin (dwarf) requests pie
 2. Dwalin (dwarf) requests ale
 3. Bifur (dwarf) requests jam
 4. Bofur (dwarf) requests meat pies
 5. Bombur (dwarf) requests pork pie
 6. Gandalf (wizard) requests red wine
 */
