//
//  FibonacciTests.m
//  Algorithms-ObjC
//
//  Created by Gene Dahilig on 2/14/16.
//  Copyright © 2016 Gene Dahilig. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Fibonacci.h"

// source: https://oeis.org/A000045/list
const int maxSize = 39;
int sourceFibs[] = {0,1,1,2,3,5,8,13,21,34,55,89,144,233,377,610,987,
                    1597,2584,4181,6765,10946,17711,28657,46368,75025,
                    121393,196418,317811,514229,832040,1346269,
                    2178309,3524578,5702887,9227465,14930352,24157817,
                    39088169};

@interface FibonacciTests : XCTestCase

@end

@implementation FibonacciTests
{
    Fibonacci *Fib;
    NSMutableArray<NSNumber*> * sequence;
    BOOL isValid;
    int indexError;  // index of the invalid sequence number.
}

- (void)setUp {
    [super setUp];
    Fib = [[Fibonacci alloc] init];
    sequence = nil;
    isValid = NO;
}

- (void)tearDown {
    Fib = nil;
    sequence = nil;
    [super tearDown];
}

- (void)testFibonacci_Invalid_Sizes {
    XCTAssert(Fib != nil);    XCTAssert(Fib != nil);
    
    // Test size =0
    sequence = [Fib generateWithSize:0 withError:nil];
    XCTAssert(sequence == nil);
    
    // Test size < 0
    sequence = nil;
    sequence = [Fib generateWithSize:-1 withError:nil];
    XCTAssert(sequence == nil);
}

// compare the array with our source list of Fibs (see above)
// returns false/no if values don't match up
- (BOOL)isValid:(NSMutableArray<NSNumber*> *) arry indxErr:(int*)index
{
    if ([arry count]> maxSize)
        return NO;
    for (int x=0; x<[arry count]; x++)
    {
        if ([arry objectAtIndex:x].intValue != sourceFibs[x])
        {
            if (index != nil)
                *index = x;
            return NO;
        }
    }
    return YES;
}

// Helper method to output the list with the results.
- (void) printSequence:(NSMutableArray<NSNumber*> *) arry withResult:(BOOL)valid
{
    for (int x=0; x<arry.count; x++)
    {
        NSLog(@"Sequence[%d]: %d", x, [arry objectAtIndex:x].intValue);
    }
    
    if (valid)
    {
        NSLog(@"The fibonacci sequence is valid");
    }
    else
    {
        NSLog(@"The fibonacci sequence is invalid");
    }
}

- (void)testFibonacci_Size_1a
{
    XCTAssert(Fib != nil);

    sequence = [Fib generateWithSize:1 withError:nil];
    XCTAssert(sequence != nil);
    XCTAssert([sequence count] == 1);
    XCTAssert( [self isValid:sequence indxErr:nil]);

}

- (void)testFibonacci_Size_2a
{
    XCTAssert(Fib != nil);
    sequence = nil;
    sequence = [Fib generateWithSize:2 withError:nil];
    isValid = [self isValid:sequence indxErr: &indexError];
    XCTAssert(sequence != nil);
    XCTAssert([sequence count] == 2);
    XCTAssert(isValid);

    [self printSequence:sequence withResult:isValid];

}

- (void)testFibonacci_Size_2b
{
    XCTAssert(Fib != nil);
    sequence = nil;
    sequence = [Fib generateWithSize:2 withError:nil];
    isValid = [self isValid:sequence indxErr: &indexError];
    XCTAssert(sequence != nil);
    XCTAssert([sequence count] == 2);
    XCTAssert(isValid);
    
    [self printSequence:sequence withResult:isValid];
    
}

- (void)testFibonacci_Size_MaxSource
{
    XCTAssert(Fib != nil);
    sequence = nil;
    int size = 39;
    sequence = [Fib generateWithSize:size withError:nil];
    isValid = [self isValid:sequence indxErr: &indexError];
    XCTAssert(sequence != nil);
    XCTAssert([sequence count] == size);
    XCTAssert(isValid);
    
    [self printSequence:sequence withResult:isValid];
    
}

@end
