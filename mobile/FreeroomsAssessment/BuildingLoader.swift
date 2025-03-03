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
        case .success((let data, let response)):
            
            // check if status code 200
            guard response.statusCode == 200 else {
                return .failure(Error.invalidData)
            }
            
            // try decoding the data if fails return invalid data error.
            do {
                let remoteBuildings = try JSONDecoder().decode([RemoteBuilding].self, from: data)
                
                fatalError("TODO")
            } catch {
                return .failure(Error.invalidData)
            }
            
        // if get returns an error return connectivity error.
        case.failure(_):
            return .failure(Error.connectivity)
        }
        
    }
}
