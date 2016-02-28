//
//  HeapNode.h
//  Algorithms-ObjC
//
//  Created by Gene Dahilig on 2/25/16.
//  Copyright © 2016 Gene Dahilig. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HeapNode : NSObject
@property HeapNode* left;
@property HeapNode* right;
@property id userData;
@property int Value;

-(id) initWithValue:(int)val;
-(id) initWithValue:(int) val andData:(id)data;
-(int) getTreeDepth;
-(NSMutableArray<HeapNode*>*)getNodesAtDepth:(int)depth;
-(HeapNode*)getNextParentHeapNode;
-(NSMutableArray<HeapNode*>*)createPathToNode:(HeapNode*)targetNode;
-(HeapNode*)insertNodeToCompleteTree:(HeapNode*)nodeNew;

+(HeapNode*)bubbleUpWithPath:(NSMutableArray<HeapNode*>*)path;
@end
