//
//  BHPrivateModel.h
//  BHPrivatePod
//
//  Created by Jack on 2018/12/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BHPrivateModel : NSObject

/** name */
@property (nonatomic, copy) NSString *name;
/** 年龄 */
@property (nonatomic, assign) NSInteger age;

@end

NS_ASSUME_NONNULL_END
