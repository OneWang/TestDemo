//
//  Algorithm.cpp
//  TestDemo
//
//  Created by Jack on 2018/8/6.
//  Copyright © 2018年 Jack. All rights reserved.
//

#include <stdio.h>

//斐波那契数列
long long Fibonacci(unsigned n){
    int result[2] = {0, 1};
    if (n <= 2) {
        return result[n];
    }
    
    long long fibOne = 0;
    long long fibTwo = 1;
    
    long long fibFinal = 0;
    for (int i = 2; i <= n; i ++) {
        fibFinal = fibOne + fibTwo;
        
        fibOne = fibTwo;
        fibTwo = fibFinal;
    }
    return fibFinal;
}

//二分查找
int binary_search(int *a, int length, int target){
    int low = 0;
    int high = length - 1;
    while (low <= high) {
        int middle = (high - low) / 2 + low;
        if (a[middle] == target) {
            return middle;
        }else if (a[middle] > target){
            high = middle - 1;
        }else{
            low = middle + 1;
        }
    }
    return -1;
}

//链表
struct ListNode {
    int val;
    ListNode *next;
    ListNode(int x) : val(x),next(NULL){}
};
///检测链表中是否有环
bool hasCycle (ListNode *head){
    ListNode *slowNode = head;
    ListNode *fasterNode = head;
    while (slowNode != NULL && fasterNode != NULL && fasterNode->next != NULL) {
        slowNode = slowNode->next;
        fasterNode = fasterNode->next->next;
        if (slowNode == fasterNode) {
            return true;
        }
    }
    return false;
}

//删除值等于给定值的所有节点
ListNode *deleteDuplicates(ListNode *head){
    if (head == NULL || head->next == NULL) return NULL;
    
    ListNode *newHead = head;
    while (head->next) {
        if (head->val == head->next->val) {
            head->next = head->next->next;
        }else{
            head = head -> next;
        }
    }
    return newHead;
}
