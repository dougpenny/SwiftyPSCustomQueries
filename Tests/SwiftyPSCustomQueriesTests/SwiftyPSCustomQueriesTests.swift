//
//    SwiftyPSCustomQueriesTests.swift
//
//    Copyright (c) 2020 Doug Penny
//
//    Permission is hereby granted, free of charge, to any person obtaining a copy
//    of this software and associated documentation files (the "Software"), to deal
//    in the Software without restriction, including without limitation the rights
//    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//    copies of the Software, and to permit persons to whom the Software is
//    furnished to do so, subject to the following conditions:
//
//    The above copyright notice and this permission notice shall be included in all
//    copies or substantial portions of the Software.
//
//    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//    SOFTWARE.

import XCTest
@testable import SwiftyPSCore
@testable import SwiftyPSCustomQueries

class PowerQueryTests: XCTestCase {
    static var allTests = [
        ("testHomeroomRosterForTeacher", testHomeroomRosterForTeacher),
        ("testSectionsForCourseNumber", testSectionsForCourseNumber),
        ("testTeacherSections", testTeacherSections)
    ]

    var client: SwiftyPSCore!
    var params: TestingParameters!

    override func setUp() {
        super.setUp()
        print("PowerQueryTests setup called--")
        if let paramFileURL = Bundle.module.url(forResource: "testing_parameters", withExtension: "json") {
            let decoder = JSONDecoder()
            do {
                let paramData = try Data(contentsOf: paramFileURL)
                self.params = try decoder.decode(TestingParameters.self, from: paramData)
                self.client = SwiftyPSCore(self.params.baseURL,
                                                clientID: self.params.clientID,
                                                clientSecret: self.params.clientSecret)
            } catch let parseError {
                XCTFail("Failed to decode JSON parameters file.\nError: \(parseError.localizedDescription)")
            }
        } else {
            print("File not found!")
        }
    }

    func testHomeroomRosterForTeacher() async throws {
        if let testTeacher = self.params.testTeacher {
            if let homeroomRoster = try await client.homeroomRosterForTeacher(testTeacher.dcid) {
                if let testHomeroomRoster = testTeacher.homeroomRoster {
                    XCTAssertEqual(testHomeroomRoster[0].gradeLevel, homeroomRoster[0].gradeLevel)
                    XCTAssertEqual(testHomeroomRoster[0].lastFirst, homeroomRoster[0].lastFirst)
                    XCTAssertEqual(testHomeroomRoster[1].studentNumber, homeroomRoster[1].studentNumber)
                    XCTAssertEqual(testHomeroomRoster[1].gender, homeroomRoster[1].gender)
                } else {
                    XCTFail("There was no test homeroom roster defined.")
                }
            } else {
                XCTFail("An error occured retreiving the teacher's homeroom roster.")
            }
        } else {
            XCTFail("No test teacher found.")
        }
    }

    func testSectionsForCourseNumber() async throws {
        if let testCourse = self.params.testCourse {
            if let courseSections = try await client.sectionsForCourseNumber(testCourse.courseNumber) {
                if let testCourseSections = testCourse.courseSections {
                    XCTAssertEqual(testCourseSections[0].courseNumber, courseSections[0].courseNumber)
                    XCTAssertEqual(testCourseSections[0].courseName, courseSections[0].courseName)
                    XCTAssertEqual(testCourseSections[0].period, courseSections[0].period)
                    XCTAssertEqual(testCourseSections[0].room, courseSections[0].room)
                    XCTAssertEqual(testCourseSections[0].numStudents, courseSections[0].numStudents)
                    XCTAssertEqual(testCourseSections[0].id, courseSections[0].id)
                    XCTAssertEqual(testCourseSections[0].teacherID, courseSections[0].teacherID)
                    XCTAssertEqual(testCourseSections[0].dcid, courseSections[0].dcid)
                    XCTAssertEqual(testCourseSections[0].sectionNumber, courseSections[0].sectionNumber)
                } else {
                    XCTFail("There were no test sections defined.")
                }
            } else {
                XCTFail("An error occured retreiving the course sections.")
            }
        } else {
            XCTFail("No test course found.")
        }
    }

    func testTeacherSections() async throws {
        if let testTeacher = self.params.testTeacher {
        if let teacherSections = try await client.sectionsForTeacher(testTeacher.teacherID) {
                if let testTeacherSections = testTeacher.teacherSections {
                    XCTAssertEqual(testTeacherSections[0].courseNumber, teacherSections[0].courseNumber)
                    XCTAssertEqual(testTeacherSections[0].courseName, teacherSections[0].courseName)
                    XCTAssertEqual(testTeacherSections[0].period, teacherSections[0].period)
                    XCTAssertEqual(testTeacherSections[0].room, teacherSections[0].room)
                    XCTAssertEqual(testTeacherSections[0].numStudents, teacherSections[0].numStudents)
                    XCTAssertEqual(testTeacherSections[0].id, teacherSections[0].id)
                    XCTAssertEqual(testTeacherSections[0].teacherID, teacherSections[0].teacherID)
                    XCTAssertEqual(testTeacherSections[0].dcid, teacherSections[0].dcid)
                    XCTAssertEqual(testTeacherSections[0].sectionNumber, teacherSections[0].sectionNumber)
                } else {
                    XCTFail("There were no test sections defined.")
                }
            } else {
                XCTFail("An error occured retreiving the teacher's sections.")
            }
        } else {
            XCTFail("No test teacher found.")
        }
    }
}
