//
//  main.swift
//  AdventOfCode2021
//
//  Created by Michal Cichecki on 29/11/2021.
//

import Foundation

print("Running")

let days: [Day] = [
    Day01()
]

days.forEach {
    print("Day #\($0.dayNumber)")

    $0.part1()
    $0.part2()
    
    print("\n")
}
