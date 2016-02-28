//
//  HeapNode.m
//  Algorithms-ObjC
//
//  Created by Gene Dahilig on 2/25/16.
//  Copyright © 2016 Gene Dahilig. All rights reserved.
//

#import "HeapNode.h"
#include <math.h>

@interface HeapNode ()


@end

@implementation HeapNode

-(id) initWithValue:(int)val
{
    _Value = val;
    _userData = nil;
    return self;
}

-(id) initWithValue:(int) val andData:(id)data
  {
      _Value = val;
      _userData = data;
      return self;
  }

/*
 Depth of a complete binary tree is always the left-most leaf node from the current node.
 */
-(int) getTreeDepth
{
    int depth = 0;
    HeapNode* node = self;
    
    while (node.left != nil)
    {
        node = node.left;
        depth++;
    }
    
    return depth;
}

-(void)getNodes:(int)currDepth :(int)targetDepth :(NSMutableArray<HeapNode*>**) arryNodes
{
    if (currDepth == targetDepth)
    {
        [*arryNodes addObject: self];
        return;
    }
    if (self.left != nil)
        [self.left getNodes:currDepth+1 :targetDepth :arryNodes];
    if (self.right != nil)
        [self.right getNodes:currDepth+1 :targetDepth :arryNodes];

}

-(NSMutableArray<HeapNode*>*)getNodesAtDepth:(int)depth
{
    NSMutableArray<HeapNode*> *nodes = [[NSMutableArray alloc] initWithCapacity:100];
    if (depth < 0)
        return nodes;
    // start with the current node as the root.
    [self getNodes:0 :depth :&nodes];
    
    return nodes;
}

/*
 Computes next parent node from the self as root.
 */
-(HeapNode*)getNextParentHeapNode
{
    HeapNode* nextParent;
    
    int depth = [self getTreeDepth];
    NSMutableArray<HeapNode*> *nodes;
    
    nodes = [self getNodesAtDepth:depth];
    if (nodes.count < pow(2,depth))
    {// last row is still filling up, go up one level and add node there.
        nodes = [self getNodesAtDepth:depth-1];
    }
    
    // from this row, get the first available spot.
    
    for (HeapNode* node in nodes)
    {
        if (node.left == nil)
            return node;
        if (node.right == nil)
            return node;
    }
    
    //error
    NSAssert(FALSE, @"Whoa - shouldn't get here.");
    return nextParent;
}

/*
 Inserts the node into the tree. maintains tree completeness.
 In other words, allways adds the node to the last level of the tree 
 from left to right.
 */
-(HeapNode*)insertNodeToCompleteTree:(HeapNode*)nodeNew
{
    HeapNode* parent = [self getNextParentHeapNode];
    
    if (parent != nil)
    {
        if (parent.left == nil)
            parent.left = nodeNew;
        else if (parent.right == nil)
            parent.right = nodeNew;
        else
            NSAssert(FALSE, @"Error - invalid parent node.");
    }
    
    return parent;
}

/*
 Bubble up the minimum value up the tree given the path.
 Assumes path is valide path in the tree.
 Assumes last item on the list is *always* root.
 */
+(HeapNode*)bubbleUpWithPath:(NSMutableArray<HeapNode*>*)path
{
    if (path.count == 0)
        return nil;
    if (path.count ==1)
        return path[0];
    
    HeapNode* root = path[path.count-1];
    
    int indx = 2; // marks the position of the grandparent.

    HeapNode* target      = path.count >=1 ? path[indx-2] : nil;
    HeapNode* parent      = path.count >=2 ? path[indx-1] : nil;
    HeapNode* grandParent = path.count >=3 ? path[indx] : nil;
        
    while ((parent != nil) && (target.Value < parent.Value))
    {
        // try to swap node and parent.
        HeapNode *tmpLeft, *tmpRight;
        
        tmpLeft = target.left;
        tmpRight= target.right;
        
        // target assumes parents position
        if (parent.left == target)
        {
            target.left  = parent;
            target.right = parent.right;
        }
        else
        {//parent.right == target
            target.right = parent;
            target.left  = parent.left;
        }
        
        parent.left  = tmpLeft;
        parent.right = tmpRight;
        
        if (grandParent != nil)
        {
            if (grandParent.left == parent)
                grandParent.left = target;
            else
                grandParent.right = target;
        }
        else
        {// No grandparent means the parent is the root.
            root = target;
        }
    
        // set up for the next iteration.
        indx += 1;
//        target      = parent;
        parent      = grandParent;
        grandParent = indx < path.count? path[indx] : nil;
    }

    return root;
}

/*
 inserts a node into tree then bubbles the up the mininum value.
*/


/*
 recursive function to find a node.
 */
-(BOOL)findPath:(NSMutableArray<HeapNode*>*)path forTarget: (HeapNode*)target
{
    BOOL found = NO;
    if (target.Value == self.Value)
    {
        [path addObject:self];
        return YES;
    }
    else
    {
        if (self.left != nil)
        {
            found = [self.left findPath:path forTarget:target];
            if (found)
            {
                [path addObject:self];
                return YES;
            }
        }
        if (self.right != nil)
        {
            found = [self.right findPath:path forTarget:target];
            if (found)
            {
                [path addObject:self];
            }
        }
    }
    
    return found;
}

/*
 createPathToNode
 returns a the nodes that lead from the current node (i.e. root) to the desired node.
 returns nil if no path is found. 
 Although it is intended to be used with the root node, it will work for any node in a tree.
 
 Caller is responsible for array returned.
 */

-(NSMutableArray<HeapNode*>*)createPathToNode:(HeapNode*)targetNode
{
    HeapNode * node = self;
    NSMutableArray* path = [[NSMutableArray alloc] initWithCapacity:100];
    bool found = [self findPath:path forTarget:targetNode];
    
    if (!found)
    { // release the array.
        path = nil;
    }
    
    return path;
}
@end
