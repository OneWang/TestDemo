//
//  BinaryTreeNode.h
//  TestDemo
//
//  Created by Jack on 2018/8/7.
//  Copyright © 2018年 Jack. All rights reserved.
//  二叉树的定义

/**
    二叉树是递归定义的，所以一般二叉树的相关问题也都可以使用递归的思想解决，当然也可以不使用递归的思想解决；
 二叉排序树/二叉查找树/二叉排序树:其首先是一个二叉树，而且必须满足下面条件：
 1.如左子树不为空，则左子树上的所有节点的值均小于它的根节点的值；
 2.如右子树不为空，则右子树上的所有节点的值均大于它的根节点的值；
 3.左右子树也分别为二叉排序树；
 4.没有键值相等的两个节点；
 */

#import <Foundation/Foundation.h>

@interface BinaryTreeNode : NSObject

/** 值 */
@property (nonatomic, assign) NSInteger value;
/** 左节点 */
@property (nonatomic, strong) BinaryTreeNode *leftNode;
/** 右节点 */
@property (nonatomic, strong) BinaryTreeNode *rightNode;

@end
