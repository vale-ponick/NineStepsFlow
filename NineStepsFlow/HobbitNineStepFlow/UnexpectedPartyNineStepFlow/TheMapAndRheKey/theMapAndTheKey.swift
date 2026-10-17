//
//  theMapAndTheKey.swift
//  NineStepsFlow
//
//  Created by Валерия Пономарева on 16.10.2026.
//

import Foundation

/// MARK: - 'The Map and the Key' - Simple

//🎬 Plot: Gandalf hands Thorin the Map and the Key and tells their story. Thror (grandfather) was killed by Azog in Moria — the artifacts passed to his son Thrain. Thrain (father of Thorin) disappeared 100 years ago, but in the dungeons of the Necromancer he gave the Map and the Key to Gandalf with a wish: let Thorin use them. Now Gandalf returns them to Thorin, the rightful heir. Thorin asks: why didn't they reach me sooner?

// 🛠 Task: Create ArtifactType enum (.map, .key), Char enum (characters of the saga), Transfer struct (from, to, note) and Artifact struct (name, type, description, transfers: [Transfer]). Write a function that prints the path of each artifact: who held it, to whom passed, and whether it reached Thorin.

/**
 1️⃣ Create enums and structs: `ArtifactType` (.map, .key), `Char` (thror, thrain, gandalf, thorin, azog, necromancer), `Transfer` (from: Char, to: Char, note: String), `Artifact` (name, type, description, transfers: [Transfer]).

 3️⃣ Extend `Char` with `CustomStringConvertible` — a `description` with a `switch` for rich names ("Thror, King under the Mountain"). Also give `ArtifactType` a String rawValue ("Map", "Key").

 4️⃣ Create `func path() -> String` in Artifact: numbered chain of transfers via `.enumerated()`, `.map`, `.joined(separator:)`. Finish with a ternary: "Has reached Thorin: yes/no".

 5️⃣ Create an array of artifacts within `runArtifacts()`. Use `.first(where:)` + `if let` to find an artifact by name before printing. Use `CustomStringConvertible` for `Artifact` to print a clean text block.
 */
// Три связки: 1️⃣ (struct + enum), 4️⃣ (массивы, map, joined, enumerated), 5️⃣ (CustomStringConvertible) + два новых метода: тернарник, if let.

enum ArtifactType: String { // enum + rawValue
    case map = "🗺️" // a scrap of parchment that looked like a map - a plan of the Lonely Mountain
    case key = "🗝️" // a silver key with a long shaft and an intricate bit
}

enum Char: CustomStringConvertible {
    case thror, thrain, gandalf, thorin, azog, necromancer
    
    var shortName: String {
        switch self {
        case .thror: return "Thror"
        case .thrain: return "Thrain"
        case .gandalf: return "Gandalf"
        case .thorin: return "Thorin"
        case .azog: return "Azog"
        case .necromancer: return "Necromancer"
        }
    }
    
    var description: String {
        switch self {
        case .thror: return "Thror, King under the Mountain"
        case .thrain: return "Thorin's father, tried his luck with the map, experienced many misadventures, did not reach the Mountain, and died in the dungeon of the black magician Necromancer"
        case .thorin: return "Thorin - leader dwarves, 'Thorin and Ko'"
        case .azog: return "goblin leader"
        case .necromancer: return "black Warlock"
        case .gandalf: return "Gandalf Gray, wizard"
        }
    }
}

struct Transfer {
    let from: Char
    let to: Char
    let note: String
}

struct Artifact: CustomStringConvertible {
    let name: String
    let type: ArtifactType
    let story: String
    let transfers: [Transfer]
    
    var emoji: String {
        switch type {
        case .map: return "🗺️"
        case .key: return "🗝️"
        }
    }
    
    var description: String { // ← computed, для протокола
        "\(emoji) \(name) — Gandalf handed over to Thorin\n\(story)\n\(path())"

    }
}

extension Artifact {
    func path() -> String {
        let chain = transfers.enumerated().map { "\($0.offset + 1). \($0.element.from.shortName) ⟶ \($0.element.to.shortName)  - \($0.element.note)" }
            .joined(separator: "\n")
        
        let reach = transfers.last?.to == .thorin ? "yes" : "no"
        
        return "\(chain)\nHas reached Thorin: \(reach)"
    }
}

func runArtifacts() {
    let key = Artifact(
        name: "key", type: .key, story: "a silver key with a long shaft and an intricate bit", transfers: [
            Transfer(from: .thror, to: .thrain, note: "killed by Azog in Moria"),
            Transfer(from: .thrain, to: .gandalf, note: "in the dungeons of the Necromancer"),
            Transfer(from: .gandalf, to: .thorin, note: "key finally returned to legal heir")])
    let map = Artifact(
        name: "map", type: .map, story: "a scrap of parchment that looked like a map - a plan of the Lonely Mountain", transfers: [
            Transfer(from: .thror, to: .thrain, note: "killed by Azog in Moria"),
            Transfer(from: .thrain, to: .gandalf, note: "in the dungeons of the Necromancer"),
            Transfer(from: .gandalf, to: .thorin, note: "map finally returned to legal heir")]
    )
    
    let artifacts: [Artifact] = [key, map]

    for artifact in artifacts {
        print(artifact)
    }
}
