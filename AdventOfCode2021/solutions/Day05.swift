//
//  Day05.swift
//  AdventOfCode2021
//
//  Created by Michal Cichecki on 05/12/2021.
//

import Foundation

struct Day05: Day {
    let dayNumber = 5

    struct Point: Hashable {
        var x, y: Int
    }

    let rawLinesOfVents = InputReader.read(fileName: "day05")

    func part1() -> Int {
        let points = parsePoints(rawLines: rawLinesOfVents)
        let filteredPoints = points
            .filter { $0.x == $1.x || $0.y == $1.y }

        return getOverlapCount(points: filteredPoints)
    }

    func part2() -> Int {
        let points = parsePoints(rawLines: rawLinesOfVents)
        return getOverlapCount(points: points)
    }
}

extension Day05 {
    private func parsePoints(rawLines: [String]) -> [(starting: Point, ending: Point)] {
        rawLines.compactMap { line -> (Point, Point)? in
            let sanitized = line.replacingOccurrences(of: " -> ", with: ",")
            let numbers = sanitized.components(separatedBy: ",").compactMap(Int.init)
            guard numbers.indices.contains(3) else { return nil }
            return (Point(x: numbers[0], y: numbers[1]), Point(x: numbers[2], y: numbers[3]))
        }
    }

    private func getOverlapCount(points: [(Point, Point)]) -> Int {
        var occurances: [Point: Int] = [:]

        for point in points {
            // vertical line
            if point.0.x == point.1.x {
                let verticalRange = point.0.y > point.1.y ? point.1.y ... point.0.y : point.0.y ... point.1.y
                for verticalPoint in verticalRange {
                    occurances[Point(x: point.0.x, y: verticalPoint), default: 0] += 1
                }
                continue
            }

            // horizontal line
            if point.0.y == point.1.y {
                let horizontalRange = point.0.x > point.1.x ? point.1.x ... point.0.x : point.0.x ... point.1.x
                for horizontalPoint in horizontalRange {
                    occurances[Point(x: horizontalPoint, y: point.0.y), default: 0] += 1
                }
                continue
            }

            // diagonal line
            let xDiff = point.1.x - point.0.x
            let yDiff = point.1.y - point.0.y

            var diagonalXPoints: [Int] = []
            var xIndex = 0
            while diagonalXPoints.count < abs(xDiff) + 1 {
                diagonalXPoints.append(point.0.x + (xDiff > 0 ? 1 : -1) * xIndex)
                xIndex += 1
            }
            var diagonalYPoints: [Int] = []
            var yIndex = 0
            while diagonalYPoints.count < abs(xDiff) + 1 {
                diagonalYPoints.append(point.0.y + (yDiff > 0 ? 1 : -1) * yIndex)
                yIndex += 1
            }

            zip(diagonalXPoints, diagonalYPoints).forEach {
                occurances[Point(x: $0.0, y: $0.1), default: 0] += 1
            }
        }

        return occurances
            .filter { $0.value > 1 }
            .count
    }
}
