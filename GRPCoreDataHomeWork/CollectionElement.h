//
//  CollectionElement.h
//  GRPCoreDataHomeWork
//
//  Created by Дмитрий Ванюшкин on 26/06/2019.
//  Copyright © 2019 Dmitry Vanyushkin. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreData;

NS_ASSUME_NONNULL_BEGIN

@interface CollectionElement : NSManagedObject

@property (nonatomic, assign) NSInteger hwIndexValue;

@end

NS_ASSUME_NONNULL_END
