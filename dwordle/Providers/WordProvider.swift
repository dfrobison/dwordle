//
//  WordProvider.swift
//  dwordle
//
//  Created by Doug on 3/2/22.
//

import Foundation
import Zip

struct WordProvider {
    private var word = ""
    private var numberOfWords = 0
    private var filePath = ""
    
    init() {
        load()
    }
    
    func generateWord() -> String {
        word
    }
    
    mutating func load() {
        let fileManger = FileManager.default
        let documentsDirectory = fileManger.urls(for:.documentDirectory, in: .userDomainMask)[0]
        let fileURL = documentsDirectory.appendingPathComponent("5LetterWords")
        
        filePath = fileURL.path
        
        if !fileManger.fileExists(atPath: filePath) {
            do {
                let resourceFilePath = Bundle.main.url(forResource: "5LetterWords", withExtension: "zip")!
                
                try Zip.unzipFile(resourceFilePath, destination: documentsDirectory, overwrite: true, password: nil)
            } catch {
                print(error.localizedDescription)
                return
            }
        }
        
        loadNumberOfLines()
    }
    
    mutating private func loadNumberOfLines() {
        errno = 0
        
        
        if freopen(filePath, "r", stdin) == nil {
            perror(filePath)
        }
        if let line = readLine() {
            if let numberOfWords = Int(line) {
                self.numberOfWords = numberOfWords
            }
        }
    }
    
    mutating func readFile(atOffset: Int = 0) -> Int {
        errno = 0
        if freopen(filePath, "r", stdin) == nil {
            perror(filePath)
            return 1
        }
        if let line = readLine() {
            if let numberOfWords = Int(line) {
                self.numberOfWords = numberOfWords
            }
        }
        return 0
    }
    
    
    
}
