//
//  hashTable.swift
//  HashTable
//
//  Created by Edward Yu on 5/18/16.
//
//

import Foundation


class HashTable {
    
    //initialize buckets that we're using for the hash table
    private var buckets: Array<HashNode!>
    
    
    //initialize the buckets with nil values
    init(capacity: Int) {
        self.buckets = Array<HashNode!>(count: capacity, repeatedValue:nil)
        
    }
    
    
    //add the key using the specified hash
    func addBook(ISBN: String) {
        
        //set hash index and isbn variables
        var hashindex: Int!
        var isbn: String!
        
        
        //create a hashvalue using the isbn number
        hashindex = self.createHash(isbn)
        
        //using let because we want the child nodes to always know where to go
        //head can be changed however, if something is removed
        let childToUse: HashNode = HashNode()
        var head: HashNode!
        
        
        
        //check for an existing list
        if  buckets[hashindex] == nil {
            buckets[hashindex] = childToUse
        }
            
        else {
            //if collision, then start the chain
            print("a collision occured. implementing chaining..")
            head = buckets[hashindex]
            
            
            //append new item to the head of the list
            childToUse.next = head
            head = childToUse
            
            
            //update the chained list
            buckets[hashindex] = head
        }
        
        
    } //end function
    
    
    
    //determine if the word is found in the hash table
    func findBook(ISBN: String) -> Bool! {
        
        var hashindex: Int!
        var isbn: String!
        
        hashindex = self.createHash(isbn)
        
        
        //determine if the value is present
        if  buckets[hashindex] == nil {
            print("isbn not found in hash table..")
            return false
        }
            
            
        //iterate through the list of items to find a match
        else {
            
            var current: HashNode! = buckets[hashindex]
            
            while (current != nil) {
                
                let hashName: String! = current.isbn
                
                if (hashName == isbn) {
                    print("(current.isbn) found in hash table..")
                    return true
                }
                
                
                print("searching for book through chained list..")
                current = current.next
                
                
            } //end while
            
            
        } //end if
        
        
        print("book not found in hash table..")
        return false
        
    }
    
    
    
    //creating the hash for storing/accessing info
    //takes in ISBN as a string and converts to integer
    func createHash(ISBN: String) -> Int! {
        
        var remainder: Int = 0
        var divisor: Int = 0
        
        //uniCodeScalars returns a unicode value without converting to string
        for key in isbn.unicodeScalars {
            //println("the ascii value of \(key) is \(key.value)..")
            divisor += Int(key.value)
        }
        
        /*
         note: modular math is used to calculate a hash value. The bucket count is used
         as the dividend to ensure all possible outcomes are between 0 and the collection size.
         This is an example of a simple but effective hash algorithm.
         */
        
        remainder = divisor % buckets.count
        

        
        return remainder - 1
    }
    
    
}