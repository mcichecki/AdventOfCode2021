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
    var dayNumber: Int { get }

    func part1()
    func part2()
    func printSolution(part: Part, solution: Any)
}

extension Day {
    func printSolution(part: Part, solution: Any) {
        print("- Day #\(dayNumber) (\(part.rawValue)) | solution: \(solution)")
    }
}
