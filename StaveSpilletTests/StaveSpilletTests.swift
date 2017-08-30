//
//  StaveSpilletTests.swift
//  StaveSpilletTests
//
//  Created by Kenneth Frandsen on 09/05/2017.
//  Copyright © 2017 Kenneth Frandsen. All rights reserved.
//

import XCTest
import FirebaseDatabase

@testable import StaveSpillet



class StaveSpilletTests: XCTestCase{
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    
        
        

    }
    
    func testUserID(){
        //Setter BrugerID
        UserDefaults.standard.set("TestBrugerID", forKey: "UserIDTest")
    
        var userTestID: String?
        userTestID = "TestBrugerID"
        
        
        //Henter bruger Id og sammenligner det med det der er sat.
        XCTAssertEqual(UserDefaults.standard.object(forKey: "UserIDTest") as? String, userTestID)
     
    } 
    
}






/*
 
 override func setUp() {
 super.setUp()
 // Put setup code here. This method is called before the invocation of each test method in the class.
 }
 
 override func tearDown() {
 // Put teardown code here. This method is called after the invocation of each test method in the class.
 super.tearDown()
 }
 
 func testExample() {
 // This is an example of a functional test case.
 // Use XCTAssert and related functions to verify your tests produce the correct results.
 }
 
 func testPerformanceExample() {
 // This is an example of a performance test case.
 self.measure {
 // Put the code you want to measure the time of here.
 }
 }
 
 
 */
