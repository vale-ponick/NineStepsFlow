//
//  crewAres3.swift
//  NineStepsFlow
//
//  Created by Валерия Пономарева on 01.11.2026.
//

import Foundation

// MARK: - 7️⃣: 'Экипаж Ares 3'
// TS: Экипаж Ares 3 — 6 человек. Ты — бортовой компьютер Hab нужно отчитаться о каждом члене экипажа: Марк — остался на Марсе (в Hab). Льюис (командир), Бекки, Мартинес, Фогель, Йоханссен — улетели на «Гермесе». Задача: Вывести список (имя + где) и итог (count).

struct Ares3Member {
    let name: String
    var isOnMars: Bool
}
struct Crew {
    let members: [Ares3Member]
    
    func report() {
        for member in members {
            if member.isOnMars {
                print("\(member.name) - on Mars")
            } else {
                print("\(member.name) - on Hermes")
            }
        }
        print("Total: \(members.count)")
    }
}
func displayAres3Members() {
    let crew = Crew(
        members: [
            Ares3Member(name: "Mark Watney", isOnMars: true),
            Ares3Member(name: "Melissa Lewis", isOnMars: false),
            Ares3Member(name: "Rick Martinez", isOnMars: false),
            Ares3Member(name: "Alex Vogel", isOnMars: false),
            Ares3Member(name: "Beth Johanssen", isOnMars: false),
            Ares3Member(name: "Chris Beck", isOnMars: false)
    ])
    crew.report()
}
/**
 Mark Watney - on Mars
 Melissa Lewis - on Hermes
 Rick Martinez - on Hermes
 Alex Vogel - on Hermes
 Beth Johanssen - on Hermes
 Chris Beck - on Hermes
 Total: 6
 Program ended with exit code: 0
 */












