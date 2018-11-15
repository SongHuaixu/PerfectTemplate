//
//  main.swift
//  PerfectTemplate
//
//  Created by Kyle Jessup on 2015-11-05.
//	Copyright (C) 2015 PerfectlySoft, Inc.
//
//===----------------------------------------------------------------------===//
//
// This source file is part of the Perfect.org open source project
//
// Copyright (c) 2015 - 2016 PerfectlySoft Inc. and the Perfect project authors
// Licensed under Apache License v2.0
//
// See http://perfect.org/licensing.html for license information
//
//===----------------------------------------------------------------------===//
//

import PerfectHTTP
import PerfectHTTPServer
import PerfectMarkdown

// An example request handler.
// This 'handler' function can be referenced directly in the configuration below.
func handler(request: HTTPRequest, response: HTTPResponse) {
	// Respond with a simple message.
	response.setHeader(.contentType, value: "text/html")
//    response.appendBody(string: "<html><title>Hello, world!</title><body>Hello, world!</body></html>")
    let body = """
    # 联系方式

    * 手机：13260308062
    * Email：songhuaixu@gmail.com
    * QQ：965991028

    ---
    # 个人信息

    * 宋怀旭/男/1995

    * 本科在读

    * 工作年限：4年

    * 期望职位：iOS 研发工程师

    * 期望月薪：面谈

    * 期望城市：北京

    ---

    # 工作经历
    ### 中商惠民（北京）电子商务有限公司（2016.4 ～ 2018.11）
    ### 爱有方教育科技（北京）有限公司（2015.1 ～ 2016.4）
    ## 实习经历
    ### 北京分豆教育科技股份有限公司（2014.4 ～ 2015.1）

    ---

    # 项目难点

    ### 中商惠民 CRM
    1. 优化了 Cobub Razor 中 iOS 平台的收集 bug 功能
    2. 使用 Swift + Storyboard 对项目进行重构
    3. 自定义 UICollectionViewLayout 实现 UICollectionViewd 的布局和字符串自适应宽高
    4. 后台文件静默上传
    5. APP 中处理了多照片储存、显示、内存优化的问题

    ### 早教魔方
    1. 简单的了解音频和视频的基础知识，并在开发中使用
    2. 使用 WebView 实现 Web 与原生交互
    3. UITableView + AutoLayout 高度自适应和滑动优化

    ## 慧学院
    1. UITableView 和 UICollectionView 的了解和使用
    2. Block 与 Delegate 的了解与使用
    3. 上架 App Store 的上架等简单工作

    ---

    # 技能清单

    * 熟练使用 Objective-C 、 Swift 、 AutoLayout 、Storyboard
    * 熟练使用 Masonry 、SnapKit 进行代码约束
    * 熟练使用 SVN 、 Git 进行版本管理
    * 熟练使用 CocoaPods 进行第三方库管理
    * iOS LLDB Debug 调试
    * 简单的使用 CoreData 、 SQLite 进行数据持久化
    * 深入的了解与使用 iOS Runtime
    * 正在学习与了解 iOS 逆向和安全

    ---

    # 教育经历
    ### 北京大学 (2018.3 ~ 至今)
    ### 河北软件职业技术学院 (2012.6 ～ 2015.9)

    ---

    # 自我评价
    自学能力强，做事踏实、认真负责、工作积极
    在工作中注意新知识的学习，并且注重团队精神及各方面的沟通合作，能承受工作上的压力
    思想成熟，做事有恒心和毅力，富有责任感，勇于创新
    为人诚恳，工作细心，吃苦耐劳，做事客观公正，责任心强

    ---

    # 致谢

    感谢您有时间阅读我的简历，期待能有机会和您共事

    """.markdownToHTML ?? ""
    let head = "<html><head><meta http-equiv='content-type' content='text/html;charset=utf-8'><title>我的简历</title></head><body>"
    let bodyEnd = "</body></html>"
    response.appendBody(string: head + body + bodyEnd)
	// Ensure that response.completed() is called when your processing is done.
	response.completed()
}

// Configure one server which:
//	* Serves the hello world message at <host>:<port>/
//	* Serves static files out of the "./webroot"
//		directory (which must be located in the current working directory).
//	* Performs content compression on outgoing data when appropriate.
var routes = Routes()
routes.add(method: .get, uri: "/", handler: handler)
routes.add(method: .get, uri: "/**",
		   handler: StaticFileHandler(documentRoot: "/var/www/htdocs", allowResponseFilters: true).handleRequest)
try HTTPServer.launch(name: "localhost",
					  port: 8181,
					  routes: routes,
					  responseFilters: [
						(PerfectHTTPServer.HTTPFilter.contentCompression(data: [:]), HTTPFilterPriority.high)])

