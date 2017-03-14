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

private func addURLRoutes()-> Routes {
    
    var routes = Routes()
    
    routes.add(method: .post, uri: "/index", handler: postRequestHandler)
    
    return routes;
    
}


/// post 请求
private func postRequestHandler(request: HTTPRequest, _ response: HTTPResponse) {
    
    guard let user = request.param(name: "user") else {
        response.completed(status: .badRequest)
        return
    }
    
    guard let pass = request.param(name: "pass") else {
        response.completed(status: .badRequest)
        return
    }
    
    if user.compare("chenchenhui") == ComparisonResult.orderedSame
        && pass.compare("123") == ComparisonResult.orderedSame {
        
        let values = ["code" : "10000",
                      "msg" : "success",
                      "data" : "data"];
        
        do {
            let jsonData = try values.jsonEncodedString()
            try response.setBody(json: jsonData)
        } catch {
            response.completed(status: .badRequest)
            return;
        }
    }
    response.completed()
    
}

