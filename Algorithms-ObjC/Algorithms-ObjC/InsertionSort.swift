//
//  InsertionSort.swift
//  Algorithms-ObjC
//
//  Created by Gene Dahilig on 2/16/16.
//  Copyright © 2016 Gene Dahilig. All rights reserved.
//

import Foundation

func insertionSort(var numberList: Array<Int>) ->Array<Int>
{
    for key in 0..<numberList.count
    {
        for y in key+1..<numberList.count
        {
            print("y=\(y)")
            
            if numberList[key] > numberList[y]
            {    // swap
                print("key=\(key)")
                print(numberList)
                let a = numberList.removeAtIndex(y)
                numberList.insert(numberList[key], atIndex: y)
                numberList[key] = a
                print(numberList)
            }
        }
    }
    return numberList
}

