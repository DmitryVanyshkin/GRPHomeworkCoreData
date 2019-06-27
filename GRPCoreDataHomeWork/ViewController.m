//
//  ViewController.m
//  GRPCoreDataHomeWork
//
//  Created by Дмитрий Ванюшкин on 26/06/2019.
//  Copyright © 2019 Dmitry Vanyushkin. All rights reserved.
//

#import "ViewController.h"
#import "CoreDataStack.h"
#import "CollectionElement.h"
@import CoreData;

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero];
    
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"cell"];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
//    self.view.backgroundColor = UIColor.whiteColor;
    
    self.navigationItem.title = @"Table";
//    [CoreDataStack sh]
    [self.view addSubview:self.tableView];
//    [self printDirectory];
    [self setConstraints];
//    [self write];
    // Do any additional setup after loading the view.
}


-(void) write
{
    [[CoreDataStack shared].container performBackgroundTask:^(NSManagedObjectContext * _Nonnull context) {
        
        
        for (NSInteger index = 0; index < 10000; index++) {
            CollectionElement *element = [[CollectionElement alloc]initWithContext : context ];
            element.hwIndexValue = index;
        }
        
        [context save:nil];
        
    }];
    
    
}

-(void) setConstraints
{
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.tableView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor].active = YES;
    [self.tableView.leftAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leftAnchor].active = YES;
    [self.tableView.rightAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.rightAnchor].active = YES;
    [self.tableView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor].active = YES;
    
}

-(void) printDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSLog(@"%@", documentsDirectory);
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    
    NSManagedObjectContext *viewContext = [CoreDataStack shared].container.viewContext;
    
    NSInteger indexNumber = 0;
    
    
    [viewContext performBlock:^{
        NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"CollectionElement"];
        NSPredicate *countPredicate = [NSPredicate predicateWithFormat:@"hwIndexValue == %@", @(indexPath.row)];
        request.predicate = countPredicate;

        NSArray<CollectionElement*> *result = [viewContext executeFetchRequest:request error:nil];

        __block(indexNumber) = result.firstObject.hwIndexValue;

        cell.textLabel.text = [NSString stringWithFormat:@"Index from core data is %@", @(indexNumber)];

    }];
    

    
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    __block NSUInteger amountOfElements = 10;
    
    NSManagedObjectContext *viewContext = [CoreDataStack shared].container.viewContext;
    
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"CollectionElement"];
    
    NSUInteger amount = [viewContext countForFetchRequest:request error:nil];
    amountOfElements = amount;
    
    return amountOfElements;
}



@end
