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
    
    func test_tableView_withNoData() {
        XCTAssertEqual(makeSUT().tableView.numberOfRows(inSection: 0), 0)
    }
    
    func test_tableView_withData() {
        let sut = makeSUT(makeDummyData())
        
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 4)
        XCTAssertEqual(sut.tableView.title(at: 2), "C")
    }
    
    func test_tableView_connected_to_delegate() {
        XCTAssertNotNil(makeSUT().tableView.delegate)
    }
    
    func test_tableView_connected_to_dataSource() {
        XCTAssertNotNil(makeSUT().tableView.dataSource)
    }
    
    func test_tableView_multipleSelection_withTwoSelections_notifiesDelegate() {
        var receivedSelections = [String]()
        var callbackCount = 0
        
        let sut = makeSUT(makeDummyData()) {
            receivedSelections = $0
            callbackCount += 1
        }
        sut.tableView.allowsMultipleSelection = true
        
        sut.tableView.select(at: 1)
        XCTAssertEqual(receivedSelections, ["B"])
        XCTAssertEqual(callbackCount, 1)
        
        sut.tableView.select(at: 3)
        XCTAssertEqual(receivedSelections, ["B", "D"])
        XCTAssertEqual(callbackCount, 2)
    }
    
    // MARK: Helpers
    
    private func makeSUT(_ data: [String] = [String](),
                         _ selection: @escaping ([String]) -> Void = { _ in }) -> DetailViewController {
        let sut = DetailViewController(data: data, selection: selection)
        sut.loadViewIfNeeded()
        return sut
    }
    
    private func makeDummyData() -> [String] {
        return ["A", "B", "C", "D"]
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
    
    func select(at row: Int) {
        /// Mimicking behaviour of tableView action
        /// Call selectRow() to simulate cell select action, then call delegate
        let selectedIndexPath = IndexPath(row: row, section: 0)
        selectRow(at: selectedIndexPath, animated: false, scrollPosition: .none)
        delegate?.tableView?(self, didSelectRowAt: selectedIndexPath)
    }
}
