//
//  AgentViewModel.swift
//  Valobase
//
//  Created by Kalen Oyphanith on 4/19/22.
//

import Foundation
import Combine

class AgentViewModel: ObservableObject {

    @Published var data : [AgentStruct] = []
    @Published var errorMessage = ""
    @Published var error = false
    @Published var isDone = true

    private var task: AnyCancellable? //combine has support for cancellation
    
    func fetchData(urlString: String) {
        guard let url = URL(string: urlString) else {
            error = true
            isDone = true
            errorMessage = "Problem with URL string"
            return
        }
        
        task = URLSession.shared.dataTaskPublisher(for: url)
            .tryMap{ data, response in // data and response header
                guard let httpResponse = response as? HTTPURLResponse else {
                    self.error = true
                    self.errorMessage = "Bad response"
                    throw URLError(.badServerResponse)
                } // guard
                
                
                guard httpResponse.statusCode == 200 else {
                    // need an array
                    return [AgentStruct]()
                }
                
                print(httpResponse)
                
                let decoder = JSONDecoder()
                let agentList = try! decoder.decode(AgentsStruct.self, from: data)
                
                // convert to string
                let encoder = JSONEncoder()
                let agentData = try! encoder.encode(agentList.self)
                
                //convert binary data to string UTF-A UTF-16
                let str = String.init(data: agentData, encoding: .utf8)
                
                
                self.saveData(string: str ?? "")

                print(agentList.data);

                return agentList.data.sorted(by: {$0.displayName < $1.displayName})
                
            } // tryMap
            .receive(on: RunLoop.main) // need this here so we can update on the main thread for errors as well as our sink
            .catch({(Error) -> Just<[AgentStruct]> in
                print(Error)
                self.error = true
                self.errorMessage = "Bad Response"
                //return Just("Something bad happened")
                return Just<[AgentStruct]>([AgentStruct]())
            })
            .eraseToAnyPublisher()
                    .sink(receiveValue: { results in
                        self.isDone = true
                        self.data = results
                    })
                    
        
    } // fetchData
    
    private func saveData(string: String) {
        let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        
        let fileUrl = dir!.appendingPathComponent("data.txt")
        print(fileUrl)
        
        do {
            //write it
            try string.write(to: fileUrl, atomically: true, encoding: .utf8)
            
            // read it back in
            let string = try String(contentsOf: fileUrl, encoding: .utf8)
            print(string)
        } catch {
            print("Problem saving to disk")
        }
    } //saveData
    
}
