//
//  YJ_Singlent.h
//  YJ_LoveStroy
//
//  Created by yujie on 16/11/25.
//  Copyright © 2016年 yujie. All rights reserved.
//

#ifndef YJ_Singlent_h
#define YJ_Singlent_h

#define singlent_for_interface(className) + (className*)shared##className;

#define singlent_for_implementation(className) static className*_instance;\
+(id)allocWithZone:(NSZone*)zone{\
    static dispatch_once_t onceToken;\
    dispatch_once(&onceToken,^{\
    _instance = [super allocWithZone:zone];\
  });\
      return _instance;\
}\
+(className*)shared##className{\
    static dispatch_once_t onceToken;\
    dispatch_once(&onceToken,^{\
    _instance = [[className alloc]init];\
  });\
       return _instance;\
}


#endif /* YJ_Singlent_h */
