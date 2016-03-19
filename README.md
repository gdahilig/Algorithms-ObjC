# Algorithms-ObjC

This is a repository with various algorithms written in Objective-C as a desktop OSX application.  

Then source code organization is:

1.   A Class that performs the algorithm.
2.   A Test case verify the algorithm.

Per my usual development flow, these algorithms are written in TDD fashion where I create the basic algorithm class with at least one method that implements the algorithm, then follow it with a test method.  I'm testing all along the way.  While it does create overhead in implementation, the results what I hope is highly testable code.  

## Algorithms

1. Fibonacci Sequence.

Currently, performance is not measured, but hopefully will be added in the future.

2. Mininum Heap
Minimum heap unit test cases.  

* Initialization Test
* Insert value tests
* Get Tree Height tests
* Get Last node in complete binary tree tests
* Get Nodes at Level tests
* Get Next Parent Node tests
* Extract Mininum value tests
* Large data set tests (10k nodes)

Test cases include a heap with 10,000 psuedo-random numbers.

