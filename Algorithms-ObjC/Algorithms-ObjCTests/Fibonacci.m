//
//  Fibonacii.m
//  Algorithms-ObjC
//
//  Created by Gene Dahilig on 2/14/16.
//  Copyright © 2016 Gene Dahilig. All rights reserved.
//

#import "Fibonacci.h"



@implementation Fibonacci
-(NSMutableArray*) generateWithSize:(int)size withError:(int*)code
{
    if (size <= 0)
        return nil;
    // Error return is optional. If nil, no error is returned.
    
    NSMutableArray *arry = [[NSMutableArray alloc] initWithCapacity:size];

    uint value = 0;
    uint a = 0;
    uint b = 1;

    // Modern sequence: 0, 1, ...
    [arry addObject:[NSNumber numberWithInt:a]];
    if (size==1)
        return arry;
    
    [arry addObject:[NSNumber numberWithInt:b]];
    if (size==2)
        return arry;
    
    for (uint x=3; x <= size; x++)
    {
        value = a+b;
        a = b;
        b = value;
        
        if (value <= 0)
        {
            NSLog(@"Fibonacci(%d) = integer overflow", x);
            break;
        }
        [arry addObject:[NSNumber numberWithInt:value]];
    }
    
    
    if (code != nil)
        *code = 0;
    return arry;
}

@end
