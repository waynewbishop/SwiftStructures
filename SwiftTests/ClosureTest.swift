//
//  ClosureTest.swift
//  SwiftStructures
//
//  Created by Wayne Bishop on 6/1/15.
//  Copyright (c) 2015 Arbutus Software Inc. All rights reserved.
//

import UIKit
import XCTest

@testable import SwiftStructures


//MARK:  custom operator


/* 
notes: infix class operator to represent exponent operation
single carat symbol reserved for XOR bit manipulation
*/


infix operator ^^ {}

func ^^(base: Int, power: Int) -> Int {
    
    //rounded to nearest int
    let results: Double = round(pow(Double(base), Double(power)))
    return Int(results)
}



class ClosureTest: XCTestCase {

    var numberList: Array<Int> = [8, 5, 2, 10, 9, 7]
    
    /*
    notes: This test class mimics the map & filter array
    functions found in the Swift standard library. Optimized for linked lists, each test
    demonstrates the nessesary syntax to implement a closure as an inline expression or standard function.
    See additional closure examples with GraphTest.swift and AVLTest.swift.
    */
    
    
    //MARK: filter closures
    
    
    //filter based on expression
    func testLinkFilterExpression() {
        
        let linkedList: LinkedList<Int> = [8, 2, 10, 9, 7, 5]
        
        
        //inline closure expression
        let results: LinkedList<Int>? = linkedList.filter { (node: Int) -> Bool in
            return node > 5
        }
        
        //display filtered results
        results?.printAllKeys()
        
        if results?.count == linkedList.count {
            XCTFail("linked list not filtered..")
        }
        
        
    }
    
    
    //filter based on function
    func testLinkFilterFunction() {
        
        let linkedList: LinkedList<Int> = [8, 2, 10, 9, 7, 5]

        //pass formula as parameter
        let results: LinkedList<Int>? = linkedList.filter(filterFormula)
        
        //print results
        results?.printAllKeys()
        
        if results?.count == linkedList.count {
            XCTFail("linked list not filtered..")
        }
        
        
    }


    
    //MARK: map closures

    
    //map based on expression
    func testLinkMapExpression() {

        let linkedList: LinkedList<Int> = [8, 2, 10, 9, 7, 5]
        
        //inline closure expression
        let results: LinkedList<Int> = linkedList.map { (node: Int) -> Int in

            var value: Int
            
            //evaluate based on switch
            switch node {
                case 0..<5:
                    value = node * 2
                case 5...10:
                    value = node * 3
                default:
                    value = node
            }
            
            return value
            
            
        } //end closure

        
        //print results
        results.printAllKeys()

        
        //iterate and compare values
        for s in 0..<numberList.count {
            if try! linkedList.linkAtIndex(s).key == results.linkAtIndex(s).key {
                XCTFail("linked list map formula not applied..")
            }
        }
        
        
    }
    


    
    
    

    //map based on function
    func testLinkMapFunction() {
        
        let linkedList: LinkedList<Int> = [8, 2, 10, 9, 7, 5]
        
        //pass formula as parameter
        let results: LinkedList<Int> = linkedList.map(mapFormula)
        
        //print results
        results.printAllKeys()

        
        //iterate and compare values
        for s in 0..<numberList.count {
            if try! linkedList.linkAtIndex(s).key == results.linkAtIndex(s).key {
                XCTFail("linked list map formula not applied..")
            }
        }
        
        
    }
    
    
    
    //MARK: helper functions
    
    
    //function to be passed as a parameter
    func filterFormula(node: Int) -> Bool {
        return node > 5
    }

    
    
    //function to be passed as a parameter
    func mapFormula(node: Int) -> Int {
        
        var value: Int
        
        //evaluate based on switch
        switch node {
        case 0..<5:
            value = node * 2
        case 5...10:
            value = node * 3
        default:
            value = node
        }
        
        return value

        
    }
}
