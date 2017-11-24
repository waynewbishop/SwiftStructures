//
//  LinkedList.swift
//  SwiftStructures
//
//  Created by Wayne Bishop on 6/7/14.
//  Copyright (c) 2014 Arbutus Software Inc. All rights reserved.
//

import Foundation


class LinkedList<T: Equatable> {
    
    
   //new instance
   private var head = LLNode<T>()
   private var counter: Int  = 0
    
    
    
    //the number of items - O(1)
    var count: Int {
        return counter
    }

    
    //find subscript shortcut
    subscript(index: Int) -> LLNode<T>? {
        get {
           return find(at: index)
        }
    }
    
    
    //empty list check
    func isEmpty() -> Bool {
        return counter == 0 || head.key == nil
    }
    
    
    
    //add link item
    func append(element key: T) {

        
        //trivial check
        guard head.key != nil else {
            head.key = key
            counter += 1
            return
        }
    
        
        var current: LLNode? = head
        
        
        while current != nil {
            
            if current?.next == nil {
                
                let childToUse = LLNode<T>()
                
                childToUse.key = key
                childToUse.previous = current
                current!.next = childToUse
                break
            }
                
            else {
                current = current?.next
            }
            
            
        } //end while
        
        counter += 1
    }
    

    
    //print all keys for the class
    func printAllKeys() {
        
        var current: LLNode? = head
        
        print("------------------")
        
        //assign the next instance
        
        while current != nil {
            print("link item is: \(String(describing: current?.key!))")
            current = current?.next
        }
        
    }
    
    
    //MARK: Key & index operations
    
    
    //obtain link at a specific index
    func find(at index: Int) ->LLNode<T>? {

        
        //check empty conditions
        if ((index < 0) || (index > (self.count - 1)) || (head.key == nil)) {
            return nil
        }
        
            
        else  {
            var current: LLNode<T> = head
            var x: Int = 0

            
            //cycle through elements
            while (index != x) {
                current = current.next!
                x += 1
            }
            
            return current
            
        } //end else
    }

    
    
    
    //insert at specific index
    func insert(_ key: T, at index: Int) {
        
        
        //check for nil conditions
        if ((index < 0) || (index > (self.count - 1))) {
            print("link index does not exist..")
            return
        }
        
        
        //establish the head node
        guard head.key != nil else {
            head.key = key
            counter += 1
            return
        }
        
        
        //establish the trailer, current and new items
        var current: LLNode<T>? = head
        var trailer: LLNode<T>?
        var listIndex: Int = 0
        
        
        //iterate through the list to find the insertion point
        while (current != nil) {
            
            if (index == listIndex) {
                
                let childToUse: LLNode = LLNode<T>()
                
                //create the new node
                childToUse.key = key
                
                
                //connect the node infront of the current node
                childToUse.next = current
                childToUse.previous = trailer
                
                
                //use optional binding when using the trailer
                if let linktrailer = trailer {
                    linktrailer.next = childToUse
                    childToUse.previous = linktrailer
                }
                
                
                //point new node to the current / previous
                current!.previous = childToUse
                
                
                //replace the head node if required
                if (index == 0) {
                    head = childToUse
                }
                
                
                break
                
            } //end if
            
            
            //iterate through to the next item
            trailer = current
            current = current?.next
            listIndex += 1
            
            
        } //end while
        
        counter += 1
        
    }

    
    
    
    //remove at specific index
    func remove(at index: Int) {
        
        //check for nil conditions
        if ((index < 0) || (index > (self.count - 1)) || (head.key == nil)) {
            print("link index does not exist..")
            return
        }
        

        var current: LLNode<T>? =  head
        var trailer: LLNode<T>?
        var listIndex: Int = 0
        
        
        //determine if the removal is at the head
        if (index == 0) {
            current = current?.next
            head = current!
            counter -= 1
            return
        }
        
        
        //iterate through the remaining items
        while current != nil {
            
            if listIndex == index {
                
                //redirect the trailer and next pointers
                trailer!.next = current?.next
                current = nil
                break
                
            }
            
            //update the assignments
            trailer = current
            current = current?.next
            listIndex += 1
            
        } //end while
        
        counter -= 1
        
    } //end function
    


    
    
  //reverse the order of a linked list
  func reverse() {
    
    //if count == 1 or count == 0,no need to reverse
    if self.count <= 1{
      return
    }

    
    var current : LLNode<T>? = head
    var next : LLNode<T>? = nil
    
    
    while(current != nil) {
        
      //reverse
      next = current!.next
      current!.next = current!.previous
      current!.previous = next
      
      
      if next == nil {
        head = current!
      }
      
      //move to next node
      current = next
        
    }
    
  }
    
  
    
    
    //MARK: Closure operations
    

    
    /*
    notes: These "generic methods" mimic the map & filter array
    functions found in the Swift standard library.
    */
    
    
    //filter list content - higher order function
    func filter(_ formula: (LLNode<T>) -> Bool) -> LinkedList<T>? {
        
        
        //check for instance
        guard head.key != nil else {
            return nil
        }
        
        
        var current: LLNode! = head
        let results: LinkedList<T>? = LinkedList<T>()
        
        
        while current != nil {
            
            //filter based on formula
            if formula(current) == true {
                if let key = current.key {
                    results?.append(element: key)
                }
            }
                        
            current = current.next
        }
        
        
        return results
        
    }
    
    
    
    //map list content - higher order function
    func map(_ formula: (LLNode<T>) -> T) -> LinkedList<T>! {
        
        
        //check for instance
        guard head.key != nil else {
            return nil
        }
        
        
        var current: LLNode! = head
        let results: LinkedList<T> = LinkedList<T>()
        var newKey: T!
        
        
        while current != nil {
            
            //map based on formula
            newKey = formula(current)
            
            //add non-nil entries
            if newKey != nil {
                results.append(element: newKey)
            }
            
            
            current = current.next
        }
        
        
        return results
        
    }

    
    
    
} //end class






