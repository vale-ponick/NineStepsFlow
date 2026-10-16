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

