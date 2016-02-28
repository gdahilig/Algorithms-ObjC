//
//  MinHeap.m
//  Algorithms-ObjC
//
//  Created by Gene Dahilig on 2/27/16.
//  Copyright © 2016 Gene Dahilig. All rights reserved.
//

#import "MinHeap.h"

@implementation MinHeap

-(void)insertValue: (int)value withUserData:(id)data
{
    HeapNode* node = [[HeapNode alloc] initWithValue:value andData:data];
    if (_root == nil)
        _root = node;
    else
    {
        [_root insertNodeToCompleteTree:node];
    }
}

/*
 returns the user data
 */
-(id)extractWithValue:(int)value
{
    return nil;
}

@end
