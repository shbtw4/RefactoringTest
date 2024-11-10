//
//  RefactoringSnapshotTests.swift
//  RefactoringSnapshotTests
//
//  Created by Nikolay Shishkin on 10/11/2024.
//

import XCTest
import iOSSnapshotTestCase
@testable import Refactoring

final class ProgressViewSnapshotTests: FBSnapshotTestCase {

    override func setUp() {
        super.setUp()
        recordMode = false
    }
    
    func test_withStepCount10Step5Progress07() {
        let sut = ProgressView(frame: .init(x: 0, y: 0, width: 250, height: 4))
        sut.backgroundColor = .black
        sut.stepCount = 10
        sut.step = 5
        sut.progress = 0.7
        FBSnapshotVerifyView(sut)
    }
    
    func test_withStepCount2Step0Progress025() {
        let sut = ProgressView(frame: .init(x: 0, y: 0, width: 250, height: 4))
        sut.backgroundColor = .black
        sut.stepCount = 2
        sut.step = 0
        sut.progress = 0.25
        FBSnapshotVerifyView(sut)
    }
}
