//
//  accountsSqlHandlers.swift
//  PerfectDemo
//
//  Created by ifuwo on 17/3/14.
//
//

import Foundation

import PerfectLib

import PerfectHTTP

import PerfectHTTPServer

public func signupAccounts()-> Routes {
    return addURLRoutes()
}

private func addURLRoutes()-> Routes {
    
    var routes = Routes()
    
    routes.add(method: .get, uri: "/accounts", handler: accountsHandler)
    
    return routes;
    
}


/// post 请求
private func accountsHandler(request: HTTPRequest, _ response: HTTPResponse) {
    
    
    
}
