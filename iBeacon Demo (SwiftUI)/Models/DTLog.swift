//
//  DTLog.swift
//
//  Created by Darktt on 16/1/7.
//  Copyright © 2016 Darktt. All rights reserved.
//

import Foundation

public func Group(comment: String = "", execute: () throws -> Void) rethrows
{
    try execute()
}

public func Delay(for queue: DispatchQueue = .main, duration: Double, execute: @escaping () -> Void)
{
    let popTime: DispatchTime = DispatchTime.now() + duration
    queue.asyncAfter(deadline: popTime, execute: execute)
}

public func Async(queue: DispatchQueue = DispatchQueue.main, execute: @autoclosure @escaping () -> Void)
{
    queue.async(execute: execute)
}

public func MainQueue(execute: @autoclosure @escaping () -> Void)
{
    let mainQueue = OperationQueue.main
    mainQueue.addOperation(execute)
}

public func DTLog<T>(_ message: T, file: String = #file, method: String = #function, line: Int = #line)
{
    if _isDebugAssertConfiguration() {
        
        print("\(file._lastPathComponent)[\(line)], \(method): \(message)")
    }
}

public func DTSaveLog<T>(_ message: T, file: String = #file, method: String = #function, line: Int = #line)
{
    DTLog(message, file: file, method: method, line: line)
    
    #if os(OSX)
        
        let paths: Array<String> = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        
    #else
        
        let paths: Array<String> = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)
        
    #endif
    
    let path: String = paths.first!
    
    let date = Date()
    let dateFormatter = DateFormatter.sharedForLog
    dateFormatter.dateFormat = "YYYYMMdd"
    
    let fileName: String = "Log-" + dateFormatter.string(from: date) + ".txt"
    let filePath: String = path._appendingPathComponent("/Log/" + fileName)
    
    let fileManager = FileManager.default
    
    // Check file is exists.
    if !fileManager.fileExists(atPath: filePath) {
        
        let created: Bool = fileManager.createFile(atPath: filePath, contents: nil, attributes: nil)
        
        if !created {
            
            let directoryPath: String = path._appendingPathComponent("/Log")
            
            do {
                
                try fileManager.createDirectory(atPath: directoryPath, withIntermediateDirectories: false, attributes: nil)
                fileManager.createFile(atPath: filePath, contents: nil, attributes: nil)
                
            } catch {
                
                DTLog(error)
            }
        }
    }
    
    // Write data to file.
    if let fileHandle = FileHandle(forWritingAtPath: filePath) {
        
        autoreleasepool {
            
            dateFormatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
            
            let dateString: String = dateFormatter.string(from: date)
            let appentData: Data = "\(dateString): \((file as NSString).lastPathComponent)[\(line)], \(method): \(message)\n".data(using: .utf8)!
            
            fileHandle.seekToEndOfFile()
            fileHandle.write(appentData)
            fileHandle.synchronizeFile()
            fileHandle.closeFile()
        }
    }
}

// MARK: - Extensions -

fileprivate extension DateFormatter
{
    static let sharedForLog: DateFormatter = DateFormatter()
}

fileprivate extension String
{
    var _lastPathComponent: String {
        
        let aString = self as NSString
        
        return aString.lastPathComponent
    }
    
    func _appendingPathComponent(_ pathComponent: String) -> String
    {
        let string: NSString = self as NSString
        
        return string.appendingPathComponent(pathComponent)
    }
}
