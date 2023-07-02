//
//  DetailTests.swift
//  DetailTests
//
//  Created by Hanis on 02/07/2023.
//

import XCTest
@testable import Detail

final class DetailTests: XCTestCase {
    func test_viewDidLoad() throws {
        XCTAssertEqual(makeSUT().view.backgroundColor, .yellow)
    }
    
    func test_viewDidLoad_tableView_withNoData() {
        XCTAssertEqual(makeSUT().tableView.numberOfRows(inSection: 0), 0)
    }
    
    func test_viewDidLoad_tableView_withData() {
        let sut = DetailViewController(data: ["A", "B", "C", "D"])
        sut.loadViewIfNeeded()
        
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 4)
        XCTAssertEqual(sut.tableView.title(at: 2), "C")
    }
    
    // MARK: Helpers
    
    private func makeSUT() -> DetailViewController {
        let sut = DetailViewController()
        sut.loadViewIfNeeded()
        return sut
    }
}

private extension UITableView {
    func cell(at row: Int) -> UITableViewCell? {
        return dataSource?.tableView(self, cellForRowAt: IndexPath(row: row, section: 0))
    }
    
    func title(at row: Int) -> String? {
        let contentConfig = cell(at: row)?.contentConfiguration as? UIListContentConfiguration
        
        return contentConfig?.text ?? nil
    }
}
