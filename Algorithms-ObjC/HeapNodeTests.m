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
#pragma mark- HeapNode Init Unit Tests
- (void)testNodeInit
{
    HeapNode* root = [[HeapNode alloc] initWithValue: 10];
    
    XCTAssert(root != nil);
    XCTAssert(root.Value == 10);
    XCTAssert(root.left == nil);
    XCTAssert(root.right == nil);
    
}

-(void) testNodeInitWithData
{
    NSNumber *data = [[NSNumber alloc] initWithInt:999];
    HeapNode* root = [[HeapNode alloc] initWithValue: 10 andData:data];
    NSNumber *data2 = root.userData;
    XCTAssert(data2 != nil);
    XCTAssert(data2.intValue == 999);
    
}

#pragma mark- GetTreeHeight Unit Tests
- (void)testGetTreeHeight_0 {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    HeapNode *root;
    int depth;
    
    root = [self buildTree_0];
    depth = [root getTreeHeight];
    XCTAssert(depth == 0);
    
    root = [self buildTree_1];
    depth = [root getTreeHeight];
    XCTAssert(depth == 1);

    root = [self buildTree_2];
    depth = [root getTreeHeight];
    XCTAssert(depth == 1);

    root = [self buildTree_3];
    depth = [root getTreeHeight];
    XCTAssert(depth == 3);
}

- (void)testGetNodesAtHeight_0
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

#pragma mark- GetNextParentHeapNode Unit Tests
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

#pragma mark- getPathToNode Unit Tests

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
#pragma mark- Insert Node Unit Tests
/*
    starting with a tree that has only a single node with the value of 10.
    progressively insert values to the tree.  The tree should maintain its "completeness" throughout.
 */
-(void) testInsertNode_0
{
    HeapNode *root;
    HeapNode* node;
    HeapNode* parent;
    
    root = [self buildTree_0];
    node = [[HeapNode alloc]initWithValue:12];

    parent = [root insertNodeToCompleteTree:node];
    XCTAssert(root.Value == 10);
    XCTAssert(parent.Value == 10);
    XCTAssert(root.left.Value == 12);
    XCTAssert(root.right == nil);
    
    node = [[HeapNode alloc]initWithValue:199];
    parent = [root insertNodeToCompleteTree:node];
    XCTAssert(root.Value == 10);
    XCTAssert(parent.Value == 10);
    XCTAssert(root.left != nil);
    XCTAssert(root.left.Value == 12);
    XCTAssert(root.right != nil);
    XCTAssert(root.right.Value == 199);
    
    node = [[HeapNode alloc]initWithValue:32];
    parent = [root insertNodeToCompleteTree:node];
    XCTAssert(parent != nil);
    XCTAssert(parent.Value == 12);
    XCTAssert(parent.left != nil);
    XCTAssert(parent.left.Value == 32);
    XCTAssert(parent.right == nil);

    node = [[HeapNode alloc]initWithValue:1];
    parent = [root insertNodeToCompleteTree:node];
    XCTAssert(parent != nil);
    XCTAssert(parent.Value == 12);
    XCTAssert(parent.left != nil);
    XCTAssert(parent.left.Value == 32);
    XCTAssert(parent.right != nil);
    XCTAssert(parent.right.Value == 1);
    
    node = [[HeapNode alloc]initWithValue:4];
    parent = [root insertNodeToCompleteTree:node];
    XCTAssert(parent != nil);
    XCTAssert(parent.Value == 199);
    XCTAssert(parent.left != nil);
    XCTAssert(parent.left.Value == 4);
    XCTAssert(parent.right == nil);
    
    node = [[HeapNode alloc]initWithValue:42];
    parent = [root insertNodeToCompleteTree:node];
    XCTAssert(parent != nil);
    XCTAssert(parent.Value == 199);
    XCTAssert(parent.left != nil);
    XCTAssert(parent.left.Value == 4);
    XCTAssert(parent.right != nil);
    XCTAssert(parent.right.Value == 42);

    node = [[HeapNode alloc]initWithValue:0];
    parent = [root insertNodeToCompleteTree:node];
    XCTAssert(parent != nil);
    XCTAssert(parent.Value == 32);
    XCTAssert(parent.left != nil);
    XCTAssert(parent.left.Value == 0);
    XCTAssert(parent.right == nil);
    
}

#pragma mark- bubbleUpWithPath
- (void) testBubbleUpWithPath
{
    HeapNode* newRoot;
    HeapNode *root;
    HeapNode* node;
    NSMutableArray<HeapNode*> *nodes;
    NSMutableArray<HeapNode*> *path;
    
    root = [self buildTree_0];

    
    path = [[NSMutableArray alloc] init];  //empty list.
    newRoot = [HeapNode bubbleUpWithPath:path];
    XCTAssert(newRoot == nil);
    
    // test with 1 node.
    path = [root createPathToNode:root];
    newRoot = [HeapNode bubbleUpWithPath:path];
    XCTAssert(newRoot.Value == root.Value);
    
    // test tree with 2 nodes: 4, 10 - nothing bubbled.
    root = [[HeapNode alloc] initWithValue:4];
    node = [[HeapNode alloc] initWithValue:10];
    [root insertNodeToCompleteTree:node];
    path = [root createPathToNode:node];
    newRoot = [HeapNode bubbleUpWithPath:path];
    XCTAssert(newRoot.Value == 4);
    XCTAssert(newRoot.left.Value == 10);

    // test tree with 2 nodes: 10, 4 - node 4 bubbles up to root.
    root = [[HeapNode alloc] initWithValue:10];
    node = [[HeapNode alloc] initWithValue:4];
    [root insertNodeToCompleteTree:node];
    path = [root createPathToNode:node];
    newRoot = [HeapNode bubbleUpWithPath:path];
    XCTAssert(newRoot.Value == 4);
    XCTAssert(newRoot.left.Value == 10);

    // test tree with 2 nodes: 10, 4 - node 4 bubbles up to root.
    root = [[HeapNode alloc] initWithValue:4];
    node = [[HeapNode alloc] initWithValue:10];
    [root insertNodeToCompleteTree:node];
    node = [[HeapNode alloc] initWithValue:3];
    [root insertNodeToCompleteTree:node];
    path = [root createPathToNode:node];
    newRoot = [HeapNode bubbleUpWithPath:path];
    XCTAssert(newRoot.Value == 3);
    XCTAssert(newRoot.left.Value == 10);
    
    nodes = [newRoot getNodesAtDepth:1];
    XCTAssert(nodes.count == 2);
    XCTAssert(nodes[0].Value == 10);
    XCTAssert(nodes[1].Value ==4);
}

    /* build a tree & insert 15
           10
          /  \
        16    11
       /
      15   <== added, bubble up from here
     
     result should be:
     
            10
           /  \
         15    11
        /
      16
     
     */
- (void) testBubbleUpWithPath_1
{
    HeapNode* newRoot;
    HeapNode *root;
    HeapNode* node;
    NSMutableArray<HeapNode*> *nodes;
    NSMutableArray<HeapNode*> *path;

    root = [self buildTree_2];
    node = [[HeapNode alloc] initWithValue:15];
    [root insertNodeToCompleteTree:node];
    path = [root createPathToNode:node];
    newRoot = [HeapNode bubbleUpWithPath:path];
    
    //check root
    XCTAssert( newRoot.Value == 10);
    
    // check next level.
    nodes = [newRoot getNodesAtDepth:1];
    XCTAssert(nodes.count == 2);
    XCTAssert(nodes[0].Value == 15);
    XCTAssert(nodes[1].Value == 11);

    nodes= [newRoot getNodesAtDepth:2];
    XCTAssert(nodes.count == 1);
    XCTAssert(nodes[0].Value == 16);
    
}

/* build a tree & insert 15
        10
       /  \
     16    11
    /
   8   <== added, bubble up from here
 
 result should be:
 
        8
       / \
     10   11
    /
  16
 
 */
- (void) testBubbleUpWithPath_2
{
    HeapNode* newRoot;
    HeapNode *root;
    HeapNode* node;
    NSMutableArray<HeapNode*> *nodes;
    NSMutableArray<HeapNode*> *path;
    
    root = [self buildTree_2];
    node = [[HeapNode alloc] initWithValue:8];
    [root insertNodeToCompleteTree:node];
    path = [root createPathToNode:node];
    newRoot = [HeapNode bubbleUpWithPath:path];
    
    //check root
    XCTAssert( newRoot.Value == 8);
    
    // check next level.
    nodes = [newRoot getNodesAtDepth:1];
    XCTAssert(nodes.count == 2);
    XCTAssert(nodes[0].Value == 10);
    XCTAssert(nodes[1].Value == 11);
    
    nodes= [newRoot getNodesAtDepth:2];
    XCTAssert(nodes.count == 1);
    XCTAssert(nodes[0].Value == 16);
    
}

/* build a tree & insert 18
          10
         /  \
       16    11
      / \
     18   18  <== added, bubble up from here
 
 result should be:
 
          10
         /  \
       16    11
      /  \
    22   18
 */
- (void) testBubbleUpWithPath_3
{
    HeapNode* newRoot;
    HeapNode *root;
    HeapNode* node;
    NSMutableArray<HeapNode*> *nodes;
    NSMutableArray<HeapNode*> *path;
    
    root = [self buildTree_2];
    node = [[HeapNode alloc] initWithValue:22];
    [root insertNodeToCompleteTree:node];
    node = [[HeapNode alloc] initWithValue:18];
    [root insertNodeToCompleteTree:node];
    path = [root createPathToNode:node];
    newRoot = [HeapNode bubbleUpWithPath:path];
    
    //check root
    XCTAssert( newRoot.Value == 10);
    
    // check next level.
    nodes = [newRoot getNodesAtDepth:1];
    XCTAssert(nodes.count == 2);
    XCTAssert(nodes[0].Value == 16);
    XCTAssert(nodes[1].Value == 11);
    
    nodes= [newRoot getNodesAtDepth:2];
    XCTAssert(nodes.count == 2);
    XCTAssert(nodes[0].Value == 22);
    XCTAssert(nodes[1].Value == 18);
}

/* build a tree & insert 12
             10
            /   \
          16     11
         /  \
        22   12         <== added, bubble up from here
 
 result should be:
 
            10
           /  \
         12    11
        /  \
      22    16
 */
- (void) testBubbleUpWithPath_4
{
    HeapNode* newRoot;
    HeapNode *root;
    HeapNode* node;
    NSMutableArray<HeapNode*> *nodes;
    NSMutableArray<HeapNode*> *path;
    
    // build the tree
    root = [self buildTree_2];
    root = [[HeapNode alloc] initWithValue:10];
    [self insertValue:16 intoTree:root];
    [self insertValue:11 intoTree:root];
    [self insertValue:22 intoTree:root];

    // add 12 and bubble it up.
    node = [self insertValue:12 intoTree:root];
    path = [root createPathToNode:node];
    newRoot = [HeapNode bubbleUpWithPath:path];
    
    //check root
    XCTAssert( newRoot.Value == 10);
    
    // check next level.
    nodes = [newRoot getNodesAtDepth:1];
    XCTAssert(nodes.count == 2);
    XCTAssert(nodes[0].Value == 12);
    XCTAssert(nodes[1].Value == 11);
    
    nodes= [newRoot getNodesAtDepth:2];
    XCTAssert(nodes.count == 2);
    XCTAssert(nodes[0].Value == 22);
    XCTAssert(nodes[1].Value == 16);
}

/* build a tree & insert 8
                10
               /   \
             16     11
            /  \
          22    8         <== added, bubble up from here
 
 result should be:
 
                 8
                / \
               /   \
              10   11
             /  \
           22    16
 */
- (void) testBubbleUpWithPath_5
{
    HeapNode* newRoot;
    HeapNode *root;
    HeapNode* node;
    NSMutableArray<HeapNode*> *nodes;
    NSMutableArray<HeapNode*> *path;
    
    // build the tree
    root = [self buildTree_2];
    root = [[HeapNode alloc] initWithValue:10];
    [self insertValue:16 intoTree:root];
    [self insertValue:11 intoTree:root];
    [self insertValue:22 intoTree:root];
    
    // add 12 and bubble it up.
    node = [self insertValue:8 intoTree:root];
    path = [root createPathToNode:node];
    newRoot = [HeapNode bubbleUpWithPath:path];
    
    //check root
    XCTAssert( newRoot.Value == 8);
    
    // check next level.
    nodes = [newRoot getNodesAtDepth:1];
    XCTAssert(nodes.count == 2);
    XCTAssert(nodes[0].Value == 10);
    XCTAssert(nodes[1].Value == 11);
    
    nodes= [newRoot getNodesAtDepth:2];
    XCTAssert(nodes.count == 2);
    XCTAssert(nodes[0].Value == 22);
    XCTAssert(nodes[1].Value == 16);
}

/* build a tree & insert 12
                   10
                  / \
                 /   \
                /     \
              16       15
             /  \     /  \
           22    18  20   12   <== added, bubble up from here
 
 result:
                    10
                   /  \
                  /    \
                 /      \
               16       12
              /  \     /  \
            22    18  20   15   <== added, bubble up from here
*/

- (void) testBubbleUpWithPath_6
{
    HeapNode* newRoot;
    HeapNode *root;
    HeapNode* node;
    NSMutableArray<HeapNode*> *nodes;
    NSMutableArray<HeapNode*> *path;
    
    // build the tree
    root = [self buildTree_2];
    root = [[HeapNode alloc] initWithValue:10];
    [self insertValue:16 intoTree:root];
    [self insertValue:15 intoTree:root];
    [self insertValue:22 intoTree:root];
    [self insertValue:18 intoTree:root];
    [self insertValue:20 intoTree:root];
    
    // add 20 and bubble it up.
    node = [self insertValue:12 intoTree:root];
    path = [root createPathToNode:node];
    newRoot = [HeapNode bubbleUpWithPath:path];
    
    //check root
    XCTAssert( newRoot.Value == 10);
    
    // check next level.
    nodes = [newRoot getNodesAtDepth:1];
    XCTAssert(nodes.count == 2);
    XCTAssert(nodes[0].Value == 16);
    XCTAssert(nodes[1].Value == 12);
    
    nodes= [newRoot getNodesAtDepth:2];
    XCTAssert(nodes.count == 4);
    XCTAssert(nodes[0].Value == 22);
    XCTAssert(nodes[1].Value == 18);
    XCTAssert(nodes[2].Value == 20);
    XCTAssert(nodes[3].Value == 15);
}

/* build a tree & insert 8
               10
               / \
              /   \
             /     \
           16       15
          /  \     /  \
        22    18  20   8   <== added, bubble up from here
 
 result:
                8
               / \
              /   \
             /     \
            /       \
          16        10
         /  \      /  \
       22    18  20   15   <== added, bubble up from here
 */

- (void) testBubbleUpWithPath_7
{
    HeapNode* newRoot;
    HeapNode *root;
    HeapNode* node;
    NSMutableArray<HeapNode*> *nodes;
    NSMutableArray<HeapNode*> *path;
    
    // build the tree
    root = [self buildTree_2];
    root = [[HeapNode alloc] initWithValue:10];
    [self insertValue:16 intoTree:root];
    [self insertValue:15 intoTree:root];
    [self insertValue:22 intoTree:root];
    [self insertValue:18 intoTree:root];
    [self insertValue:20 intoTree:root];
    
    // add 8 and bubble it up.
    node = [self insertValue:8 intoTree:root];
    path = [root createPathToNode:node];
    newRoot = [HeapNode bubbleUpWithPath:path];
    
    //check root
    XCTAssert( newRoot.Value == 8);
    
    // check next level.
    nodes = [newRoot getNodesAtDepth:1];
    XCTAssert(nodes.count == 2);
    XCTAssert(nodes[0].Value == 16);
    XCTAssert(nodes[1].Value == 10);
    
    nodes= [newRoot getNodesAtDepth:2];
    XCTAssert(nodes.count == 4);
    XCTAssert(nodes[0].Value == 22);
    XCTAssert(nodes[1].Value == 18);
    XCTAssert(nodes[2].Value == 20);
    XCTAssert(nodes[3].Value == 15);
}

#pragma mark- Test Insert Value

/* build a tree & insert 15
                 10
                /  \
              16    11
 
 result should be:
 
                 10
                /  \
              15    11
              /
            16
 
 */
- (void) testInserValue_1
{
    HeapNode* newRoot;
    HeapNode *root;
    NSMutableArray<HeapNode*> *nodes;
    
    root = [self buildTree_2];
    newRoot = [root insertValue:15];

    //check root
    XCTAssert( newRoot.Value == 10);
    
    // check next level.
    nodes = [newRoot getNodesAtDepth:1];
    XCTAssert(nodes.count == 2);
    XCTAssert(nodes[0].Value == 15);
    XCTAssert(nodes[1].Value == 11);
    
    nodes= [newRoot getNodesAtDepth:2];
    XCTAssert(nodes.count == 1);
    XCTAssert(nodes[0].Value == 16);
    
}

/* build a tree & insert 8
                10
                / \
               /   \
              /     \
            16       15
           /  \     /
         22    18  20
 
 result:
                8
               / \
              /   \
             /     \
            /       \
          16        10
         /  \      /  \
       22    18  20   15
 */

- (void) testInsertValue_7
{
    HeapNode* newRoot;
    HeapNode *root;
    NSMutableArray<HeapNode*> *nodes;
    
    // build the tree
    root = [self buildTree_2];
    root = [[HeapNode alloc] initWithValue:10];
    [self insertValue:16 intoTree:root];
    [self insertValue:15 intoTree:root];
    [self insertValue:22 intoTree:root];
    [self insertValue:18 intoTree:root];
    [self insertValue:20 intoTree:root];
    
    // add 8 and bubble it up.
    newRoot = [root insertValue:8];
    
    //check root
    XCTAssert( newRoot.Value == 8);
    
    // check next level.
    nodes = [newRoot getNodesAtDepth:1];
    XCTAssert(nodes.count == 2);
    XCTAssert(nodes[0].Value == 16);
    XCTAssert(nodes[1].Value == 10);
    
    nodes= [newRoot getNodesAtDepth:2];
    XCTAssert(nodes.count == 4);
    XCTAssert(nodes[0].Value == 22);
    XCTAssert(nodes[1].Value == 18);
    XCTAssert(nodes[2].Value == 20);
    XCTAssert(nodes[3].Value == 15);
}

#pragma mark- Test Get Last Node in complete tree.
- (void)testGetLastNode
{
    HeapNode* root;
    HeapNode* node;
    
    root = [self buildTree_0];
    node = [root getLastNode];
    XCTAssert(node != nil);
    XCTAssert(node.Value == 10);
    
    root = [self buildTree_1];
    node = [root getLastNode];
    XCTAssert(node != nil);
    XCTAssert(node.Value == 16);
    
    root = [self buildTree_2];
    node = [root getLastNode];
    XCTAssert(node != nil);
    XCTAssert(node.Value == 11);
    
    root = [self buildTree_3];
    node = [root getLastNode];
    XCTAssert(node != nil);
    XCTAssert(node.Value == 52);

}

#pragma mark- Test Extract Min

- (void)testExtract_1
{
    HeapNode* min;
    HeapNode* newRoot;
    
    min = [self buildTree_0];
    newRoot = [min extract];
    XCTAssert(min.Value == 10);
    XCTAssert(newRoot == nil);

    min = [self buildTree_1];
    newRoot = [min extract];
    XCTAssert(min.Value == 10);
    XCTAssert(newRoot != nil);
    XCTAssert(newRoot.Value == 16);
    XCTAssert(newRoot.left == nil);
    XCTAssert(newRoot.right == nil);
    
    min = [self buildTree_2];
    newRoot = [min extract];
    XCTAssert(min.Value == 10);
    XCTAssert(newRoot != nil);
    XCTAssert(newRoot.Value == 11);
    XCTAssert(newRoot.left != nil);
    XCTAssert(newRoot.left.Value == 16);
    XCTAssert(newRoot.right == nil);
}

/* extract from a bigger tree (see buildTree_3)
   Then continue extracting until no more items are 
    left (i.e. root == nil)
 */

- (void)testExtract_2
{
    HeapNode* min;
    HeapNode* newRoot;
    
    min = [self buildTree_3];
    newRoot = [min extract];
    
    /* result should be
                11
               /  \
              /    \
             /      \
           16        30
          /  \      /  \
        18  100   40   52
        /
      26
     
     */
    XCTAssert(min.Value == 10);
    XCTAssert(newRoot != nil);
    XCTAssert(newRoot.Value == 11);
    
    NSArray<HeapNode*> *nodes = [newRoot getNodesAtDepth:1];
    
    XCTAssert(nodes[0].Value == 16);
    XCTAssert(nodes[1].Value == 30);

    nodes = [newRoot getNodesAtDepth:2];
    XCTAssert(nodes[0].Value == 18);
    XCTAssert(nodes[1].Value == 100);
    XCTAssert(nodes[2].Value == 40);
    XCTAssert(nodes[3].Value == 52);

    nodes = [newRoot getNodesAtDepth:3];
    XCTAssert(nodes[0].Value == 26);
    
    
    // Extract next Min
    newRoot = [newRoot extract];
    /* result should be
                16
               /  \
              /    \
             /      \
            18        30
           /  \      /  \
          26 100    40   52
     */
    
    nodes = [newRoot getNodesAtDepth:1];
    XCTAssert(nodes.count == 2);
    XCTAssert(nodes[0].Value == 18);
    XCTAssert(nodes[1].Value == 30);

    nodes = [newRoot getNodesAtDepth:2];
    XCTAssert(nodes.count == 4);
    XCTAssert(nodes[0].Value == 26);
    XCTAssert(nodes[1].Value == 100);
    XCTAssert(nodes[2].Value == 40);
    XCTAssert(nodes[3].Value == 52);
    
    nodes = [newRoot getNodesAtDepth:3];
    XCTAssert(nodes.count == 0);

    // Extract next Min
    min = newRoot;
    newRoot = [newRoot extract];
    /* result should be
            18
           /  \
          /    \
         /      \
       26        30
      /  \      /
     52 100    40
     
     */
    
    XCTAssert(min.Value == 16);
    
    nodes = [newRoot getNodesAtDepth:1];
    XCTAssert(nodes.count == 2);
    XCTAssert(nodes[0].Value == 26);
    XCTAssert(nodes[1].Value == 30);
    
    nodes = [newRoot getNodesAtDepth:2];
    XCTAssert(nodes.count == 3);
    XCTAssert(nodes[0].Value == 52);
    XCTAssert(nodes[1].Value == 100);
    XCTAssert(nodes[2].Value == 40);
    
    nodes = [newRoot getNodesAtDepth:3];
    XCTAssert(nodes.count == 0);

    // Extract next Min
    min = newRoot;
    newRoot = [newRoot extract];
    /* result should be
            26
           /  \
          /    \
         /      \
        40      30
       /  \
      52  100
     
     */
    
    XCTAssert(min.Value == 18);
    XCTAssert(newRoot.Value == 26);
    
    nodes = [newRoot getNodesAtDepth:1];
    XCTAssert(nodes.count == 2);
    XCTAssert(nodes[0].Value == 40);
    XCTAssert(nodes[1].Value == 30);
    
    nodes = [newRoot getNodesAtDepth:2];
    XCTAssert(nodes.count == 2);
    XCTAssert(nodes[0].Value == 52);
    XCTAssert(nodes[1].Value == 100);
    
    nodes = [newRoot getNodesAtDepth:3];
    XCTAssert(nodes.count == 0);
    
    // Extract next Min
    min = newRoot;
    newRoot = [newRoot extract];
    /* result should be
            30
           /  \
          /    \
         /      \
        40      100
       /
     52
     
     */
    
    XCTAssert(min.Value == 26);
    XCTAssert(newRoot.Value == 30);
    
    nodes = [newRoot getNodesAtDepth:1];
    XCTAssert(nodes.count == 2);
    XCTAssert(nodes[0].Value == 40);
    XCTAssert(nodes[1].Value == 100);
    
    nodes = [newRoot getNodesAtDepth:2];
    XCTAssert(nodes.count == 1);
    XCTAssert(nodes[0].Value == 52);
    
    nodes = [newRoot getNodesAtDepth:3];
    XCTAssert(nodes.count == 0);

    // Extract next Min
    min = newRoot;
    newRoot = [newRoot extract];
    /* result should be
            40
           /  \
          52  100
     
     */
    
    XCTAssert(min.Value == 30);
    XCTAssert(newRoot.Value == 40);
    
    nodes = [newRoot getNodesAtDepth:1];
    XCTAssert(nodes.count == 2);
    XCTAssert(nodes[0].Value == 52);
    XCTAssert(nodes[1].Value == 100);
    
    nodes = [newRoot getNodesAtDepth:2];
    XCTAssert(nodes.count == 0);
    
    
    // Extract next Min
    min = newRoot;
    newRoot = [newRoot extract];
    /* result should be
        52
       /
     100
     
     */
    
    XCTAssert(min.Value == 40);
    XCTAssert(newRoot.Value == 52);
    
    nodes = [newRoot getNodesAtDepth:1];
    XCTAssert(nodes.count == 1);
    XCTAssert(nodes[0].Value == 100);
    
    nodes = [newRoot getNodesAtDepth:2];
    XCTAssert(nodes.count == 0);

    
    // Extract next Min
    min = newRoot;
    newRoot = [newRoot extract];
    /* result should be
        100
        / \
       -   -
     
     */
    
    XCTAssert(min.Value == 52);
    XCTAssert(newRoot.Value == 100);
    
    nodes = [newRoot getNodesAtDepth:1];
    XCTAssert(nodes.count == 0);
    
    // Extract last value.

    min = newRoot;
    newRoot = [newRoot extract];
    XCTAssert(min.Value == 100);
    XCTAssert(newRoot == nil);

}

#pragma mark- Performance Unit Tests
- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

#pragma mark- Build Tree Methods
/*
 NOTE: Build tree methods build a tree from scratch manually.
       It does not use any heap node methods so it can be used
       to independently test the various functions.
*/

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

/*helper method to insert a value into the tree with root
 */
-(HeapNode*)insertValue:(int)value intoTree:(HeapNode*)root
{
    HeapNode* node = [[HeapNode alloc] initWithValue:value];
    [root insertNodeToCompleteTree:node];
    return node;
}
@end
