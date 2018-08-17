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

/**
 二叉树叶子节点数
 叶子节点，又叫终端节点，是左右子树都为空的节点

 @param rootNode 根节点
 @return 叶子节点数
 */
+ (NSInteger)numberOfLeafsInTree:(BinaryTreeNode *)rootNode{
    if (!rootNode) {
        return 0;
    }
    if (!rootNode.leftNode && !rootNode.rightNode) {
        return 1;
    }
    return [self numberOfLeafsInTree:rootNode.leftNode] + [self numberOfLeafsInTree:rootNode.rightNode];
}

/**
 二叉树最大距离（直径）
 二叉树中任意两个节点都有且仅有一条路径，这个路径的长度叫这两个节点的距离；二叉树中所有节点之间的距离的最大值就是二叉树的直径；
 三种情况：
 1.这2个节点分别在根节点的左子树和右子树上，它们之间的路径肯定经过根节点，而且他们肯定是根节点的左右子树上最远的叶子节点（他们到根节点的距离=左右子树的深度）
 2.两个节点都在左子树上
 3.两个节点都在右子树上
 这种方法效率比较低，因为计算子树的深度和最远距离是分开递归的，存在重复递归遍历的情况；其实一次递归就可以计算出深度和最远距离；
 
 @param rootNode 根节点
 @return 最大距离
 */
+ (NSInteger)maxDistanceOfTree:(BinaryTreeNode *)rootNode{
    if (!rootNode) {
        return 0;
    }
    NSInteger distance = [self maxDistanceOfTree:rootNode.leftNode] + [self maxDistanceOfTree:rootNode.rightNode];
    NSInteger disLeft = [self maxDistanceOfTree:rootNode.leftNode];
    NSInteger disRight = [self maxDistanceOfTree:rootNode.rightNode];
    return MAX(distance, MAX(disLeft, disRight));
}

/**
 二叉树中某个节点到根节点的路径

 @param treeNode 节点
 @param rootNode 根节点
 @return 存放路径节点的数组
 */
+ (NSArray *)pathOfTreeNode:(BinaryTreeNode *)treeNode inTree:(BinaryTreeNode *)rootNode{
    NSMutableArray *pathArray = [NSMutableArray array];
    [self isFoundTreeNode:treeNode inTree:rootNode routePath:pathArray];
    return pathArray;
}

+ (BOOL)isFoundTreeNode:(BinaryTreeNode *)treeNode inTree:(BinaryTreeNode *)rootNode routePath:(NSMutableArray *)path{
    if (!rootNode || !treeNode) {
        return NO;
    }
    //找到节点
    if (rootNode == treeNode) {
        [path addObject:rootNode];
        return YES;
    }
    //压入根节点，进行递归
    [path addObject:rootNode];
    //先从左子树中查找
    BOOL find = [self isFoundTreeNode:treeNode inTree:rootNode.leftNode routePath:path];
    //未找到，再从右子树查找
    if (!find) {
        find = [self isFoundTreeNode:treeNode inTree:rootNode.rightNode routePath:path];
    }
    //如果2边都没查找到，则弹出此根节点
    if (!find) {
        [path removeLastObject];
    }
    return find;
}

/**
 二叉树中两个节点最近的公共父节点

 @param nodeA 第一个节点
 @param nodeB 第二个节点
 @param rootNode 根节点
 @return 最近的公共父节点
 */
+ (BinaryTreeNode *)parentOfTreeNode:(BinaryTreeNode *)nodeA andNode:(BinaryTreeNode *)nodeB inTree:(BinaryTreeNode *)rootNode{
    if (!rootNode || !nodeA || !nodeB) {
        return nil;
    }
    if (nodeA == nodeB) {
        return nodeA;
    }
    //从根节点到 A 节点的路径
    NSArray *pathA = [self pathOfTreeNode:nodeA inTree:rootNode];
    //从根节点到 B 节点的路径
    NSArray *pathB = [self pathOfTreeNode:nodeB inTree:rootNode];
    if (pathA.count == 0 || pathB.count == 0) {
        return nil;
    }
    //从后往前推，查找第一个出现的公共节点
    for (NSInteger i = pathA.count - 1; i >= 0; i --) {
        for (NSInteger j = pathB.count - 1; j >= 0; j --) {
            if (pathA[i] == pathB[j]) {
                return pathA[i];
            }
        }
    }
    return nil;
}

/**
 二叉树中两个节点之间的路径

 @param nodeA 第一个节点
 @param nodeB 第二个节点
 @param rootNode 二叉树根节点
 @return 两个节点间的路径
 */
+ (NSArray *)pathFromNode:(BinaryTreeNode *)nodeA toNode:(BinaryTreeNode *)nodeB inTree:(BinaryTreeNode *)rootNode{
    if (!rootNode || !nodeA || !nodeB) {
        return nil;
    }
    NSMutableArray *pathArray = [NSMutableArray array];
    if (nodeB == nodeA) {
        [pathArray addObject:nodeA];
        [pathArray addObject:nodeB];
        return pathArray;
    }
    
    NSArray *pathA = [self pathOfTreeNode:nodeA inTree:rootNode];
    NSArray *pathB = [self pathOfTreeNode:nodeB inTree:rootNode];
    if (pathA.count == 0 || pathB.count == 0) {
        return nil;
    }
    
    for (NSInteger i = pathA.count - 1; i >= 0; i --) {
        [pathArray addObject:pathA[i]];
        for (NSInteger j = pathB.count - 1; j >= 0; j --) {
            //找到公共父节点，则将pathB中后面的节点压入path
            if (pathA[i] == pathB[j]) {
                j ++;//防止公共节点多次添加
                while (j < pathB.count) {
                    [pathArray addObject:pathB[j]];
                    j ++;
                }
                return pathArray;
            }
        }
    }
    return nil;
}

/**
 二叉树两个节点之间的距离

 @param nodeA 第一个节点
 @param nodeB 第二个节点
 @param rootNode 根节点
 @return 返回两个节点距离（-1表示没有找到路径）
 */
+ (NSInteger)distanceFromNode:(BinaryTreeNode *)nodeA toNode:(BinaryTreeNode *)nodeB inTree:(BinaryTreeNode *)rootNode{
    if (!nodeA || !nodeB || !rootNode) {
        return -1;
    }
    if (nodeA == nodeB) {
        return 0;
    }
    //从根节点到节点A的路径
    NSArray *pathA = [self pathOfTreeNode:nodeA inTree:rootNode];
    //从根节点到节点B的路径
    NSArray *pathB = [self pathOfTreeNode:nodeB inTree:rootNode];
    //其中一个节点不在树中，则没有路径
    if (pathA.count == 0 || pathB.count == 0) {
        return -1;
    }
    //从后往前推，查找第一个出现的公共节点
    for (NSInteger i = pathA.count-1; i>=0; i--) {
        for (NSInteger j = pathB.count - 1; j>=0; j--) {
            //找到公共父节点
            if ([pathA objectAtIndex:i] == [pathB objectAtIndex:j]) {
                //距离=路径节点数-1 （这里要-2，因为公共父节点重复了一次）
                return (pathA.count - i) + (pathB.count - j) - 2;
            }
        }
    }
    return -1;
}

/**
 反转二叉树
 二叉树镜像

 @param rootNode 根节点
 @return 翻转后的树根节点（其实就是原二叉树的根节点）
 */
+ (BinaryTreeNode *)invertBinaryTree:(BinaryTreeNode *)rootNode{
    if (!rootNode) {
        return nil;
    }
    if (!rootNode.leftNode && !rootNode.rightNode) {
        return rootNode;
    }
    [self invertBinaryTree:rootNode.leftNode];
    [self invertBinaryTree:rootNode.rightNode];
    BinaryTreeNode *tempNode = rootNode.leftNode;
    rootNode.leftNode = rootNode.rightNode;
    rootNode.rightNode = tempNode;
    return rootNode;
}

/**
 判断二叉树是否是完全二叉树
 完全二叉树定义为：若设二叉树的高度为h，除第h 层外，其它各层的节点数都达到最大个数，第h 层有叶子节点数，并且叶子节点数都是从左到右一次排布
 完全二叉树必须满足2个条件：
 1.如果某个节点的右子树不为空，那它的左子树必须不为空；
 2.如果某个节点的右子树为空，则排在它后面的节点必须没有孩子节点

 @param rootNode 根节点
 @return 是否是完全二叉树
 */
+ (BOOL)isCompleteBinaryTree:(BinaryTreeNode *)rootNode{
    if (!rootNode) {
        return NO;
    }
    if (!rootNode.leftNode && !rootNode.rightNode) {
        return YES;
    }
    if (!rootNode.leftNode && rootNode.rightNode) {
        return NO;
    }
    NSMutableArray *queue = [NSMutableArray array];
    [queue addObject:rootNode];
    BOOL isComplete = NO;
    while (queue.count > 0) {
        BinaryTreeNode *node = queue.firstObject;
        [queue removeObjectAtIndex:0];
        
        if (!node.leftNode && node.rightNode) {
            return NO;
        }
        
        if (isComplete && (node.leftNode || node.rightNode)) {
            //前面的节点已满足完全二叉树,如果还有孩子节点，则不是完全二叉树
            return NO;
        }
        //右子树为空，则已经满足完全二叉树
        if (!node.rightNode) {
            isComplete = YES;
        }
        
        //压入
        if (node.leftNode) {
            [queue addObject:node.leftNode];
        }
        if (node.rightNode) {
            [queue addObject:node.rightNode];
        }
    }
    return isComplete;
}

/**
 是否是满二叉树
 满二叉树：除了叶节点外，每个节点都有左右叶子节点且叶子节点都处在最底层的二叉树
 满二叉树的一个特性是：叶子数=2^(深度-1)，因此我们可以根据这个特性来判断二叉树是否是满二叉树。

 @param rootNode 根节点
 @return 是否是满二叉树
 */
+ (BOOL)isFullBinaryTree:(BinaryTreeNode *)rootNode{
    if (!rootNode) {
        return NO;
    }
    //深度
    NSInteger depth = [self depthOfTree:rootNode];
    //叶子节点数
    NSInteger leafNum = [self numberOfLeafsInTree:rootNode];
    
    if (leafNum == pow(2, (depth - 1))) {
        return YES;
    }
    return NO;
}

/**
 判断二叉树是否是平衡二叉树

 @param rootNode 根节点
 @return 是否是平衡二叉树
 */
+ (BOOL)isAVLBinaryTree:(BinaryTreeNode *)rootNode{
    static NSInteger height = 0;
    if (!rootNode) {
        height = 0;
        return YES;
    }
    if (!rootNode.leftNode && !rootNode.rightNode) {
        height = 1;
        return YES;
    }
    BOOL isAVLLeft = [self isAVLBinaryTree:rootNode.leftNode];
    NSInteger leftHeight = height;
    BOOL isAVLRight = [self isAVLBinaryTree:rootNode.rightNode];
    NSInteger rightHeight = height;
    if (isAVLLeft && isAVLRight && ABS(leftHeight - rightHeight) <= 1) {
        return YES;
    }
    return NO;
}

@end
