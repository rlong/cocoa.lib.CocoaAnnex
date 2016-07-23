//
//  ErrorHandler.swift
//  FoundationAnnexOsx
//
//  Created by rlong on 2/08/2015.
//
//

import Foundation


class ErrorHandler {
    
    static var defaultErrorHandler: ErrorHandler = ErrorHandler()
    
    func raise( error: NSError ) {
        
        print( "**ERROR** ErrorHandler.raise is a no-op as of Swift 1.2" )

    }
    
}