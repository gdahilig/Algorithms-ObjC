//
//  HeapNodeTests.m
//  Algorithms-ObjC
//
//  Created by Gene Dahilig on 2/25/16.
//  Copyright © 2016 Gene Dahilig. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "HeapNode.h"

@interface HeapNodeTests : XCTestCase

@end

@implementation HeapNodeTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testNodeInit
{
    HeapNode* root = [[HeapNode alloc] initWithValue: 10];
    
    XCTAssert(root != nil);
    XCTAssert(root.Value == 10);
    XCTAssert(root.left == nil);
    XCTAssert(root.right == nil);
    
}

- (void)testGetTreeDepth_0 {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    HeapNode *root = [self buildTree_0];
    int depth = [root getTreeDepth];
    
    XCTAssert(depth == 1);
}

- (void)testGetTreeDepth_1 {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    HeapNode *root = [self buildTree_1];
    int depth = [root getTreeDepth];
    
    XCTAssert(depth == 2);
}

- (void)testGetNodesAtDepth_0
{
    HeapNode *root = [self buildTree_0];
    NSMutableArray<HeapNode*> *nodes;
    nodes = [root getNodesAtDepth:0];
    
    XCTAssert(nodes.count == 1);
    XCTAssert(nodes[0].Value == 10);
}

- (void)testGetNodesAtDepth_1
{
    HeapNode *root = [self buildTree_1];
    NSMutableArray<HeapNode*> *nodes;
    nodes = [root getNodesAtDepth:1];
    
    XCTAssert(nodes.count == 1);
    XCTAssert(nodes[0].Value == 52);
}

- (void)testGetNodesAtDepth_2
{
    HeapNode *root = [self buildTree_2];
    NSMutableArray<HeapNode*> *nodes;

    nodes = [root getNodesAtDepth:0];
    XCTAssert(nodes.count == 1);
    XCTAssert(nodes[0].Value == 10);
    
    nodes = [root getNodesAtDepth:1];
    XCTAssert(nodes.count == 2);
    XCTAssert(nodes[0].Value == 52);
    XCTAssert(nodes[1].Value == 40);
    
    // edge case: desired depth greater than actual.
    nodes = [root getNodesAtDepth:2];
    XCTAssert(nodes.count == 0);

    nodes = [root getNodesAtDepth:99];
    XCTAssert(nodes.count == 0);
    
    // edge case: desired depth is negative.
    nodes = [root getNodesAtDepth:-1];
    XCTAssert(nodes.count == 0);
}


- (void)testGetNodesAtDepth_3
{
    HeapNode *root = [self buildTree_3];
    NSMutableArray<HeapNode*> *nodes;
    
    nodes = [root getNodesAtDepth:0];
    XCTAssert(nodes.count == 1);
    XCTAssert(nodes[0].Value == 10);
    
    nodes = [root getNodesAtDepth:1];
    XCTAssert(nodes.count == 2);
    XCTAssert(nodes[0].Value == 52);
    XCTAssert(nodes[1].Value == 40);
    

    nodes = [root getNodesAtDepth:2];
    XCTAssert(nodes.count == 4);
    XCTAssert(nodes[0].Value == 16);
    XCTAssert(nodes[1].Value == 100);
    XCTAssert(nodes[2].Value == 11);
    XCTAssert(nodes[3].Value == 30);
    
    nodes = [root getNodesAtDepth:3];
    XCTAssert(nodes.count == 2);
    XCTAssert(nodes[0].Value == 26);
    XCTAssert(nodes[1].Value == 18);

    // edge case: desired depth greater than actual.
    nodes = [root getNodesAtDepth:99];
    XCTAssert(nodes.count == 0);
    
    // edge case: desired depth is negative.
    nodes = [root getNodesAtDepth:-1];
    XCTAssert(nodes.count == 0);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

/* build a tree:
        10
       /  \
    nil    nil
 */
-(HeapNode*)buildTree_0
{
    HeapNode* root = [[HeapNode alloc] initWithValue: 10];
    return root;
}

/* build a tree:
        10
       /  \
     52    nil
 */
-(HeapNode*)buildTree_1
{
    HeapNode* root = [[HeapNode alloc] initWithValue: 10];
    HeapNode* node = [[HeapNode alloc] initWithValue: 52];
    
    root.left = node;
    
    return root;
}


/* build a tree:
          10
         /  \
       52    40
 */
-(HeapNode*)buildTree_2
{
    HeapNode* root = [[HeapNode alloc] initWithValue: 10];
    HeapNode* node = [[HeapNode alloc] initWithValue: 52];
    HeapNode* node2 = [[HeapNode alloc] initWithValue: 40];
    
    root.left = node;
    root.right = node2;
    
    return root;
}

/* build a tree
                10
               /  \
              /    \
             /      \
           52        40
          /  \      /  \
        16  100   11   30
       /  \
      26  18
 */

-(HeapNode*)buildTree_3
{
    HeapNode* root = [[HeapNode alloc] initWithValue: 10];
    HeapNode* node52 = [[HeapNode alloc] initWithValue: 52];
    HeapNode* node40 = [[HeapNode alloc] initWithValue: 40];
    HeapNode* node16 = [[HeapNode alloc] initWithValue: 16];
    HeapNode* node100 = [[HeapNode alloc] initWithValue: 100];
    HeapNode* node11 = [[HeapNode alloc] initWithValue: 11];
    HeapNode* node30 = [[HeapNode alloc] initWithValue: 30];
    HeapNode* node26 = [[HeapNode alloc] initWithValue: 26];
    HeapNode* node18 = [[HeapNode alloc] initWithValue: 18];
    
    root.left       = node52;
    root.right      = node40;
    node52.left     = node16;
    node52.right    = node100;
    node16.left     = node26;
    node16.right    = node18;
    node40.left     = node11;
    node40.right    = node30;
    return root;
}

@end
