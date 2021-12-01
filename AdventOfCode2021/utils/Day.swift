//
//  Day.swift
//  AdventOfCode2021
//
//  Created by Michal Cichecki on 01/12/2021.
//

import Foundation

enum Part: Int {
    case one = 1
    case two = 2
}

protocol Day {
    var dayNumber: Int { get }

    // TODO: is anwear always Int?
    func part1() -> Any
    func part2() -> Any
}
