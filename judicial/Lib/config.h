//
//  config.h
//  DynamicEnvironment
//
//  Created by w gq on 15/8/28.
//  Copyright (c) 2015年 zjsos. All rights reserved.
//

#ifndef DynamicEnvironment_config_h
#define DynamicEnvironment_config_h

#define CACHEPATH [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

//数据接口
#define CONFIG_SERVICEURL @"http://61.153.49.14:8110/StarlandFramework/WebService/WebApply/WebApply.asmx/"
#define CONFIG_STATISTICSSERVICEURL @"http://www.zjsos.net:8888/Statisticslog.asmx/"


//图片上传
#define POSTIMAGEURL @"http://61.153.49.14:8110/StarlandFramework/WebService/WebApply/CaseDatumUpload.ashx"

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

//法律咨询
#define CONSULTINGURL @"http://fw.sifa.gov.cn/wx/wyjl/fyzx/index.html"

#define BANANZHUSHOU @"http://61.153.49.14:8110/SFMO/FW/OP/Login.aspx"

//政务服务网用户验证
#define CONFIG_XMLURL @"http://m.ts.gov.cn:8080/"

#define REGISTEREDURL @"http://puser.zjzwfw.gov.cn/sso/usp.do?action=register&servicecode=njdh"

#define NAMESPACE @"http://webservice.api.commnetsoft.com"

#define UPDATEURL @"https://www.zjsos.net:3443/sf/phoneupdates.txt"

#endif
