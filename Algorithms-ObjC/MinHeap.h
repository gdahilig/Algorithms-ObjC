//
//  MinHeap.h
//  Algorithms-ObjC
//
//  Created by Gene Dahilig on 2/27/16.
//  Copyright © 2016 Gene Dahilig. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HeapNode.h"

@interface MinHeap : NSObject
@property HeapNode* root;

-(void)insertValue: (int)value withUserData:(id)data;
-(HeapNode*)extractWithValue:(int)value;
@end
