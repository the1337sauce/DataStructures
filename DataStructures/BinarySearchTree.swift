//
//  BinarySearchTree.swift
//  DataStructures
//
//  Created by Nathaniel Linsky on 12/19/15.
//  Copyright © 2015 Nathaniel Linsky. All rights reserved.
//

import Foundation

class BinarySearchTree<T: Comparable>  {
    
    let element: T
    var left: BinarySearchTree?
    var right: BinarySearchTree?
    
    init(element: T, left: BinarySearchTree?, right: BinarySearchTree?) {
        self.element = element
        self.left = left
        self.right = right
    }
    
    var count: Int {
        var count = 0
        traverse(self) { (value) -> Void in count += 1 }
        return count
    }
    
    //O (log n) best case, O (n) worst case
    func insert(inout root: BinarySearchTree?, element: T) {
        guard let existingRoot = root else {
            root = BinarySearchTree(element: element, left: nil, right: nil)
            return
        }
        
        if existingRoot.element < element {
            insert(&existingRoot.right, element: element)
        }
        
        if existingRoot.element > element {
            insert(&existingRoot.left, element: element)
        }
    }
    
    func delete(inout root: BinarySearchTree?, element: T) {
        
    }
    
    //O (log n) best case, O (n) worst case
    func search(root: BinarySearchTree?, element: T) -> BinarySearchTree? {
        guard let root = root else {
            return nil
        }
        
        if root.element == element {
            return root
        }
            
        else if root.element < element {
            return search(root.right, element: element)
        }
            
        else if root.element > element {
            return search(root.left, element: element)
        }
        
        // This will never actually execute.
        // Swift compiler isn't currently smart enough
        // To see that, I could avoid this using an if let
        // Instead of guard above but I like it for now
        return nil
    }
    
    // O(n)
    func traverse(root: BinarySearchTree?, callback: (element: T) -> Void) {
        guard let root = root else {
            // Nothing left to look at!
            return
        }
        
        traverse(root.left, callback: callback)
        callback(element: root.element)
        traverse(root.right, callback: callback)
    }
    
    
    
}