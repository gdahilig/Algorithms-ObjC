//
//  HeapNode.m
//  Algorithms-ObjC
//
//  Created by Gene Dahilig on 2/25/16.
//  Copyright © 2016 Gene Dahilig. All rights reserved.
//

#import "HeapNode.h"

@interface HeapNode ()


@end

@implementation HeapNode

-(id) initWithValue:(int)val
{
    _Value = val;
    return self;
}

/*
 Depth of a complete binary tree is always the left-most leaf node from the current node.
 */
-(int) getTreeDepth
{
    int depth = 1;
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
@end
