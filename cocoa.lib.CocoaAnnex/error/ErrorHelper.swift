//
//  ErrorHelper.swift
//  FoundationAnnexOsx
//
//  Created by rlong on 1/08/2015.
//
//

import Foundation


public class ErrorHelper {
    
    
    
    public static func callTo( method: String, failedWithError error: NSError,  file: String = __FILE__, line: Int = __LINE__, function: String = __FUNCTION__) {

        let lastPathComponent: String? = NSURL(fileURLWithPath: file).lastPathComponent
        print("**ERROR** \(lastPathComponent).\(line): '\(method)' call failed")
        let error = ErrorBuilder.errorForCallTo( method, failedWithError: error, file: file, line: line, function: function )
        ErrorHandler.defaultErrorHandler.raise( error )

    }

    public static func callTo( method: String, failedWithErrno errNumber: Int32,  file: String = __FILE__, line: Int = __LINE__, function: String = __FUNCTION__) {
        
        let lastPathComponent: String? = NSURL(fileURLWithPath: file).lastPathComponent
        print("**ERROR** \(lastPathComponent).\(line): '\(method)' call failed")
        let error = ErrorBuilder.errorForCallTo( method, failedWithErrno: errNumber, file: file, line: line, function: function )
        ErrorHandler.defaultErrorHandler.raise( error )
        
    }
    
    public static func fail( message: String, file: String = __FILE__, line: Int = __LINE__, function: String = __FUNCTION__) {
        
        let lastPathComponent: String? = NSURL(fileURLWithPath: file).lastPathComponent
        print("**ERROR** \(lastPathComponent).\(line): \(message)")
        let error = ErrorBuilder.errorForFailure( message, file: file, line: line, function: function )
        ErrorHandler.defaultErrorHandler.raise( error )
        
    }
    
    
}



