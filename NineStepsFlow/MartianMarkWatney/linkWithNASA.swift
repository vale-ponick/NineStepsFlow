//
//  linkWithNASA.swift
//  NineStepsFlow
//
//  Created by Валерия Пономарева on 13.11.2026.
//

import Foundation

// Link with NASA (Sol 8)
// Mark Watney repaired the antenna in the Hab to contact NASA. But first he must ALIGN it, and only then SEND messages.
// Mark's possible mistakes:
// - align an antenna that is already aligned — meaningless;
// - send a message when the antenna is not aligned — it won't go through;
// - send an empty message — NASA won't understand;
// - send a 4th message — the buffer holds only 3.

// The Hab computer checks every action and rejects it, if the action is meaningless or dangerous. Mark also needs to check status: is the antenna aligned? how many messages are in the buffer? — without changing anything.

struct EarthLink {
    var isAligned: Bool = false
    var messagesSent: [String] = []
    let maxMessages = 3
    
    mutating func align() {
        guard !isAligned else {
            print("❌ Antenna already aligned")
            return
        }
        isAligned = true
        print("✅ OK! Antenna aligned")
    }
    
    mutating func send(_ text: String) {
        guard isAligned else {
            print("❌ antenna not aligned")
            return
        }
        
        guard !text.isEmpty else {
            print("❌ Message is empty")
            return
        }
        guard messagesSent.count < maxMessages else {
            print("❌ buffer full: \(messagesSent.count) of \(maxMessages)")
            return
        }
        messagesSent.append(text)
        print("✅ It worked! Sent: \(text). Messages: \(messagesSent.count) of \(maxMessages)")
    }
    
    func status() -> String {
        let alignment = isAligned ? "Aligned" : "Not aligned"
        let result = "Antenna: \(alignment), messages: \(messagesSent.count) in \(maxMessages)"
        return result
    }
}

func getEarthLink() {
   var linkMW = EarthLink()
    linkMW.align()
    linkMW.send("I'm alive! Mark Watney")
    linkMW.send("I need help! Mark Watney")
    linkMW.send("I'm in Hab on Mars! Mark Watney")
    linkMW.send("SOS! Mark Watney")
    print(linkMW.status())
}

/**
 ✅ OK! Antenna aligned
 ✅ It worked! Sent: I'm alive! Mark Watney. Messages: 1 of 3
 ✅ It worked! Sent: I need help! Mark Watney. Messages: 2 of 3
 ✅ It worked! Sent: I'm in Hab on Mars! Mark Watney. Messages: 3 of 3
 ❌ buffer full: 3 of 3
 Antenna: Aligned, messages: 3 in 3
 Program ended with exit code: 0
 */
