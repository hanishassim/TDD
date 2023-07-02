//
//  TDDTests.swift
//  TDDTests
//
//  Created by Hanis on 01/07/2023.
//

import XCTest
@testable import TDD
@testable import Detail

final class TDDTests: XCTestCase {
    func test_viewDidLoad() throws {
        XCTAssertEqual(makeSUT().view.backgroundColor, .white)
    }
    
    func test_viewDidLoad_labelValue_whenNoButtonAction() {
        XCTAssertEqual(makeSUT().label.text, "Hello World")
    }
    
    func test_viewDidLoad_labelValue_whenOneButtonClick() {
        let sut = makeSUT()
        
        sut.button.sendActions(for: .touchUpInside)
        
        XCTAssertEqual(sut.label.text, "Clicked")
    }
    
    func test_viewDidLoad_withPushNavigation() {
        let sut = makeSUT()
        let navigationController = UINavigationControllerMock(rootViewController: sut)
        
        sut.routeButton.sendActions(for: .touchUpInside)
        
        XCTAssertTrue(navigationController.pushViewControllerCalled)
    }
    
    func test_viewDidLoad_withPopNavigation() {
        let sut = makeSUT()
        let navigationController = UINavigationControllerMock(rootViewController: sut)
        
        sut.routeButton.sendActions(for: .touchUpInside)
        
        let exp = expectation(description: "DetailVC Loaded")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            XCTAssertTrue(navigationController.children.last is DetailViewController)
            exp.fulfill()
        })
        
        wait(for: [exp], timeout: 3)
        
        guard let detailVC = navigationController.children.last as? DetailViewController else {
            return XCTFail("DetailVC Not Exist")
        }
        
        detailVC.popBack()
        
        XCTAssertTrue(navigationController.popViewControllerCalled)
    }
    
    // MARK: Helpers
    
    private func makeSUT() -> ViewController {
        let sut = ViewController()
        sut.loadViewIfNeeded()
        return sut
    }
}

final class UINavigationControllerMock: UINavigationController {
    var pushViewControllerCalled = false
    var popViewControllerCalled = false
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        pushViewControllerCalled = true
        
        super.pushViewController(viewController, animated: animated)
    }
    
    override func popViewController(animated: Bool) -> UIViewController? {
        popViewControllerCalled = true
        
        return super.popViewController(animated: animated)
    }
}
