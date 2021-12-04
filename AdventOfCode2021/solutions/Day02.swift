//
//  Day02.swift
//  AdventOfCode2021
//
//  Created by Michal Cichecki on 02/12/2021.
//

import Foundation

struct Day02: Day {
    enum Command: String {
        case forward
        case up
        case down
    }

    let dayNumber = 2
    let commands = InputReader.read(fileName: "day02_1")

    func part1() -> Int {
        var forwardValue = 0
        var verticalValue = 0

        parseCommands(commands: commands).forEach { command, value in
            switch command {
            case .forward:
                forwardValue += value
            case .up, .down:
                verticalValue += value * command.direction
            }
        }

        return forwardValue * verticalValue
    }

    func part2() -> Int {
        var forwardValue = 0
        var depth = 0
        var aim = 0

        parseCommands(commands: commands).forEach { command, value in
            switch command {
            case .forward:
                forwardValue += value
                depth += aim * value
            case .up, .down:
                aim += value * command.direction
            }
        }

        return forwardValue * depth
    }
}

extension Day02 {
    private func parseCommands(commands: [String]) -> [(Command, Int)] {
        commands.compactMap {
            let parts = $0.components(separatedBy: " ")
            guard let command = Command(rawValue: parts[0]),
                  let value = Int(parts[1])
            else { return nil }

            return (command, value)
        }
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
