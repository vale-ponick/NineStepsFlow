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

struct TeaGuest: CustomStringConvertible {
    let name: String
    let race: String
    let requestedDishes: String
    
    var description: String {
        "\(name) (\(race)) requests \(requestedDishes)"
    }
}

struct HighTea: CustomStringConvertible {
    
    private(set) var teaGuests: [TeaGuest] = []
    
    mutating func arrive(name: String, race: String, dish: String) {
        let guest = TeaGuest(name: name, race: race, requestedDishes: dish)
        teaGuests.append(guest)
    }
    var description: String { // Формируем строку из всех гостей в массиве
        var result = "🍲 Gandalf Tea Wednesday:\n"
        result += teaGuests.enumerated()
            .map { "\($0.offset + 1). \($0.element)" }
            .joined(separator: "\n")
        return result
    }
}
func runTeaWednesday() {
    let tea: [TeaGuest] = [
        TeaGuest(name: "Balin", race: "dwarf", requestedDishes: "pie"),
        TeaGuest(name: "Dwalin", race: "dwarf", requestedDishes: "ale"),
        TeaGuest(name: "Bifur", race: "dwarf", requestedDishes: "jam"),
        TeaGuest(name: "Bofur", race: "dwarf", requestedDishes: "meat pies"),
        TeaGuest(name: "Bombur", race: "dwarf", requestedDishes: "pork pie"),
        TeaGuest(name: "Gandalf", race: "wizard", requestedDishes: "red wine")
    ]
    
    var highTea = HighTea()
    for guest in tea {
        highTea.arrive(name: guest.name, race: guest.race, dish: guest.requestedDishes)
    }
    
    print(highTea)
}
/**
 🍲 Gandalf Tea Wednesday:
 1. Balin (dwarf) requests pie
 2. Dwalin (dwarf) requests ale
 3. Bifur (dwarf) requests jam
 4. Bofur (dwarf) requests meat pies
 5. Bombur (dwarf) requests pork pie
 6. Gandalf (wizard) requests red wine
 */
