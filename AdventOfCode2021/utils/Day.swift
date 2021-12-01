//
//  Day.swift
//  AdventOfCode2021
//
//  Created by Michal Cichecki on 01/12/2021.
//

import Foundation

enum Part: String {
    case one = "part 1"
    case two = "part 2"
}

protocol Day {
    static var dayNumber: Int { get }
    static func printSolution(part: Part, solution: Any)
}

extension Day {
    static func printSolution(part: Part, solution: Any) {
        print("Day #\(Self.dayNumber) (\(part.rawValue)) | solution: \(solution)")
    }
}
