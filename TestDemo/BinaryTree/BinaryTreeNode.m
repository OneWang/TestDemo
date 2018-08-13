//
//  BinaryTreeNode.m
//  TestDemo
//
//  Created by Jack on 2018/8/7.
//  Copyright © 2018年 Jack. All rights reserved.
//

#import "BinaryTreeNode.h"

@implementation BinaryTreeNode

/**
 创建二叉排序树

 @param values 数组
 @return 二叉树根节点
 */
+ (BinaryTreeNode *)createTreeWithValues:(NSArray *)values{
    BinaryTreeNode *root = nil;
    for (NSInteger i = 0; i < values.count; i ++) {
        root = [self addTreeNode:root value:[values[i] integerValue]];
    }
    return root;
}

/**
 向二叉树中添加节点

 @param treeNode 根节点
 @param value 值
 @return 根节点
 */
+ (BinaryTreeNode *)addTreeNode:(BinaryTreeNode *)treeNode value:(NSInteger)value{
    if (!treeNode) {
        treeNode = [[BinaryTreeNode alloc] init];
        treeNode.value = value;
    }else if (value < treeNode.value){
        treeNode.leftNode = [self addTreeNode:treeNode.leftNode value:value];
    }else{
        treeNode.rightNode = [self addTreeNode:treeNode.rightNode value:value];
    }
    return treeNode;
}

/**
 二叉树中某个位置的节点

 @param index 按层次遍历树的位置（从0开始计算）
 @param rootNode 根节点
 @return 节点
 */
+ (BinaryTreeNode *)treeNodeAtIndex:(NSInteger)index inTree:(BinaryTreeNode *)rootNode{
    //按照层次遍历
    if (!rootNode || index < 0) return nil;
    
    NSMutableArray<BinaryTreeNode *> *queueArray = [NSMutableArray array];    //使用数组模拟队列操作（先进先出）
    [queueArray addObject:rootNode];
    while (queueArray.count > 0) {
        BinaryTreeNode *node = queueArray.firstObject;
        
        if (index == 0) {
            return node;
        }
        //弹出最前面的节点，仿照队列的先进先出
        [queueArray removeObjectAtIndex:0];
        //移除节点，index 减少
        index --;
        
        if (node.leftNode) {
            [queueArray addObject:node.leftNode];
        }
        if (node.rightNode) {
            [queueArray addObject:node.rightNode];
        }
    }
    return nil;
}

/**
 先序遍历
 先访问根，在遍历左子树，然后遍历右子树;递归思想

 @param rootNode 根节点
 @param handler 访问节点处理函数
 */
+ (void)preOrderTraverseTree:(BinaryTreeNode *)rootNode handler:(void(^)(BinaryTreeNode *treeNode))handler{
    if (rootNode) {
        if (handler) {
            handler(rootNode);
        }
        [self preOrderTraverseTree:rootNode.leftNode handler:handler];
        [self preOrderTraverseTree:rootNode.rightNode handler:handler];
    }
}

/**
 中序遍历
 先遍历左子树，再访问根节点，最后遍历右子树

 @param rootNode 根节点
 @param handler 访问节点处理函数
 */
+ (void)inOrderTraverseTree:(BinaryTreeNode *)rootNode handler:(void(^)(BinaryTreeNode *treeNode))handler{
    if (rootNode) {
        [self inOrderTraverseTree:rootNode.leftNode handler:handler];
        if (handler) {
            handler(rootNode);
        }
        [self inOrderTraverseTree:rootNode.rightNode handler:handler];
    }
}

/**
 后序遍历
 先遍历左子树，再遍历右子树，最后遍历根节点

 @param rootNode 根节点
 @param handler 访问节点处理函数
 */
+ (void)postOrderTraverseTree:(BinaryTreeNode *)rootNode handler:(void(^)(BinaryTreeNode *treeNode))handler{
    if (rootNode) {
        [self postOrderTraverseTree:rootNode.leftNode handler:handler];
        [self postOrderTraverseTree:rootNode.rightNode handler:handler];
        if (handler) {
            handler(rootNode);
        }
    }
}

/**
 层次遍历
 按照从上到下，从左到右次序进行遍历；先遍历完一层，再遍历下一层，因此又叫做广度优先遍历；需要用到队列，在 OC 中使用可变数组来实现；

 @param rootNode 根节点
 @param handler 访问节点处理函数
 */
+ (void)levelTraverseTree:(BinaryTreeNode *)rootNode handler:(void(^)(BinaryTreeNode *treeNode))handler{
    if (!rootNode) return;
    
    NSMutableArray<BinaryTreeNode *> *queueArray = [NSMutableArray array];
    [queueArray addObject:rootNode];
    while (queueArray.count > 0) {
        BinaryTreeNode *node = queueArray.firstObject;
        if (handler) {
            handler(node);
        }
        [queueArray removeObjectAtIndex:0];
        if (node.leftNode) {
            [queueArray addObject:node.leftNode];
        }
        if (node.rightNode) {
            [queueArray addObject:node.rightNode];
        }
    }
}

/**
 二叉树的深度
 从根节点到叶子节点依次经过的节点形成的一条路径，最长路径的长度为数的长度
 1.如果根节点为空，则深度为0
 2.如果左右节点都为空，则深度为1
 3.递归思想：二叉树的深度 = max（左子树深度 ， 右子树深度）+ 1；

 @param rootNode 根节点
 @return 二叉树深度
 */
+ (NSInteger)depthOfTree:(BinaryTreeNode *)rootNode{
    if (!rootNode) {return  0;}
    if (!rootNode.leftNode && !rootNode.rightNode) {return 1;}
    
    NSInteger leftDepth = [self depthOfTree:rootNode.leftNode];
    NSInteger rightDepth = [self depthOfTree:rootNode.rightNode];
    return MAX(leftDepth, rightDepth) + 1;
}

/**
 二叉树的宽度
 二叉树宽度为各层节点数的最大值

 @param rootNode 根节点
 @return 二叉树宽度
 */
+ (NSInteger)widthOfTree:(BinaryTreeNode *)rootNode{
    if (!rootNode) {return 0;}
    
    NSMutableArray *queueArray = [NSMutableArray array]; //数组当成队列
    [queueArray addObject:rootNode]; //压入根节点
    NSInteger maxWidth = 1; //最大的宽度，初始化为1（因为已经有根节点）
    NSInteger curWidth = 0; //当前层的宽度
    
    while (queueArray.count > 0) {
        curWidth = queueArray.count;
        //依次弹出当前层的节点
        for (NSInteger i = 0; i < curWidth; i++) {
            BinaryTreeNode *node = [queueArray firstObject];
            [queueArray removeObjectAtIndex:0]; //弹出最前面的节点，仿照队列先进先出原则
            //压入子节点
            if (node.leftNode) {
                [queueArray addObject:node.leftNode];
            }
            if (node.rightNode) {
                [queueArray addObject:node.rightNode];
            }
        }
        //宽度 = 当前层节点数
        maxWidth = MAX(maxWidth, queueArray.count);
    }
    return maxWidth;
}

/**
 二叉树的所有节点数
 递归思想：二叉树所有节点数 = 左子树节点数 + 右子树节点数 + 1

 @param rootNode 根节点
 @return 所有节点数
 */
+ (NSInteger)numberOfNodeInTree:(BinaryTreeNode *)rootNode{
    if (!rootNode) return 0;
    return [self numberOfNodeInTree:rootNode.leftNode] + [self numberOfNodeInTree:rootNode.rightNode] + 1;
}

/**
 二叉树某层的节点数
 1.根节点为空，则节点数为0
 2.层为1则节点数为1
 3.递归思想：二叉树第 K 层节点数 = 左子树第K - 1层节点数 + 右子树第 K - 1 层节点数

 @param level 层数
 @param rootNode 根节点
 @return 层中节点数
 */
+ (NSInteger)numberOfNodeOnLevel:(NSInteger)level inTree:(BinaryTreeNode *)rootNode{
    if (level < 1 || !rootNode) {
        return 0;
    }
    if (level == 1) {
        return 1;
    }
    return [self numberOfNodeOnLevel:level - 1 inTree:rootNode.leftNode] + [self numberOfNodeOnLevel:level - 1 inTree:rootNode.rightNode];
}

@end
