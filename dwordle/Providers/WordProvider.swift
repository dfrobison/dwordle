//
//  WordProvider.swift
//  dwordle
//
//  Created by Doug on 3/2/22.
//

import Foundation
import Zip

class WordProvider {
    private let fileName = "5LetterWords"
    private var lineReader: LineReader!
    private var numberOfWords = 0
    private var words: Set<String> = []
    
    init() {
        load()
    }
    
    var generateWord: String {
        words.randomElement() ?? "BADWD"
    }

    func isWord(_ word: String) -> Bool {
        words.contains(word)
    }
    
    private func load() {
        let fileManger = FileManager.default
        let documentsDirectory = fileManger.urls(for:.documentDirectory, in: .userDomainMask)[0]
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        let filePath = fileURL.path
        
        // Unzip word file if it doesn't already exist
        if !fileManger.fileExists(atPath: filePath) {
            do {
                let resourceFilePath = Bundle.main.url(forResource: fileName, withExtension: "zip")!
                try Zip.unzipFile(resourceFilePath, destination: documentsDirectory, overwrite: true, password: nil)
            } catch {
                print(error.localizedDescription)
            }
        }
        
        // Put words into Set for quick searching
        do {
            let data = try String(contentsOfFile: filePath, encoding: .utf8)
            words = Set(data.components(separatedBy: .newlines))
        } catch {
            print(error.localizedDescription)
        }
    }
}
