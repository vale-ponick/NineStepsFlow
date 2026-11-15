//
//  lifeSupportSystem.swift
//  NineStepsFlow
//
//  Created by Валерия Пономарева on 15.11.2026.
//

import Foundation

// MARK: - 📖 Flight Log: Sol 9. Diagnostics 'Life Support System'
//Mark Watney is conducting a full diagnostic of the habitat module's Life Support System. The equipment is worn out, but safety protocols are strict: the system must not crash with a fatal error due to an invalid command. Any invalid request must return a clear description of failure so Mark Watney can make a prompt decision.

enum LifeSupportError: LocalizedError {
    case alreadyPurifying
    case notPurifying
    case invalidAmount(amount: Int) // associated value
    case oxygenTooLow(available: Int, requested: Int) // associated value
    case emptyAlert
    case alertsFull(current: Int, max: Int) // associated value
    
    var errorDescription: String? {
        switch self {
        case .alreadyPurifying:
            return "Filters are already running"
        case .notPurifying:
            return "Filters are not running"
        case .invalidAmount(let amount):
            return "Invalid amount: \(amount). Must be > 0"
        case .oxygenTooLow(let available, let requested):
            return "Not enough oxygen: (\(available)/\(requested))"
        case .emptyAlert:
            return "Alert text is empty"
        case .alertsFull(let current, let max):
            return "Alerts buffer is full: (\(current)/\(max))"
        }
    }
}

struct LifeSupportSystem {
    // 1. Подсистема 'Кислород'
    var oxygen: Int = 100 // current volume - instance property
    let minOxygen: Int = 30 // min emergency reserve - instance property
    
    mutating func consumeOxygen(amount: Int) throws {
        guard amount > 0 else {
            throw LifeSupportError.invalidAmount(amount: amount)
        }
        guard oxygen - amount >= minOxygen else {
            throw LifeSupportError.oxygenTooLow(available: oxygen, requested: amount)
        }
        oxygen -= amount
        print("✅ OK! Oxygen left: \(oxygen) (min \(minOxygen))")
    }
    
    // 2. Подсистема 'Очистка воздуха'
    var isPurifying: Bool = false // filters auto: off
    
    mutating func startPurify() throws {
        guard !isPurifying else {
            throw LifeSupportError.alreadyPurifying
        }
        isPurifying = true
        print("✅ OK! Filters started.")
    }
    
    mutating func stopPurify() throws {
        guard isPurifying else {
            throw LifeSupportError.notPurifying
        }
        isPurifying = false
        print("✅ OK! Filters stopped.")
    }
    
    // 3.  Подсистема 'Журнал предупреждений'
    var alerts: [String] = [] // list of alerts
    let maxAlerts: Int = 3 // instance property
    
    mutating func addAlert(_ text: String) throws {
        guard !text.isEmpty else {
            throw LifeSupportError.emptyAlert
        }
        guard alerts.count < maxAlerts else {
            throw LifeSupportError.alertsFull(current: alerts.count, max: maxAlerts)
        }
        alerts.append(text)
        print("✅ OK! Alerts: \(alerts.count)")
    }
    // 4. Telemetry. Diagnostic screen
    func report() -> String {
        let purifyingStatus = isPurifying ? "yes" : "no"
        return "Current oxygen: \(oxygen) (min \(minOxygen)), purifying: \(purifyingStatus), alerts: \(alerts.count)/\(maxAlerts)"
    }
}

func getLifeSupportSystem() {
    var link = LifeSupportSystem()

    print(link.report())

    do { try link.startPurify() }
    catch { print("❌ \(error.localizedDescription)") }

    do { try link.startPurify() }
    catch { print("❌ \(error.localizedDescription)") }

    do { try link.consumeOxygen(amount: 10) }
    catch { print("❌ \(error.localizedDescription)") }

    do { try link.consumeOxygen(amount: 80) }
    catch { print("❌ \(error.localizedDescription)") }

    do { try link.addAlert("Low O2") }
    catch { print("❌ \(error.localizedDescription)") }

    do { try link.addAlert("Filters check") }
    catch { print("❌ \(error.localizedDescription)") }

    do { try link.addAlert("Pressure drop") }
    catch { print("❌ \(error.localizedDescription)") }

    do { try link.addAlert("Fourth alert") }
    catch { print("❌ \(error.localizedDescription)") }

    do { try link.addAlert("") }
    catch { print("❌ \(error.localizedDescription)") }

    print(link.report())
}

/**
 Current oxygen: 100 (min 30), purifying: no, alerts: 0/3
 ✅ OK! Filters started.
 ❌ Filters are already running
 ✅ OK! Oxygen left: 90 (min 30)
 ❌ Not enough oxygen: (90/80)
 ✅ OK! Alerts: 1
 ✅ OK! Alerts: 2
 ✅ OK! Alerts: 3
 ❌ Alerts buffer is full: (3/3)
 ❌ Alert text is empty
 Current oxygen: 90 (min 30), purifying: yes, alerts: 3/3
 Program ended with exit code: 0
 */
