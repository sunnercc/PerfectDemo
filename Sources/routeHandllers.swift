//
//  routeHandllers.swift
//  PerfectDemo
//
//  Created by ifuwo on 17/3/8.
//
//

import Foundation

import PerfectLib

import PerfectHTTP

import PerfectHTTPServer

public func signupRoutes()-> Routes {
    
    return addURLRoutes()
    
}
func addURLRoutes()-> Routes {
    
    var routes = Routes()
    
    routes.add(method: .get, uri: "/index", handler: helloHandler)
    
    return routes;
    
}

func helloHandler(request: HTTPRequest, _ response: HTTPResponse) {
    
    guard let user = request.param(name: "user") else {
        
        response.completed(status: HTTPResponseStatus.requestTimeout)
        
        return;
    }
    
    guard let pass = request.param(name: "pass") else {
        
        response.completed(status: HTTPResponseStatus.requestTimeout)
        
        return;
    }

    var msg = ""
    
    if user.compare("chenchenhui") == ComparisonResult.orderedSame
        && pass.compare("123") == ComparisonResult.orderedSame{
        msg = "success"
    } else {
        msg = "failed"
    }
    
    response.setBody(string: msg)
    
    response.completed()
    
    
}
