//
//  Day02.swift
//  AdventOfCode2021
//
//  Created by Michal Cichecki on 02/12/2021.
//

import Foundation

struct Day02: Day {
    let dayNumber = 2

    enum Command: String {
        case forward
        case up
        case down
    }

    func part1() -> Any {
        let commands = InputReader.read(fileName: "day02_1")

        var forwardValue = 0
        var verticalValue = 0

        commands.forEach {
            let parts = $0.components(separatedBy: " ")
            guard let command = Command(rawValue: parts[0]),
                  let value = Int(parts[1])
            else { return }

            switch command {
            case .forward:
                forwardValue += value
            case .up, .down:
                verticalValue += value * command.direction
            }
        }

        return forwardValue * verticalValue
    }

    func part2() -> Any {
        ""
    }
}

extension Day02.Command {
    var direction: Int {
        switch self {
        case .forward, .down: return 1
        case .up: return -1
        }
    }
}
