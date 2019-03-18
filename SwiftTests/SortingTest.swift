//
//  BinarySearchTest.swift
//  SwiftStructures
//
//  Created by Wayne Bishop on 9/23/14.
//  Copyright (c) 2014 Arbutus Software Inc. All rights reserved.
//

import UIKit
import XCTest
import GameKit

@testable import SwiftStructures


/*
 notes: this test class adopts the Sortable protocol.
 the isSorted function originates from the protocol extension.
*/

// size of [Int] array to test sorting algorithms
public enum ArraySize: Int {
    case k1 = 1000
    case k2 = 2000
    case k10 = 10_000
    case k20 = 20_000
    case k100 = 100_000
    case k200 = 200_000
    case m1 = 1_000_000
}

class SortingTest: XCTestCase, Sortable {
    
    let duplicatesRatio = 0.9
    
    //test input types for algorithms
    var numberList = [8, 2, 10, 9, 7, 5]
    var searchList = [0,4,7,9,13,16,34]
    var trivialNumberList = [1]
    var emptyNumberList: Array<Int> = []
    var textList = ["Dog", "Cat", "Dinasour", "Lion", "Cheetah", "Gazelle", "Elephant", "Aardvark"]
    var triviaTextList = ["Dog"]
    var emptyTextList: Array<String> = []
    
    //string extension
    var dateList: Array<Date> = ["12-10-2016".datevalue, "12-08-2016".datevalue, "12-09-2016".datevalue]
    
    
    override func setUp() {
        super.setUp()
    }
    
    func testLongestSequence() {
        
        let list = [0,1,0,1,1,1,0,1,1,1,1,1]
        let results = list.longestSequence(of: 1)
        
        print("the longest sequence is \(results)")        
    }

    
    //MARK: - Binary Search Algorithms
    

    func testBinarySearch() {
        
        var searchList = Array<Int>()
        let key: Int = 235

        
        //populate collection..
        for number in 0...500 {
            searchList.append(number)
        }
        
        
        XCTAssertTrue(self.isSorted(searchList), "search list of values not sorted..")
        
        
        //perform test search
        XCTAssertTrue(searchList.binarySearch(forElement: key), "binary key value \(key) not found..")
        
    }

    
    func testBinaryNotFound() {
        
        let key: Int = 8
        
        //test for false positive
        XCTAssertFalse(searchList.binarySearch(forElement: key), "binary key value \(key) found..")
    }
   
    
    func testBinaryFound() {
        
        let key: Int = 9
        
        XCTAssertTrue(searchList.binarySearch(forElement: key), "binary key value \(key) not found..")
    }
    

    //MARK: General Sorting Algorithms
    
    
    func testInsertionSort() {
        
        XCTAssertTrue(isSorted(numberList.insertionSort()))
        XCTAssertTrue(isSorted(trivialNumberList.insertionSort()))
        XCTAssertTrue(isSorted(emptyNumberList.insertionSort()))
        XCTAssertTrue(isSorted(textList.insertionSort()))
        XCTAssertTrue(isSorted(triviaTextList.insertionSort()))
        XCTAssertTrue(isSorted(emptyTextList.insertionSort()))
        XCTAssert(isSorted(dateList.insertionSort()))
    }
    
    
    
    func testBubbleSort() {
        
        XCTAssertTrue(isSorted(numberList.bubbleSort()))
        XCTAssertTrue(isSorted(trivialNumberList.bubbleSort()))
        XCTAssertTrue(isSorted(emptyNumberList.bubbleSort()))
        XCTAssertTrue(isSorted(textList.bubbleSort()))
        XCTAssertTrue(isSorted(triviaTextList.bubbleSort()))
        XCTAssertTrue(isSorted(emptyTextList.bubbleSort()))
        XCTAssert(isSorted(dateList.bubbleSort()))
        
    }

    
    
    func testSelectionSort() {
        
        XCTAssertTrue(isSorted(numberList.selectionSort()))
        XCTAssertTrue(isSorted(trivialNumberList.selectionSort()))
        XCTAssertTrue(isSorted(emptyNumberList.selectionSort()))
        XCTAssertTrue(isSorted(textList.selectionSort()))
        XCTAssertTrue(isSorted(triviaTextList.selectionSort()))
        XCTAssertTrue(isSorted(emptyTextList.selectionSort()))
        XCTAssert(isSorted(dateList.selectionSort()))
        
    }
    
    func testQuickSortDifferentTypesArrays() {
        
        XCTAssertTrue(isSorted(numberList.quickSort()))
        XCTAssertTrue(isSorted(trivialNumberList.quickSort()))
        XCTAssertTrue(isSorted(emptyNumberList.quickSort()))
        XCTAssertTrue(isSorted(textList.quickSort()))
        XCTAssertTrue(isSorted(triviaTextList.quickSort()))
        XCTAssertTrue(isSorted(emptyTextList.quickSort()))
        
    }
    
    func testQuickSort() {
        
        let arrayToSort = Array(1...ArraySize.k10.rawValue)
        
        var shuffledArray = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: arrayToSort) as! [Int]
        
        let start = Date()
        
        print("Start to sort")
        let sortedArr = shuffledArray.quickSort()
        
        let timePassed = Date().timeIntervalSince(start)
        
        print("timePassed = \(timePassed)")
        
        XCTAssertTrue(isSorted(sortedArr))
        
        // O(n log n)
        // 1000     - 0.008
        // 10_000    - 0.083
        // 100_000   - 0.956
        // 1_000_000  - 11.570
        
    }
    
    func testQuickSortWithDuplicates() {
        
        let arraySize = ArraySize.k1.rawValue
        
        let arrWithDuplicates = Array<Int>(repeating: 100, count: Int(Double(arraySize) * duplicatesRatio))
        
        var arrNonDuplicates = [Int]()
        if duplicatesRatio != 1.0 {
            arrNonDuplicates = Array(101...100 + arraySize - arrWithDuplicates.count)
        }
        
        let arr = arrWithDuplicates + arrNonDuplicates
        
        var shuffledArray = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: arr) as! [Int]
        
        let start = Date()
        
        print("Start to sort")
        
        let sortedArr = shuffledArray.quickSort()
        
        let timePassed = Date().timeIntervalSince(start)
        
        print("timePassed = \(timePassed)")
        
        XCTAssertTrue(isSorted(sortedArr))
        
        // O(n log n)
        // 1000     - 0.089
        // 2000     - 0.425
        // 10_000    - 8.796
        
    }
    
    func testQuickSortAlreadySortedArray() {
        var arr = Array(1...ArraySize.k1.rawValue)
        
        let start = Date()
        
        print("Start to sort")
        
        let sortedArr = arr.quickSort()
        
        let timePassed = Date().timeIntervalSince(start)
        
        print("timePassed = \(timePassed)")
        
        XCTAssertTrue(isSorted(sortedArr))
        
        // O(n²)
        // 1000     - 0.131
        // 2000     - 0.398
        // 10_000    - 8.918
        
    }
    
    
    
    
}
