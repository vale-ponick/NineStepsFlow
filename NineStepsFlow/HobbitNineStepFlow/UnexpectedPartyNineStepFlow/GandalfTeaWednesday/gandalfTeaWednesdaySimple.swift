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
struct TeaGuest {
    let name: String
    let race: String
    let requestedDishes: String
}

struct HighTea: CustomStringConvertible {
    
    var teaGuests: [TeaGuest] = []
    private var nextId: Int = 1
    
    mutating func arrived(name: String, race: String, dish: String) {
        let gest = TeaGuest(name: name, race: race, requestedDishes: dish)
        teaGuests.append(gest)
        nextId += 1
    }
    var description: String { // Формируем строку из всех гостей в массиве
        return teaGuests.map { guest in
            "\n\(guest.race)\(guest.name) - \(guest.requestedDishes)"
        }.joined(separator: "/n")
    }
}
