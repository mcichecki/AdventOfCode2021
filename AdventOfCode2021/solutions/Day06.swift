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
        getFishesCount(ages: getAges(), days: 80)
    }

    func part2() -> Int {
        getFishesCount(ages: getAges(), days: 256)
    }
}

extension Day06 {
    private func getFishesCount(
        ages: [Int],
        days: Int
    ) -> Int {
        var occurances = Array(repeating: 0, count: 9)
        ages.forEach { occurances[$0] += 1 }

        (0 ..< days).forEach { _ in
            occurances.enumerated().forEach { index, valuesCount in
                if index == 0 {
                    occurances[0] -= valuesCount
                    occurances[8] += valuesCount
                    occurances[6] += valuesCount
                } else {
                    // swapping the value of the value reduced by one and updating current value by subtracting number of occurances
                    occurances[index - 1] = occurances[index - 1] + valuesCount
                    occurances[index] -= valuesCount
                }
            }
        }

        return occurances.reduce(0, +)
    }

    fileprivate func getAges() -> [Int] {
        guard input.count == 1,
              let first = input.first
        else { return [] }
        return first.asInts(separatedBy: ",")
    }
}
