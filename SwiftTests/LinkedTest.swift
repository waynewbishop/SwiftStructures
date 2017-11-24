//
//  LinkedTest.swift
//  SwiftStructures
//
//  Created by Wayne Bishop on 9/23/14.
//  Copyright (c) 2014 Arbutus Software Inc. All rights reserved.
//

import UIKit
import XCTest

@testable import SwiftStructures


//struct for testing indicies
struct keyIndex {
    
    public var key: Int
    public var index: Int
}



class LinkedTest: XCTestCase {
    
    var numberList : Array<Int>!
    
    
    override func setUp() {
        super.setUp()
        numberList = [8, 2, 10, 9, 7, 5]
    }
        
    //retrieve specific links
    func testLinkAtIndex() {
        
        
        let list = buildLinkedList()
        let nodecount: Int = list.count

        
        //test lower-bound
        let lbound = list[0]
        if ((lbound == nil) || (lbound?.key != numberList[0])) {
            XCTFail("lowest bound retrieve fail..")
        }
        
        
        //upper bound
        let ubound = list[nodecount - 1]
        if ((ubound == nil) || (ubound?.key != numberList[nodecount - 1])) {
          XCTFail("upper bound retrieve fail..")
        }
        
        
        //establish random index
        let range: UInt32 = UInt32(numberList.count)
        let randomIndex = Int(arc4random_uniform(range))
        

        //retrieve random index
        let randomlink = list[randomIndex]
        if ((randomlink == nil) || (randomlink?.key != numberList[randomIndex])) {
            XCTFail("random index retrieve fail..")
        }
        
    }
    
   
    

    //test nodes at a specific index
    func testAddLinkAtIndex() {

        
        //create list and test pair
        let list = buildLinkedList()
        let testPair: keyIndex = keyIndex(key: 4, index: 3)
        
        
        list.insert(testPair.key, at: testPair.index)
        list.printAllKeys()
        
        
        let current = list[testPair.index]
        
        //test condition
        if current == nil || current?.key != testPair.key {
            XCTFail("linked list addition at index failed..")
        }
        
        
        //remove test item
        list.remove(at: testPair.index)
        list.printAllKeys()
        
        
        //retrieve value at same position
        let removed = list[testPair.index] as LLNode!
        
        
        if removed == nil || removed?.key == testPair.key {
            XCTFail("test failed: removed linked list element not found")
        }
        
        // test insertion to non valid index
        let counter = list.count
        
        list.insert(25, at: -1)
        list.printAllKeys()
        
        if counter != list.count {
            XCTFail("test failed: Counter mismatch after instertion")
        }
        
        // test removing node at index 0
        list.remove(at: 0)
        list.printAllKeys()
        
        if list.count != counter - 1 {
            XCTFail("test failed: Counter mismatch after removing node at index 0")
        }
        
        
    } //end function
    

    

    //reverse a linked list
    func testReverseLinkedList() {
        
        let list = buildLinkedList()

        
        //find (subscript) syntax
        guard let flink = list[0] else {
            XCTFail("link for reversal not found..")
            return
        }
        
        //reverse the list
        list.reverse()
        list.printAllKeys()
        
        
        if let blink = list[0] {
            
            //evaluate keys
            if (flink.key == blink.key) {
                XCTFail("reversed list failed..")
            }
        }
    }

    

    //MARK: helper functions
    
    
    func buildLinkedList() ->LinkedList<Int> {
        
        let list = LinkedList<Int>()
        
        //append items
        for number in numberList {
            list.append(element: number)
        }
        
        
       list.printAllKeys()
       XCTAssertFalse(list.count != numberList.count, "test failed: linked list count doesn't match number list..")
        
       return list
    }
    
}
