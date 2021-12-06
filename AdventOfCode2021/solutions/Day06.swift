//
//  Day06.swift
//  AdventOfCode2021
//
//  Created by Michal Cichecki on 06/12/2021.
//

import Foundation

final class Day06: Day {
    let dayNumber = 6

    private let input = InputReader.read(fileName: "day06")


    func part1() -> Int {
        let daysCount = 80
        let ages = (0 ..< daysCount)
            .reduce(getAges()) { result, _ in
                var newAges: [Int] = []
                var newCount = 0
                result.forEach {
                    if $0 == 0 {
                        newCount += 1
                        newAges.append(6)
                    } else {
                        newAges.append($0 - 1)
                    }
                }
                newAges.append(contentsOf: Array(repeating: 8, count: newCount))
                return newAges
            }

        return ages.count
    }

    func part2() -> Int {
        .max
    }
}

extension Day06 {
    fileprivate func getAges() -> [Int] {
        guard input.count == 1,
              let first = input.first
        else { return [] }
        return first.asInts(separatedBy: ",")
    }
}
