//
//  iOSEngineerCodeCheckTests.swift
//  iOSEngineerCodeCheckTests
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import XCTest
@testable import iOSEngineerCodeCheck

class iOSEngineerCodeCheckTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let githubDataForTest = GithubData()
        githubDataForTest.createURLSessionTaskOfGithubData("Swift") //データ取得用URLSession作成
        githubDataForTest.urlSessionTaskOfGithubData?.resume() //データ取得
        print(githubDataForTest.githubRepositories)
        /*この時点でgithubDataForTest.githubRepositoriesには値が設定されていないことがわかった．
         どのタイミングで確定するのかを明確にし，GithubDataの単体テストが行えるようにしたい*/
        //let repositoryForTest = githubDataForTest.githubRepositories[0]
        //XCTAssertEqual("\(repositoryForTest["full_name"]!)", "apple/swift")
        //XCTAssertEqual("\(repositoryForTest["language"]!)", "C++")
        //XCTAssertEqual("\(repositoryForTest["stargazers_count"]!)", "61006")
        //XCTAssertEqual("\(repositoryForTest["watchers_count"]!)", "61006")
        //XCTAssertEqual("\(repositoryForTest["forks_count"]!)", "6186")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
