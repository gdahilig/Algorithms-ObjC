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
    
    HeapNode *root;
    int depth;
    
    root = [self buildTree_0];
    depth = [root getTreeDepth];
    XCTAssert(depth == 0);
    
    root = [self buildTree_1];
    depth = [root getTreeDepth];
    XCTAssert(depth == 1);

    root = [self buildTree_2];
    depth = [root getTreeDepth];
    XCTAssert(depth == 1);

    root = [self buildTree_3];
    depth = [root getTreeDepth];
    XCTAssert(depth == 3);
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
    XCTAssert(nodes[0].Value == 16);
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
    XCTAssert(nodes[0].Value == 16);
    XCTAssert(nodes[1].Value == 11);
    
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
    XCTAssert(nodes[0].Value == 16);
    XCTAssert(nodes[1].Value == 11);
    

    nodes = [root getNodesAtDepth:2];
    XCTAssert(nodes.count == 4);
    XCTAssert(nodes[0].Value == 18);
    XCTAssert(nodes[1].Value == 100);
    XCTAssert(nodes[2].Value == 40);
    XCTAssert(nodes[3].Value == 30);
    
    nodes = [root getNodesAtDepth:3];
    XCTAssert(nodes.count == 2);
    XCTAssert(nodes[0].Value == 26);
    XCTAssert(nodes[1].Value == 52);

    // edge case: desired depth greater than actual.
    nodes = [root getNodesAtDepth:99];
    XCTAssert(nodes.count == 0);
    
    // edge case: desired depth is negative.
    nodes = [root getNodesAtDepth:-1];
    XCTAssert(nodes.count == 0);
}

- (void)testGetNextParentHeapNode_0
{
    HeapNode *root = [self buildTree_0];

    HeapNode *heapNodeParent = [root getNextParentHeapNode];
    
    XCTAssert(heapNodeParent !=nil);
    XCTAssert(heapNodeParent.Value == 10);
    
}

- (void)testGetNextParentHeapNode_1
{
    HeapNode *root = [self buildTree_1];
    
    HeapNode *heapNodeParent = [root getNextParentHeapNode];
    
    XCTAssert(heapNodeParent !=nil);
    XCTAssert(heapNodeParent.Value == 10);
}

- (void)testGetNextParentHeapNode_2
{
    HeapNode *root = [self buildTree_2];
    
    HeapNode *heapNodeParent = [root getNextParentHeapNode];
    
    XCTAssert(heapNodeParent !=nil);
    XCTAssert(heapNodeParent.Value == 16);
}

- (void)testGetNextParentHeapNode_3
{
    HeapNode *root = [self buildTree_3];
    
    HeapNode *heapNodeParent = [root getNextParentHeapNode];
    
    XCTAssert(heapNodeParent !=nil);
    XCTAssert(heapNodeParent.Value == 100);
}

-(void) testGetPathToNode
{
    HeapNode *root = [self buildTree_0];
    NSMutableArray<HeapNode*>*path;
    
    // tree includes only the root node with value 10.
    path = [root createPathToNode:root];
    XCTAssert(path.count == 1);
    XCTAssert(path[0].Value == 10);
    path = nil;
    
    // test with a value not in the tree.
    HeapNode *node = [[HeapNode alloc] initWithValue:-1];
    path = [root createPathToNode:node];
    XCTAssert(path == nil);
    path=nil;
    
    // test with two nodes.
    root = [self buildTree_1];
    node = [[HeapNode alloc] initWithValue:16];
    path = [root createPathToNode:node];
    XCTAssert(path != nil);
    XCTAssert(path.count == 2);
    XCTAssert(path[0].Value == 16);
    XCTAssert(path[1].Value == 10);
    
    //
    root = [self buildTree_3];
    node = [[HeapNode alloc] initWithValue:52];
    path = [root createPathToNode:node];
    XCTAssert(path != nil);
    XCTAssert(path.count == 4);
    XCTAssert(path[0].Value == 52);
    XCTAssert(path[1].Value == 18);
    XCTAssert(path[2].Value == 16);
    XCTAssert(path[3].Value == 10);
    
    node = [[HeapNode alloc] initWithValue:40];
    path = [root createPathToNode:node];
    XCTAssert(path != nil);
    XCTAssert(path.count == 3);
    XCTAssert(path[0].Value == 40);
    XCTAssert(path[1].Value == 11);
    XCTAssert(path[2].Value == 10);

    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

#pragma mark- Build Tree Methods
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
     16    nil
 */
-(HeapNode*)buildTree_1
{
    HeapNode* root = [[HeapNode alloc] initWithValue: 10];
    HeapNode* node = [[HeapNode alloc] initWithValue: 16];
    
    root.left = node;
    
    return root;
}


/* build a tree:
          10
         /  \
       16    11
 */
-(HeapNode*)buildTree_2
{
    HeapNode* root = [[HeapNode alloc] initWithValue: 10];
    HeapNode* node = [[HeapNode alloc] initWithValue: 16];
    HeapNode* node2 = [[HeapNode alloc] initWithValue: 11];
    
    root.left = node;
    root.right = node2;
    
    return root;
}

/* build a tree
                10
               /  \
              /    \
             /      \
           16        11
          /  \      /  \
        18  100   40   30
       /  \
      26  52

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
    
    
    root.left       = node16;
    root.right      = node11;
    node16.left     = node18;
    node16.right    = node100;
    node18.left     = node26;
    node18.right    = node52;
    node11.left     = node40;
    node11.right    = node30;
    return root;
}

@end
