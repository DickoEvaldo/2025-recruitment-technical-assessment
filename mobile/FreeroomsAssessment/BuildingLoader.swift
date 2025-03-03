//
//  BuildingLoader.swift
//  FreeroomsAssessment
//
//  Created by Anh Nguyen on 31/1/2025.
//

import Foundation

public class BuildingLoader {
    private var client: HttpClient
    private var url: URL
    
    public enum Error: Swift.Error {
        case connectivity, invalidData
    }
    
    public typealias Result = Swift.Result<[Building], Swift.Error>
    
    public init(client: HttpClient, url: URL) {
        self.client = client
        self.url = url
    }
    
    public func fetchBuildings() async -> Result  {
        switch await self.client.get(from: self.url) {
        case .success((_, _)):
            return .failure(Error.invalidData)
        
        // if get returns an error return connectivity error
        case.failure(_):
            return .failure(Error.connectivity)
        }
        
    }
}
