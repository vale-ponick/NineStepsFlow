//
//  marsEarthLink.swift
//  NineStepsFlow
//
//  Created by Валерия Пономарева on 14.11.2026.
//

import Foundation

enum EarthLinkError: LocalizedError {
    case alreadyPointedAtEarth
    case notPointedAtEarth
    case emptyMarsTransmission
    case bufferFull(current: Int, max: Int)
    
    var errorDescription: String? {
        switch self {
        case .alreadyPointedAtEarth:
            return "High-gain antenna 'Pathfinder' already pointed at Earth"
        case .notPointedAtEarth:
            return "High-gain antenna 'Pathfinder' not pointed at Earth"
        case .emptyMarsTransmission:
            return "Transmission from Mark Watney to NASA is empty"
        case .bufferFull(let current, let max):
            return "Transmission buffer is full (\(current)/\(max) packets)."
        }
    }
}

struct MarsEarthLink {
    let maxComms: Int = 3
    var marsTransmissions: [String] = []
    var isPointedAtEarth: Bool = false
    
    mutating func pointAtEarth() throws {
        guard !isPointedAtEarth else {
            throw EarthLinkError.alreadyPointedAtEarth
        }
        isPointedAtEarth = true
        print("✅ OK! High-gain antenna 'Pathfinder' successfully pointed at Earth")
        
    }
        
    mutating func transmit(_ marsComm: String) throws {
        guard isPointedAtEarth else {
            throw EarthLinkError.notPointedAtEarth
        }
        
        guard !marsComm.isEmpty else {
            throw EarthLinkError.emptyMarsTransmission
        }
        guard marsTransmissions.count < maxComms else {
            throw EarthLinkError.bufferFull(current: marsTransmissions.count, max: maxComms)
        }
        marsTransmissions.append(marsComm)
        print("✅ It worked! Sent: \(marsComm) Messages: \(marsTransmissions.count) of \(maxComms)")
    }
    
    func status() -> String {
        let alignment = isPointedAtEarth ? "Pointed at Earth" : "Not pointed at Earth"
        let result = "High-gain antenna 'Pathfinder': \(alignment), messages: \(marsTransmissions.count) in \(maxComms)"
        return result
    }
}

func getMarsEarthLink () {
    var link = MarsEarthLink ()
    do {
        try link.pointAtEarth()
        try link.transmit("I'm alive!")
        try link.transmit("I need help!")
        try link.transmit("I'm in Hab!")
        try link.transmit("SOS!")
    } catch {
        print("❌ \(error.localizedDescription)")
    }
    print(link.status())
}

/**
 ✅ OK! High-gain antenna 'Pathfinder' successfully pointed at Earth
 ✅ It worked! Sent: I'm alive! Messages: 1 of 3
 ✅ It worked! Sent: I need help! Messages: 2 of 3
 ✅ It worked! Sent: I'm in Hab! Messages: 3 of 3
 ❌ Transmission buffer is full (3/3 packets).
 High-gain antenna 'Pathfinder': Pointed at Earth, messages: 3 in 3
 Program ended with exit code: 0
 */
