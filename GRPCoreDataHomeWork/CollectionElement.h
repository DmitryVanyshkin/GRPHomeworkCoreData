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

/**
 Класс, который является представлением хранимых в нашей БД данных
 */
@interface CollectionElement : NSManagedObject

/**
 Числовое значение у объекта данного класса
 */
@property (nonatomic, assign) NSInteger homeworkIndexValue;

@end

NS_ASSUME_NONNULL_END
