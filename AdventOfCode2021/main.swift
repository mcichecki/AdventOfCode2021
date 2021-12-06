//
//  main.swift
//  AdventOfCode2021
//
//  Created by Michal Cichecki on 29/11/2021.
//

import Foundation

let days: [Day] = [
    Day01(),
    Day02(),
    Day03(),
    Day04(),
    Day05(),
    Day06()
]

days.forEach { day in
    print("Day #\(day.dayNumber)")
    Benchmark.execute(part: .one) { day.part1() }
    Benchmark.execute(part: .two) { day.part2() }
}
