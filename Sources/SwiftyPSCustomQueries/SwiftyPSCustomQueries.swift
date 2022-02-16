//
//    SwiftyPSCustomQueries.swift
//
//    Copyright (c) 2020 Cooper Edmunds & Doug Penny – North Raleigh Christian Academy
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

import Foundation
import SwiftyPSCore

extension SwiftyPSCore {
    /**
     Retrieve the current homeroom roster for the given teacher.
     - Important: PowerQuery Endpoint
     - Note: Setting what is considered a homeroom can be changed in the
     [SwiftyPSCustomQueriesPlugin](https://github.com/dougonecent/SwiftyPSCustomQueriesPlugin).
     By default, any course with the a course number starting with \"HR\" or \"Att\" is considered a homeroom.
     - Parameters:
       - teacherDCID: The teacher DCID (not the teacher number)
     - Returns: An optional array of PowerQueryStudents
     */
    public func homeroomRosterForTeacher(_ teacherDCID: Int) async throws -> [StudentItem]? {
        let path = "/ws/schema/query/com.nrcaknights.swiftypowerschool.students.homeroom_roster_for_teacher"
        let classRoster = try await fetchData(path: path,
                                              model: ClassRoster.self,
                                              method: "POST",
                                              params: ["teacher_dcid": "\(teacherDCID)"])
        return classRoster?.data
    }

    /**
     Retrieve all sections of the given course number for the current school year.
     - Important: PowerQuery Endpoint
     - Parameters:
       - courseNumber: The course number you would like to get current sections for (i.e. CSC101)
     - Returns: An optional array of PowerQuerySections
     */
    public func sectionsForCourseNumber(_ courseNumber: String) async throws -> [SectionInfo]? {
        let path = "/ws/schema/query/com.nrcaknights.swiftypowerschool.section.for_course_number"
        let sections = try await fetchData(path: path,
                                           model: PowerQuerySections.self,
                                           method: "POST",
                                           params: ["course_number": "\(courseNumber)"])
        return sections?.data
    }

    /**
     Retrieve sections assigned to a given teacher for the current school year.
     - Important: PowerQuery Endpoint
     - Parameters:
       - teacherID: The teacher ID (not the DCID or teacher number)
     - Returns: An optional array of PowerQuerySections
     */
    public func sectionsForTeacher(_ teacherID: Int) async throws -> [SectionInfo]? {
        let path = "/ws/schema/query/com.nrcaknights.swiftypowerschool.section.for_teacher"
        let sections = try await fetchData(path: path,
                                           model: PowerQuerySections.self,
                                           method: "POST",
                                           params: ["teacher_id": "\(teacherID)"])
        return sections?.data
    }
}
