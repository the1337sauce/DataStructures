//
//  BinarySearchTreeTests.swift
//  DataStructures
//
//  Created by Nathaniel Linsky on 12/19/15.
//  Copyright © 2015 Nathaniel Linsky. All rights reserved.
//

import XCTest
@testable import DataStructures


class BinarySearchTreeTests: XCTestCase {
    
    let rootElement = 4
    
    var rootPointer: BinarySearchTree<Int>?
    
    var root: BinarySearchTree<Int> {
        return rootPointer!
    }
    
    override func setUp() {
        super.setUp()
        
        rootPointer = BinarySearchTree(element: rootElement, left: nil, right: nil)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInsertingAnElementLessThanTheRootInsertsToLeftChild() {
        root.insert(&rootPointer, element: 2)
        
        XCTAssertEqual(root.left!.element, 2)
        
        XCTAssertNil(root.right)
    }
    
    func testInsertingAnElementGreaterThanTheRootInsertsToTheRightChild() {
        root.insert(&rootPointer, element: 5)
        
        XCTAssertEqual(root.right!.element, 5)
        
        XCTAssertNil(root.left)
    }
    
    func testInsertingAnElementThatAlreadyExistsDoesNothing() {
        root.insert(&rootPointer, element: rootElement)
        
        XCTAssertEqual(root.count, 1)
    }
    
    func testCountReturnsTheCorrectCountOfValues() {
        root.insert(&rootPointer, element: 3)
        
        root.insert(&rootPointer, element: 2)
        
        root.insert(&rootPointer, element: 5)
        
        XCTAssertEqual(root.count, 4)
    }
    
    func testWeCanSuccessfullySearchForElementsThatExistOnTheLeftSide() {
        root.insert(&rootPointer, element: 3)
        
        XCTAssertTrue(root.search(root, element: 3))
    }
    
    func testWeCanSuccessfullySearchForElementsThatExistOnTheRightSide() {
        root.insert(&rootPointer, element: 8)
        
        XCTAssertTrue(root.search(root, element: 8))
    }
    
    func testWeCanSearchForElementsAFewLevelsDeep() {
        root.insert(&rootPointer, element: 8)
        root.insert(&rootPointer, element: 7)
        root.insert(&rootPointer, element: 10)
        
        XCTAssertTrue(root.search(root, element: 8))
        XCTAssertTrue(root.search(root, element: 7))
        XCTAssertTrue(root.search(root, element: 10))
    }
    
    func testWeCanSuccessfullySearchForElementsThatDontExist() {
        XCTAssertFalse(root.search(root, element: 12))
    }
    
    func testWeCanDeleteALeafNode() {
        let elementForDeletion = 5
        
        root.insert(&rootPointer, element: elementForDeletion)
        
        root.delete(&rootPointer, element: elementForDeletion)
        
        XCTAssertNil(root.right)
        
        XCTAssertEqual(root.count, 1)
    }
    
    func testWeCanDeleteANodeWithOneChild() {
        let elementForDeletion = 5
        
        let remainingChild = 6
        
        root.insert(&rootPointer, element: elementForDeletion)
        
        root.insert(&rootPointer, element: remainingChild)
        
        root.delete(&rootPointer, element: elementForDeletion)
        
        XCTAssertEqual(root.right!.element, remainingChild)
        
        XCTAssertEqual(root.count, 2)
    }
    
    func testWeCanDeleteANodeWithTwoChildren() {
        let elementForDeletion = 10
        
        root.insert(&rootPointer, element: elementForDeletion)
        
        root.insert(&rootPointer, element: 12)
        
        root.insert(&rootPointer, element: 13)
        
    }
    
    
    func printTree(tree: BinarySearchTree<Int>, spacing: String) {
        let spacingOffset = "  "
        
        if let leftValue = tree.left, let rightValue = tree.right {
            print("\n")
            print(spacing + "\(tree.element)")
            printTree(leftValue, spacing: spacing + spacingOffset)
            printTree(rightValue, spacing: spacing + spacingOffset)
        }
            
        else if let leftValue = tree.left {
            print("\n")
            print(spacing + "\(tree.element)")
            printTree(leftValue, spacing: spacing + spacingOffset)
        }
            
        else if let rightValue = tree.right {
            print("\n")
            print(spacing + "\(tree.element)")
            printTree(rightValue, spacing: spacing + spacingOffset)
        }
            
        else {
            print("\n")
            print(spacing + "\(tree.element)")
        }
    }
}