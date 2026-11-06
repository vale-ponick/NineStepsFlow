//
//  awkwardWednesdaySimple.swift
//  NineStepsFlow
//
//  Created by Валерия Пономарева on 13.10.2026.
//

import Foundation

// MARK: - TS: 'AwkwardWednesday' — Simple

// Project: AwkwardWednesday (chapter "Unexpected Guests", The Hobbit by J.R.R. Tolkien)

struct Guest {
    let name: String
    let requestedDish: String // просит угощение/блюдо
    let id: Int
}

extension Guest: CustomStringConvertible {
    var description: String {
        "\(name) requests \(requestedDish)"
    }
}

struct AwkwardWednesday {
    
    private(set) var guests: [Guest] = []
    private var nextId: Int = 1
    
    mutating func arrive(name: String, dish: String) { // действия
        let dwarf = Guest(name: name, requestedDish: dish, id: nextId)
        guests.append(dwarf)
        nextId += 1
    }
}
    
    extension AwkwardWednesday: CustomStringConvertible {
        var description: String {
            var result = "🍲 Awkward Wednesday at Bilbo's:\n"
            for (index, guest) in guests.enumerated() {
                result += "\(index + 1). 🆔\(guest.id) - \(guest)\n"
            }
            return result
    }
}
    
func runFeast() {
    var feast = AwkwardWednesday()
    feast.arrive(name: "Dwalin", dish: "pie")
    feast.arrive(name: "Balin", dish: "ale")
    feast.arrive(name: "Thorin", dish: "soup")
    print(feast)
}

/**
 🍲 Awkward Wednesday at Bilbo's:
 1. 🆔1 - Dwalin requests pie
 2. 🆔2 - Balin requests ale
 3. 🆔3 - Thorin requests soup
 */



