//
//  fantasyHikeTrackerAdvanced.swift
//  NineStepsFlow
//
//  Created by Валерия Пономарева on 11.10.2026.
//

import Foundation

// MARK: - Technical S

/** I have daily steps and a goal of 7 km. Convert steps to km (step = 0.7 m). Calculate the delta to the goal—signed. Determine the status with the data inside. */

enum HikeStatus {
    case inProgress(remainingKm: Double, progress: Double)
    case achieved(overTargetKm: Double)
}

struct FantasyHikeAdv {
    let stepCount: Int
    let dailyTargetInKm: Double
    
    static let stepLengthM = 0.7
    static let metersInKm = 1000.0
    
    var distanceKm: Double {
        (Double(stepCount) * Self.stepLengthM) / Self.metersInKm
    }
    
    var status: HikeStatus { 
       let deltaKm = dailyTargetInKm - distanceKm
        
        if deltaKm > 0 {
            return  .inProgress(remainingKm: deltaKm, progress: distanceKm / dailyTargetInKm)
        } else {
            return .achieved(overTargetKm: distanceKm - dailyTargetInKm) // так чище
        }
    }
}

func calculate()  {
    let pathForDay = FantasyHikeAdv(stepCount: 5432, dailyTargetInKm: 7.0)
    print("Completed in a day: \(pathForDay)") // Completed in a day: FantasyHikeAdv(stepCount: 5432, dailyTargetInKm: 7.0)
}

