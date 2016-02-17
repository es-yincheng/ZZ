//
//  NSLogDefine.h
//  Budayang
//
//  Created by maxin on 15/10/13.
//  Copyright © 2015年 chinaPnr. All rights reserved.
//

#ifndef NSLogDefine_h
#define NSLogDefine_h


#define Dedug 1

// 日志打印
#if Dedug
#define YCLog(...) NSLog(__VA_ARGS__)
#else
#define YCLog(...)
#endif


#endif /* NSLogDefine_h */
