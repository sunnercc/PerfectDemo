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

import MySQL

public func signupAccounts()-> Routes {
    return addURLRoutes()
}

private func addURLRoutes()-> Routes {
    
    var routes = Routes()
    
    routes.add(method: .post, uri: "/login", handler: accountsLoginHandler)
    
    routes.add(method: .post, uri: "/register", handler: accountsRegisterHandler)
    
    return routes
    
}

let testHost = "127.0.0.1"
let testUser = "root"
let testPassword = "root"
let testDB = "cch"
let testTable = "user"

/// 登录 请求
private func accountsLoginHandler(request: HTTPRequest, _ response: HTTPResponse) {
    
    
    let user = request.param(name: "user")
    let pass = request.param(name: "pass")
    
    let result = connectMysqlLogin(user: user!, pass: pass!)
    
    let values = ["code" : "10000",
                  "status" : result] as [String : Any];
    
    do {
        let data = try JSONSerialization.data(withJSONObject: values, options: .prettyPrinted)
        let dataStr = String(data: data, encoding: .utf8)
        try response.setBody(json: dataStr)
    } catch {
        response.completed(status: .badRequest)
        return;
    }
    
    response.completed()

}

private func connectMysqlLogin(user: String, pass: String) -> Bool {
    
    let dataMysql = MySQL()
    
    let connected = dataMysql.connect(host: testHost, user: testUser, password: testPassword, db: testDB)
    guard connected else {
        // 验证链接是否成功
        print(dataMysql.errorMessage())
        return false
    }
    
    //这个延后操作能够保证在程序结束时无论什么结果都会自动关闭数据库连接
    defer {
        dataMysql.close()
    }
    
    let queryStr = String(format: "select user, pass from %@", testTable)
    let querySuccess = dataMysql.query(statement: queryStr)
    
    // 验证查询
    guard querySuccess else {
        return false
    }
    
    // 保存查询结构
    let results = dataMysql.storeResults()
    var tag: Bool = false
    results?.forEachRow(callback: { (row) in
        
        let dbUser = row[0]
        let dbPass = row[1]
        
        if dbUser?.compare(user) == ComparisonResult.orderedSame
            && dbPass?.compare(pass) == ComparisonResult.orderedSame {
            
            tag = true
        }
    })
    
    return tag
    
}


/// 登录 请求
private func accountsRegisterHandler(request: HTTPRequest, _ response: HTTPResponse) {
    
    
    let user = request.param(name: "user")
    let pass = request.param(name: "pass")
    
    let result = connectRegisterMysql(user: user!, pass: pass!)
    
    let values = ["code" : "10000",
                  "status" : result] as [String : Any];
    
    do {
        let data = try JSONSerialization.data(withJSONObject: values, options: .prettyPrinted)
        let dataStr = String(data: data, encoding: .utf8)
        try response.setBody(json: dataStr)
    } catch {
        response.completed(status: .badRequest)
        return;
    }
    
    response.completed()
    
}

private func connectRegisterMysql(user: String, pass: String) -> Bool {
    
    let dataMysql = MySQL()
    
    let connected = dataMysql.connect(host: testHost, user: testUser, password: testPassword, db: testDB)
    guard connected else {
        // 验证链接是否成功
        print(dataMysql.errorMessage())
        return false
    }
    
    //这个延后操作能够保证在程序结束时无论什么结果都会自动关闭数据库连接
    defer {
        dataMysql.close()
    }
    
    let queryStr = String(format: "insert into %@ values('%@', '%@')",testTable, user, pass)
    let querySuccess = dataMysql.query(statement: queryStr)
    
    // 验证查询
    if querySuccess {
        return true
    } else {
        return false
    }
}

