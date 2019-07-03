//
//  CoreDataStack.h
//  GRPCoreDataHomeWork
//
//  Created by Дмитрий Ванюшкин on 26/06/2019.
//  Copyright © 2019 Dmitry Vanyushkin. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreData;

NS_ASSUME_NONNULL_BEGIN

/**
 Класс-синглтон, отвечающий за использование Core Data в приложении. Представляет собой синглтон
 */
@interface CoreDataStack : NSObject

/**
 Метод, возвращающий сущность данного класса и позволяющий работать с ней, смысл которого я описал выше

 @return возвращает CoreDataStack
 */
+(instancetype) shared;

/**
 Контейнер нашей БД. Через него мы сохраняем, читаем, обновляем и удаляем данные(в будущем) в базе данных
 */
@property (nonatomic, strong) NSPersistentContainer *container;

@end

NS_ASSUME_NONNULL_END
