//
//  LineReader.swift
//  dwordle
//
//  Created by Doug on 3/6/22.
//

import Foundation


class LineReader {
    private let path: String
    private let file: UnsafeMutablePointer<FILE>!
    private var baseOffset = 0
    
    init?(path: String) {
        self.path = path
        file = fopen(path, "r")
        guard file != nil else { return nil }
    }
    
    func setBaseOffset(_ offset: Int) {
        baseOffset = offset
    }
    
    func getLine(index: Int) -> String? {
        var line:UnsafeMutablePointer<CChar>? = nil
        var linecap:Int = 0
        defer { free(line) }
        fseek(file, baseOffset + (index * baseOffset), SEEK_SET)
        
        return getline(&line, &linecap, file) > 0 ? String(String(cString: line!).dropLast()) : nil
    }
    
    deinit {
        fclose(file)
    }
}
