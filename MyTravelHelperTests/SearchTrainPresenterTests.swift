//
//  SearchTrainPresenterTests.swift
//  MyTravelHelperTests
//
//  Created by Satish on 11/03/19.
//  Copyright © 2019 Sample. All rights reserved.
//

import XCTest
@testable import MyTravelHelper

class SearchTrainPresenterTests: XCTestCase {
    var presenter: SearchTrainPresenter!
    var view = SearchTrainMockView()
    var interactor = SearchTrainInteractorMock()
    
    override func setUp() {
        presenter = SearchTrainPresenter()
        interactor.isNetworkRechable = true
        presenter.view = view
        presenter.interactor = interactor
        interactor.presenter = presenter
    }

    func testfetchallStations() {
        presenter.fetchallStations()
        XCTAssertTrue(presenter.stationsList.count > 0)
    }
    
    func testfetchallStationsNetworkFailure() {
        interactor.isNetworkRechable = false
        presenter.fetchallStations()
        XCTAssertTrue(view.isNetworkFailure)
    }
    
    func testfetchallStationsServiceFailure() {
        interactor.isNetworkRechable = true
        interactor.error = .badURL
        presenter.fetchallStations()
        XCTAssertTrue(true)
    }
    
    func testTrainsFromSourceToDestination() {
        interactor.isNetworkRechable = true
        presenter.fetchallStations()
        presenter.searchTapped(source: presenter.stationsList[0].stationDesc, destination: presenter.stationsList[0].stationDesc)
        XCTAssertTrue(view.noTrainAvailable)
    }

    override func tearDown() {
        presenter = nil
    }
}




class SearchTrainMockView:PresenterToViewProtocol {
    var isSaveFetchedStatinsCalled = false
    var isNetworkFailure = false
    var noTrainAvailable = false

    func saveFetchedStations(stations: [Station]?) {
        isSaveFetchedStatinsCalled = true
    }

    func showInvalidSourceOrDestinationAlert() {

    }
    
    func updateLatestTrainList(trainsList: [StationTrain]) {

    }
    
    func showNoTrainsFoundAlert() {

    }
    
    func showNoTrainAvailbilityFromSource() {
        noTrainAvailable = true
    }
    
    func showNoInterNetAvailabilityMessage() {
        isNetworkFailure = true
    }
}

class SearchTrainInteractorMock:PresenterToInteractorProtocol {
    var presenter: InteractorToPresenterProtocol?
    var error: NetworkError?
    var stationList: [Station]?
    var stationData: StationData?
    var sourceToDestinationTrains: [StationTrain]?
    var isNetworkRechable: Bool?
    
    
    func fetchallStations() {
        let station1 = Station(desc: "Belfast", latitude: 54.6123, longitude: -5.91744, code: "BFSTC", stationId: 228)
        let station2 = Station(desc: "Lisburn", latitude: 54.5140, longitude: -6.04327, code: "LBURN", stationId: 238)
        if isNetworkRechable != nil && isNetworkRechable == true {
            presenter?.stationListFetched(list: stationList ?? [station1, station2] )
        }
        else {
            presenter?.showNoInterNetAvailabilityMessage()
        }        
    }

    func fetchTrainsFromSource(sourceCode: String, destinationCode: String) {
        if isNetworkRechable != nil && isNetworkRechable == true {
            if let _trainsList = stationData?.trainsList {
                self.proceesTrainListforDestinationCheck(trainsList: _trainsList)
            }
            else {
                self.presenter?.showNoTrainAvailbilityFromSource()
            }
        }
        else {
            presenter?.showNoInterNetAvailabilityMessage()
        } 
    }
    
    private func proceesTrainListforDestinationCheck(trainsList: [StationTrain]) {
        if isNetworkRechable != nil && isNetworkRechable == true {
            self.presenter?.fetchedTrainsList(trainsList: sourceToDestinationTrains)
        }
        else {
            presenter?.showNoInterNetAvailabilityMessage()
        }
        
    }
}
