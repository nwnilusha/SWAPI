//
//  PlanetListView_UITest.swift
//  SWAPIUITests
//
//  Created by Nilusha Niwanthaka Wimalasena on 8/9/25.
//

import XCTest

final class PlanetListView_UITests: XCTestCase {
    
    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launchArguments.append("--uitesting")
        app.launch()
    }
    
    func test_PlanetListView_SearchBarAndOtherComponents_ShouldExist() {
        
        let planetListSearchBarTextField = app.textFields["PlanetList_SearchBar"]
        XCTAssertTrue(planetListSearchBarTextField.waitForExistence(timeout: 5), "Search bar should be visible")
        
        let title = app.staticTexts["PlanetList_Title"]
        XCTAssertTrue(title.waitForExistence(timeout: 2), "Title should be visible")
        
        let menuButton = app.buttons["PlanetList_MenuButton"]
        XCTAssertTrue(menuButton.waitForExistence(timeout: 2), "Menu button should be visible")
    }
    
    func test_PlanetListView_PlanetRows_ShouldDisplayPlanets() {

        let firstPlanetRow = app.staticTexts["PlanetList_Row_Mirial"].firstMatch
        XCTAssertTrue(firstPlanetRow.waitForExistence(timeout: 5), "Planet rows should be visible with mock data")
    }
    
    func test_PlanetListView_SearchFunctionality_ShouldFilterResults() {

        let searchBar = app.textFields["PlanetList_SearchBar"]
        XCTAssertTrue(searchBar.waitForExistence(timeout: 5))

        searchBar.tap()
        searchBar.typeText("Serenno")

        let serennoRow = app.staticTexts["PlanetList_Row_Serenno"]
        XCTAssertTrue(serennoRow.waitForExistence(timeout: 3), "Serenno should be in search results")
    }
    
    func test_PlanetListView_MenuButton_ShouldToggleMenu() {

        let menuButton = app.buttons["PlanetList_MenuButton"]
        XCTAssertTrue(menuButton.waitForExistence(timeout: 5))

        menuButton.tap()

        let settingsRow = app.otherElements.staticTexts["Settings"]
        XCTAssertTrue(settingsRow.waitForExistence(timeout: 2), "Settings row should appear")
    }
    
    func test_PlanetListView_MenuButton_NavigateToSettings_ShouldGoBackToPlanetList() {
        
        let menuButton = app.buttons["PlanetList_MenuButton"]
        XCTAssertTrue(menuButton.waitForExistence(timeout: 5))

        menuButton.tap()

        let settingsButton = app.staticTexts["SideMenu_SettingsButton"]
        XCTAssertTrue(settingsButton.waitForExistence(timeout: 2), "Settings row should appear")
        settingsButton.tap()
        
        let appVersion = app.staticTexts["App Version"]
        XCTAssertTrue(appVersion.waitForExistence(timeout: 2), "Settings view should be visible")
        
        let backButton = app.buttons["Back"]
        if backButton.waitForExistence(timeout: 2) {
            backButton.firstMatch.tap()
        }
        
        let planetListTitle = app.staticTexts["PlanetList_Title"]
        XCTAssertTrue(planetListTitle.waitForExistence(timeout: 3), "Should be back on planet list view")
    }

    func test_PlanetListView_Navigation_ShouldGoToDetail() {

        let serennoButton = app.buttons["PlanetList_Row_Serenno-PlanetList_Row_Serenno"]
        XCTAssertTrue(serennoButton.waitForExistence(timeout: 5))

        serennoButton.tap()

        let detailView = app.staticTexts["Physical Characteristics"]
        XCTAssertTrue(detailView.waitForExistence(timeout: 2), "Should navigate to planet detail view")
        
        let backButton = app.buttons["Back"]
        if backButton.waitForExistence(timeout: 2) {
            backButton.tap()
        }

        let planetListTitle = app.staticTexts["PlanetList_Title"]
        XCTAssertTrue(planetListTitle.waitForExistence(timeout: 3), "Should be back on planet list view")
    }
}
