//
//  LeetCode.cpp
//  Method_Nature_Demo
//
//  Created by Jack on 2018/8/21.
//  Copyright © 2018年 Jack. All rights reserved.
//

#include <stdio.h>

int findMaxSubstring(NSString *string){
    if(string.length == 1) return 1;
    if(string.length == 0) return 0;
    NSArray *str = [string componentsSeparatedByString:@","];
    int i = 0,j = i+1,max = 0;
    Boolean  t = true;
    while(i < string.length - 1){
        int length = 1;
        //检测是否重复
        if(j == string.length) break;
        for(int k = i; k < j;k++){
            if(str[j] != str[k] ){
                length++;
            }else{
                t = false;
                break;
            }
        }
        if(length > max){
            max = length;
        }
        //如果检测成功，j指针右移一次
        if(t) j++;
        //检测失败，i指针右移一次，j指针回到i+1的位置
        else{
            t = true; i++; j = i + 1; length = 1;
        }
    }
    return max;
}
