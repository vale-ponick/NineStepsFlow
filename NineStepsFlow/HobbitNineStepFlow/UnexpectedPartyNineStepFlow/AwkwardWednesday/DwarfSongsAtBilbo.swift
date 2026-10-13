//
//  DwarfSongsAtBilbo.swift
//  NineStepsFlow
//
//  Created by Валерия Пономарева on 13.10.2026.
//

import Foundation

// MARK: - "Dwarf Songs at Bilbo's" - Simple

//🎬 Plot: After dinner, the 12 dwarves clear the table, wash the dishes, and sing a humorous song together. Thorin smokes with Gandalf. Then, together, playing their instruments, they sing a mysterious ballad about lost treasures.

// 🛠 Task: Create a CompanyMember array, a Member structure storing properties (name, race, instrument), and a Song structure with properties (number of singers, song genre, and content - verses). Write a function that will output information to the console (string / block) - who sings + what song and its lyrics.

/**
    1️⃣ Create structures `CompanyMember` (properties: name, race, instrument) and `Song` (properties: songGenre, verses: [String]). Create an enum `SongGenre` for song genres.
    3️⃣ Create an extension for `Song` with a computed property `description` that uses a `switch` statement over `songGenre` to format the song header.
    4️⃣ Create an array of CompanyMembers. In your output function, process data using arrays, `.joined(separator:)` to combine strings, and `.enumerated()` to number the verses.
    5️⃣ Use the `description` property from your extension to print a clean text block to the console containing the singers, instruments, and the numbered lyrics.
*/
// MARK: - Protocols
// Применили протокол: теперь все, кто его подписывают, обязаны отдать краткую сводку о себе
protocol Describable { // договор, которому все соответствуют/подписаны
    var summary: String { get }
}
// MARK: - Enums

enum RaceGuest: String {
    case dwarf = "dwarf"
    case hobbit = "hobbit"
    case wizard = "wizard"
}

enum GuestsAtBilbo: String {
    case bilbo, gandalf, thorin, balin, dwalin, fili, kili
    
    var description: String {
        switch self {
        case .bilbo: return "Bilbo Baggins"
        case .gandalf: return "Gandalf the Gray"
        case .thorin: return "Thorin Oakenshield"
        case .balin: return "Balin, oldish dwarf - warrior"
        case .dwalin: return "Dwalin, brother of Balin"
        case .fili: return "Fili, yonger dwarf"
        case .kili: return "Kili, brother Fili"
        }
    }
}

enum QualityGuests: String {
    case smokePipe, washesDishes, singSongs, playMusicalInstrument
    
    var displayQuality: String {
        switch self {
        case .smokePipe: return "smoke Pipe"
        case .washesDishes: return "washes dishes"
        case .singSongs: return "sings songs"
        case .playMusicalInstrument: return "play musical instrument"
        }
    }
}

enum SongGenre: String {
    case joke = "a short, funny, comic song"
    case ballad = "mysterious song of the gnomes"
}
// MARK: - Instrument

enum Instrument: String { // точно! структура и + и + и! а enum или/или/или
    case violin = "violin"
    case flute = "flute"
    case clarinet = "clarinet"
    case drum = "drum"
    case harp = "harp"
    case viola = "viola"
}
// MARK: - Song
struct Song {
    let title: String
    let songGenre: SongGenre
    let verses: [String]
    let singers: [GuestsAtBilbo]
    
    var numberOfSingers: Int {
            return singers.count
    }
}

// Выполняем пункт 3️⃣: только красивый заголовок через switch
extension Song: CustomStringConvertible {
    var description: String {
        switch self.songGenre {
        case .ballad:
            return "🎵 BALLAD: \(title.uppercased()) 🎵"
        case .joke:
            return "🎭 JOKE: \(title.uppercased()) 🎭"
        }
    }
}

// MARK: - CompanyMember

struct CompanyMember: CustomStringConvertible, Describable {
    let name: GuestsAtBilbo
    let race: RaceGuest
    let qualities: [QualityGuests]
    let instrument: Instrument?
    
    var summary: String { // Реализация протокола Describable
        let instrumentLine = instrument?.rawValue ?? "no instrument"
        return "\(name.description) (\(race.rawValue)) with \(instrumentLine)"
    }
    
    var description: String {
        let qualitiesLine = qualities
            .map { $0.displayQuality }
            .joined(separator: ", ")
        
        return "\(summary) — \(qualitiesLine)"
    }
}

// MARK: - Run

    func printSongDetails(song: Song, company: [CompanyMember]) {
        print(song)
        print("Singers count: \(song.numberOfSingers)")
        
        // И справлено: убираем слэши перед $0
        let activeInstruments = company
            .filter { song.singers.contains($0.name) }
            .compactMap { $0.instrument?.rawValue }
            .joined(separator: ", ")
        
        print("Instruments playing: \(activeInstruments.isEmpty ? "none" : activeInstruments)")
        
        // Исправлено: убираем слэши перед $0
        let singersLine = song.singers.map { $0.description }.joined(separator: ", ")
        print("🎤 \(singersLine)")
        
        print("\nLyrics:")
        // Исправлено: убираем слэши перед $0
        let versesBlock = song.verses
            .enumerated()
            .map { "\($0.offset + 1). \($0.element)" }
            .joined(separator: "\n")
        
        print(versesBlock)
        print("──────────────────────────────\n")
    }

// Главная функция-дирижер (Запуск программы)
func runDwarfSings() {
    let company: [CompanyMember] = [
        CompanyMember(name: .thorin, race: .dwarf, qualities: [.playMusicalInstrument, .singSongs, .smokePipe], instrument: .harp),
        CompanyMember(name: .balin, race: .dwarf, qualities: [.playMusicalInstrument, .singSongs, .smokePipe, .washesDishes], instrument: .clarinet),
        CompanyMember(name: .dwalin, race: .dwarf, qualities: [.playMusicalInstrument, .singSongs, .smokePipe, .washesDishes], instrument: .clarinet),
        CompanyMember(name: .fili, race: .dwarf, qualities: [.playMusicalInstrument, .singSongs, .washesDishes], instrument: .flute),
        CompanyMember(name: .kili, race: .dwarf, qualities: [.playMusicalInstrument, .singSongs, .washesDishes], instrument: .flute),
        CompanyMember(name: .bilbo, race: .hobbit, qualities: [.smokePipe], instrument: nil),
        CompanyMember(name: .gandalf, race: .wizard, qualities: [.smokePipe], instrument: nil)
    ]
    
    let ballad = Song(
        title: "Far Over the Misty Mountains Cold",
        songGenre: .ballad,
        verses: [
            "Far over the misty mountains cold",
            "To dungeons deep and caverns old",
            "We must away, ere break of day",
            "To seek the pale enchanted gold."
        ],
        singers: [.thorin, .balin, .dwalin]
    )

    let joke = Song(
        title: "Chip the Glasses and Crack the Plates",
        songGenre: .joke,
        verses: [
            "Chip the glasses and crack the plates!",
            "Blunt the knives and bend the forks!",
            "That's what Bilbo Baggins hates —",
            "Smash the bottles and burn the corks!"
        ],
        singers: [.balin, .dwalin, .fili, .kili]
    )
    
    print("─── Company Members ───")
    for member in company {
        print(member) // Работает CustomStringConvertible
    }
    print("\n")

    print("─── Concert Start ───\n")
    // Вызываем нашу новую изолированную функцию для каждой песни
    printSongDetails(song: ballad, company: company)
    printSongDetails(song: joke, company: company)
}
/**
 ─── Company Members ───
 Thorin Oakenshield (dwarf) with harp — play musical instrument, sings songs, smoke Pipe
 Balin, oldish dwarf - warrior (dwarf) with clarinet — play musical instrument, sings songs, smoke Pipe, washes dishes
 Dwalin, brother of Balin (dwarf) with clarinet — play musical instrument, sings songs, smoke Pipe, washes dishes
 Fili, yonger dwarf (dwarf) with flute — play musical instrument, sings songs, washes dishes
 Kili, brother Fili (dwarf) with flute — play musical instrument, sings songs, washes dishes
 Bilbo Baggins (hobbit) with no instrument — smoke Pipe
 Gandalf the Gray (wizard) with no instrument — smoke Pipe


 ─── Concert Start ───

 🎵 BALLAD: FAR OVER THE MISTY MOUNTAINS COLD 🎵
 Singers count: 3
 Instruments playing: harp, clarinet, clarinet
 🎤 Thorin Oakenshield, Balin, oldish dwarf - warrior, Dwalin, brother of Balin

 Lyrics:
 1. Far over the misty mountains cold
 2. To dungeons deep and caverns old
 3. We must away, ere break of day
 4. To seek the pale enchanted gold.
 ──────────────────────────────

 🎭 JOKE: CHIP THE GLASSES AND CRACK THE PLATES 🎭
 Singers count: 4
 Instruments playing: clarinet, clarinet, flute, flute
 🎤 Balin, oldish dwarf - warrior, Dwalin, brother of Balin, Fili, yonger dwarf, Kili, brother Fili

 Lyrics:
 1. Chip the glasses and crack the plates!
 2. Blunt the knives and bend the forks!
 3. That's what Bilbo Baggins hates —
 4. Smash the bottles and burn the corks!
 ──────────────────────────────

 Program ended with exit code: 0
 */
