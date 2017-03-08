//
//  routeHandllers.swift
//  PerfectDemo
//
//  Created by ifuwo on 17/3/8.
//
//

import PerfectLib

import PerfectHTTP

import PerfectHTTPServer

public func signupRoutes()-> Routes {
    
    return addURLRoutes()
    
}
func addURLRoutes()-> Routes {
    
    var routes = Routes()
    
    routes.add(method: .get, uri: "/", handler: helloHandler)
    
    return routes;
    
}

func helloHandler(request: HTTPRequest, _ response: HTTPResponse) {
    
    response.setHeader(.contentType, value: "text/html")
    
    response.appendBody(string: "HelloHello World")
    
    response.completed()
    
    
}
