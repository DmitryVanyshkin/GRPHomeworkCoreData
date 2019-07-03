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

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero];
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"cell"];
    
    if ([[NSUserDefaults.standardUserDefaults valueForKey:@"IsCoreDataLoaded"] boolValue] == NO)
    {
        [self write];
    }

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.navigationItem.title = @"Table";
    [self.view addSubview:self.tableView];
    [self setConstraints];
}

-(void) write
{
    [[CoreDataStack shared].container performBackgroundTask:^(NSManagedObjectContext * _Nonnull context) {
        for (NSInteger index = 0; index < 10000; index++) {
            CollectionElement *element = [[CollectionElement alloc]initWithContext : context];
            element.homeworkIndexValue = index;
        }
        BOOL isSaved = [context save:nil];
        if (isSaved)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }
    }];
    [NSUserDefaults.standardUserDefaults setBool:YES forKey:@"IsCoreDataLoaded"];
}

-(void) setConstraints
{
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.tableView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor].active = YES;
    [self.tableView.leftAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leftAnchor].active = YES;
    [self.tableView.rightAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.rightAnchor].active = YES;
    [self.tableView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor].active = YES;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    NSManagedObjectContext *viewContext = [CoreDataStack shared].container.viewContext;
    
     __block NSInteger indexNumber = 0;
    
    [viewContext performBlock:^{
        NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"CollectionElement"];
        NSPredicate *countPredicate = [NSPredicate predicateWithFormat:@"homeworkIndexValue == %@", @(indexPath.row)];
        request.predicate = countPredicate;

        NSArray<CollectionElement*> *result = [viewContext executeFetchRequest:request error:nil];

        indexNumber = result.firstObject.homeworkIndexValue;
        cell.textLabel.text = [NSString stringWithFormat:@"Index from core data is %@", @(indexNumber)];
    }];

    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSUInteger amountOfElements = 10;
    
    NSManagedObjectContext *viewContext = [CoreDataStack shared].container.viewContext;
    
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"CollectionElement"];
    
    NSUInteger amount = [viewContext countForFetchRequest:request error:nil];
    amountOfElements = amount;
    
    return amountOfElements;
}

@end
