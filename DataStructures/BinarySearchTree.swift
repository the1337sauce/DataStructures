//
//  BinarySearchTree.swift
//  DataStructures
//
//  Created by Nathaniel Linsky on 12/19/15.
//  Copyright © 2015 Nathaniel Linsky. All rights reserved.
//

import Foundation

enum BinarySearchTreeState {
    case NoChildren
    case OneChild
    case TwoChildren
}

class BinarySearchTree<T: Comparable>  {
    
    var parent: BinarySearchTree?
    var element: T
    var left: BinarySearchTree?
    var right: BinarySearchTree?
    
    init(element: T, left: BinarySearchTree?, right: BinarySearchTree?, parent: BinarySearchTree?) {
        self.element = element
        self.left = left
        self.right = right
        self.parent = parent
    }
    
    var count: Int {
        var count = 0
        traverse(self) { (value) -> Void in count += 1 }
        return count
    }
    
    var state: BinarySearchTreeState {
        if left != nil && right != nil {
            return .TwoChildren
        }
        else if left == nil && right == nil {
            return .NoChildren
        }
        else {
            return .OneChild
        }
    }
    
    var singleChild: BinarySearchTree<T>? {
        if state == .OneChild && left == nil {
            return right
        }
        else if state == .OneChild && right == nil {
            return left
        }
        return nil
    }
    
    func insert(inout root: BinarySearchTree?, element: T) {
        insert(&root, element: element, parent: root)
    }
    
    //O (log n) best case, O (n) worst case
    private func insert(inout root: BinarySearchTree?, element: T, parent: BinarySearchTree?) {
        guard let existingRoot = root else {
            root = BinarySearchTree(element: element, left: nil, right: nil, parent: parent)
            return
        }
        
        if existingRoot.element < element {
            insert(&existingRoot.right, element: element, parent: existingRoot)
        }
        
        if existingRoot.element > element {
            insert(&existingRoot.left, element: element, parent: existingRoot)
        }
    }
    
    func delete(inout root: BinarySearchTree?, element: T) {
        guard let _ = search(root, element: element) else {
            //most certainly cannot delete something that does not exist
            return
        }
        
        var nodeToDelete = search(root, element: element)
        
        switch (nodeToDelete!.state) {
        case .NoChildren:
            deleteNodeWithNoChildren(&nodeToDelete)
        case .OneChild:
            deleteNodeWithOneChild(&nodeToDelete)
        case .TwoChildren:
            deleteNodeWithTwoChildren(&nodeToDelete)
        }
    }
    
    private func deleteNodeWithTwoChildren(inout nodeToDelete: BinarySearchTree?) {
        var minimumSuccessor = findMinimumSuccessor(nodeToDelete?.right)
        
        let minimumSuccessorElement = minimumSuccessor!.element
        
        if minimumSuccessor!.state == .OneChild {
            deleteNodeWithOneChild(&minimumSuccessor)
        }
        
        else {
            deleteNodeWithNoChildren(&minimumSuccessor)
        }
        
        nodeToDelete?.element = minimumSuccessorElement
    }
    
    private func deleteNodeWithNoChildren(inout nodeToDelete: BinarySearchTree?) {
        guard let parent = nodeToDelete!.parent else {
            //if there's no parent, simply nil the current node and it goes away
            nodeToDelete = nil
            return
        }
        //else nil the parents reference and then the node itself
        if parent.element < nodeToDelete!.element {
            parent.right = nil
            nodeToDelete = nil
        }
            
        else if parent.element > nodeToDelete!.element {
            parent.left = nil
            nodeToDelete = nil
        }
    }
    
    private func deleteNodeWithOneChild(inout nodeToDelete: BinarySearchTree?) {
        if let parent = nodeToDelete?.parent {
            replaceNodeToDeleteWithChild(nodeToDelete?.singleChild, nodeToDelete: &nodeToDelete, grandparent: parent)
        }
        else {
            nodeToDelete?.singleChild?.parent = nil
            nodeToDelete = nil
        }
    }
    
    private func replaceNodeToDeleteWithChild(child: BinarySearchTree?, inout nodeToDelete: BinarySearchTree?, grandparent: BinarySearchTree?) {
        child?.parent = nodeToDelete?.parent
        if grandparent?.element < nodeToDelete?.element {
            grandparent?.right = child
            nodeToDelete = nil
        }
        else if grandparent?.element > nodeToDelete?.element {
            grandparent?.left = nodeToDelete?.left
            nodeToDelete = nil
        }
    }
    
    private func findMinimumSuccessor(root: BinarySearchTree?) -> BinarySearchTree? {
        guard let left = root?.left else {
            //we found our minimum! cant go any further
            return root
        }
        
        return findMinimumSuccessor(left)
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