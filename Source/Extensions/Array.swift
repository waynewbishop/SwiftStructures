 //
//  Array.swift
//  SwiftStructures
//
//  Created by Wayne Bishop on 7/1/16.
//  Copyright © 2016 Arbutus Software Inc. All rights reserved.
//

import Foundation


extension Array where Element: Comparable {

        
        //determines the longest sequence of specified values
    func longestSequence(of key: Element) -> Int {
            
            //initial values
            var current: Element
            var counter: Int = 0
            var longest: Int = 0
            
            //iterate through list - O(n)
            for s in self {
                
                //current iteration
                current = s
                
                if current == key {
                    counter += 1
                }
                else {
                    counter = 0
                }
                
                //preserve the longest sequence
                if counter >= longest {
                    longest = counter
                }
            }
            
            //return count results
            return longest
            
        }
    
    
    //MARK: Index Operation
    
    
    //returns middle index
    func midIndex() -> Index {
        return startIndex + (count / 2)
    }
    
    
    //MARK: - Binary Search
    
    
    /*
     binary search algorithm. Find the value at a specified index.
     note the use array slicing to adjust the upper and lower array bounds.
     returns true if the key was found in the sequence. Average performance‎: ‎O(log n).
     */
    
    
    mutating func binarySearch(forElement key: Element) -> Bool {
        
        
        var result = false
        
        //establish indices
        let min = self.startIndex
        let max = self.endIndex - 1
        let mid = self.midIndex()
        
        
        //check bounds
        if key > self[max] || key < self[min] {
            print("search value \(key) not found..")
            return false
        }
        
        
        //evaluate chosen number..
        let n = self[mid]
        
        
        print(String(describing: n) + "value attempted..")
        
        
        if n > key {
            var slice = Array(self[min...mid - 1])
            result = slice.binarySearch(forElement: key)
        }
            
        else if n < key {
            var slice = Array(self[mid + 1...max])
            result = slice.binarySearch(forElement: key)
        }
            
        else {
            print("search value \(key) found..")
            result = true
        }
        
        return result
    }

    
    
    //MARK: - Linear Search
    
    
     /*
     linear search algorithm - use fast enumeration to iterate through a sequence
     of values. performance of O(n).
     */
    
    func linearSearch(forElement key: Element) -> Bool {
                
        //check all possible values
        for number in self {
            if number == key {
                return true
            }
        }
        
        return false
        
    }

    
  
    //MARK: - Insertion Sort
    
    
    /*
     insertion sort algorithm - rank set of random numbers lowest to highest by
     inserting numbers based on a sorted and unsorted side. performance of O(n2).
     */
   
    func insertionSort() -> Array<Element> {
        
        
        //check for trivial case
        guard self.count > 1 else {
            return self
        }
        
        
        var output: Array<Element> = self
        
        for primaryindex in 0..<output.count {
            
            let key = output[primaryindex]
            var secondaryindex = primaryindex
            
            
            while secondaryindex > -1 {
                
                print("comparing \(key) and \(output[secondaryindex])")
                
                if key < output[secondaryindex] {
                    
                    //move into correct position
                    output.remove(at: secondaryindex + 1)
                    output.insert(key, at: secondaryindex)
                }
                
                secondaryindex -= 1
            }
            
        }
        
        return output
        
    }
    
    
    
    
    //MARK: - Bubble Sort
    
    
    /*
     bubble sort algorithm - rank items from the lowest to highest by swapping
     groups of two items from left to right. The highest item in the set will bubble up to the
     right side of the set after the first iteration. performance of O(n2).
     */
    
    
    func bubbleSort() -> Array<Element> {
        
        
        //check for trivial case
        guard self.count > 1 else {
            return self
        }
        
        
        //mutated copy
        var output: Array<Element> = self
        
        
        for primaryIndex in 0..<self.count {
            
            
            let passes = (output.count - 1) - primaryIndex
            
            
            //"half-open" range operator
            for secondaryIndex in 0..<passes {
                
                let key = output[secondaryIndex]                
                
                print("comparing \(key) and \(output[secondaryIndex + 1])")
                
                //compare / swap positions
                if (key > output[secondaryIndex + 1]) {
                    output.swapAt(secondaryIndex, secondaryIndex + 1)
                }
            }
        }
        
        
        return output
        
    }
    
    
    
    //MARK: - Selection Sort
    
    /*
     selection sort algorithm - rank items from the lowest to highest by iterating through
     the array and swapping the current iteration with the lowest value in the rest of the array
     until it reaches the end of the array. performance of O(n2).
     */
    
    func selectionSort() -> Array<Element> {
        
        
        //check for trivial case
        guard self.count > 1 else {
            return self
        }
        
        
        //mutated copy
        var output: Array<Element> = self
        
        
        for primaryindex in 0..<output.count {
            
            
            var minimum = primaryindex
            var secondaryindex = primaryindex + 1
            
            
            while secondaryindex < output.count {
                
                print("comparing \(output[minimum]) and \(output[secondaryindex])")
                
                // store lowest value as minimum
                if output[minimum] > output[secondaryindex] {
                    minimum = secondaryindex
                }
                
                secondaryindex += 1
            }
            
            
            // swap minimum value with array iteration
            if primaryindex != minimum {
                output.swapAt(primaryindex, minimum)
            }
            
        }
        
        
        return output
        
    }
    
    
    
    //MARK: - Quick Sort
    
    
    /*
     quicksort algorithm - Ranks numbers through a series of swaps.
     Based on "conceptually" sorting a collection subset based on a "wall" and "pivot".
     Best case performance of O(n log(n)). Worst case performance of O(n2).
     */
    
    mutating func quickSort() -> Array<Element> {
        
        func sort(lo: Int, hi: Int) {
            guard hi > lo else { return }
            
            let j = qPartition(lo: lo, hi: hi)
            
            sort(lo: lo, hi: j - 1)
            sort(lo: j + 1, hi: hi)
        }
        
        sort(lo: 0, hi: self.endIndex - 1)
        return self
    }
    
    mutating func qPartition(lo: Int, hi: Int) -> Int {
        var i = lo
        var j = hi + 1
        
        mainLoop: while true {
            
            // rewind i
            insideLoop: repeat {
                i += 1
                if i == hi {
                    break insideLoop
                }
            } while self[i] < self[lo]
            
            // rewind j
            insideLoop: repeat {
                j -= 1
                if j == lo {
                    break insideLoop
                }
            } while self[lo] < self[j]
            
            if i >= j {
                break mainLoop
            }
            
            self.swapAt(i, j)
        }
        
        self.swapAt(lo, j)
        
        return j
    }

    
    
}
