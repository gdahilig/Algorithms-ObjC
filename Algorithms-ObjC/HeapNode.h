//
//  HeapNode.h
//  Algorithms-ObjC
//
//  Created by Gene Dahilig on 2/25/16.
//  Copyright © 2016 Gene Dahilig. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HeapNode : NSObject
@property (strong) HeapNode* left;
@property (strong) HeapNode* right;
@property int Value;

-(id) initWithValue:(int)val;
-(int) getTreeDepth;
-(NSMutableArray<HeapNode*>*)getNodesAtDepth:(int)depth;
-(HeapNode*)getNextParentHeapNode;
-(NSMutableArray<HeapNode*>*)createPathToNode:(HeapNode*)targetNode;
@end
