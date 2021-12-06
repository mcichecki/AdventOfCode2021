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
        var occurancesDict: [Int: Int] = [:]
        ages.forEach {
            occurancesDict[$0, default: 0] += 1
        }

        (0 ..< days).forEach { _ in
            var newCount = 0
            occurancesDict.forEach { value, valuesCount in
                if value == 0 {
                    newCount += 1
                    occurancesDict[8, default: 0] += valuesCount
                    occurancesDict[6, default: 0] += valuesCount
                    occurancesDict[0, default: 0] -= valuesCount
                } else {
                    // swapping the value of the value reduced by one and updating current value by subtracting number of occurances
                    occurancesDict[value - 1] = occurancesDict[value - 1, default: 0] + valuesCount
                    occurancesDict[value, default: 0] -= valuesCount
                }
            }
        }

        return occurancesDict.reduce(0) { partialResult, x in
            partialResult + x.value
        }
    }

    fileprivate func getAges() -> [Int] {
        guard input.count == 1,
              let first = input.first
        else { return [] }
        return first.asInts(separatedBy: ",")
    }
}
