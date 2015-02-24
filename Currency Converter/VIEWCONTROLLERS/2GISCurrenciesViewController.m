//
//  2GISCurrenciesViewController.m
//  Currency Converter
//
//  Created by Alexander Dupree on 24.02.15.
//  Copyright (c) 2015 Alexander Dupree - [~/psycho/path]>_. All rights reserved.
//

#import "2GISCurrenciesViewController.h"

NSString * const cellId = @"Cell";
NSString * const closeButtonImageName = @"closeButton";
CGFloat const keyBoardHeight = 216.0f;

@interface _GISCurrenciesViewController ()

@end

@implementation _GISCurrenciesViewController

@synthesize currenciesSearchBar, currenciesTableView, currencuesWithoutTop, totalCurrencies, filteredCurrencies, isFiltered, headerView, closeButton, targetCurrency;

#pragma mark - ViewController Lifecicle

- (void)loadView
{
    [super loadView];
    
    //setting up currencies data before view've been loaded
    currencuesWithoutTop = [[NSMutableArray alloc] initWithArray:[_GISCurrencies getCurrencies]];
    totalCurrencies = [[NSMutableArray alloc] initWithArray:currencuesWithoutTop];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //setting up interface
    [self createUserInterface];
}


#pragma mark - Views Drawing Part

- (void)createUserInterface
{
    [self.view setBackgroundColor:MAIN_BACKGROUND_COLOR];
    [self drawHeader];
    [self drawSearchBar];
    [self drawTableView];
}

- (void)drawHeader
{
    //header container
    headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, self.view.bounds.size.width, 50.0f)];
    [headerView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:headerView];
    
    //header close button
    UIImage *closeButtonImage = [UIImage imageNamed:closeButtonImageName];
    closeButton = [[UIButton alloc] initWithFrame:
    CGRectMake(
               0.5*closeButtonImage.size.width,
               (headerView.bounds.size.height-closeButtonImage.size.height)/2,
                closeButtonImage.size.width,
               closeButtonImage.size.height
               )];
    [closeButton setBackgroundImage:closeButtonImage forState:UIControlStateNormal];
    [closeButton.layer setShadowColor:[UIColor blackColor].CGColor];
    [closeButton.layer setShadowOffset:CGSizeMake(1.0f, 1.0f)];
    [closeButton.layer setShadowOpacity:.5f];
    [closeButton.layer setShadowRadius:2.0f];
    [closeButton addTarget:self action:@selector(closeScreen:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:closeButton];
    
    //screen name label
    UILabel *screenName = [[UILabel alloc] initWithFrame:CGRectMake(closeButton.frame.origin.x+closeButton.frame.size.width,
                                                                   closeButton.frame.origin.y,
                                                                   headerView.frame.size.width-2*(closeButton.frame.origin.x+ closeButton.frame.size.width),
                                                                    closeButton.frame.size.height)];
    [screenName setTextAlignment:NSTextAlignmentCenter];
    [screenName setTextColor:targetCurrency?TARGET_FONT_COLOR:SOURCE_FONT_COLOR];
    [screenName setText:targetCurrency?NSLocalizedString(@"Target Currency", nil):NSLocalizedString(@"Source Currency", nil)];
    [screenName.layer setShadowColor:[UIColor blackColor].CGColor];
    [screenName.layer setShadowOffset:CGSizeMake(1.0f, 1.0f)];
    [screenName.layer setShadowOpacity:.5f];
    [screenName.layer setShadowRadius:2.0f];
    [screenName setFont:[UIFont fontWithName:@"Helvetica-Bold" size:21.0f]];
    [headerView addSubview:screenName];
}

- (void)drawSearchBar
{
    //searh bar
    currenciesSearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, headerView.bounds.size.height+headerView.frame.origin.y, self.view.bounds.size.width, headerView.bounds.size.height)];
    [currenciesSearchBar setBackgroundImage:[UIImage imageNamed:@"mainBackgroundPattern"]];
    [currenciesSearchBar setDelegate:(id)self];
    [self.view addSubview:currenciesSearchBar];
}

- (void)drawTableView
{
    //table view
    currenciesTableView = [[UITableView alloc]init];
    [currenciesTableView setFrame:CGRectMake(0,currenciesSearchBar.frame.origin.y+currenciesSearchBar.frame.size.height,self.view.bounds.size.width,self.view.bounds.size.height-currenciesSearchBar.frame.origin.y-currenciesSearchBar.frame.size.height)];
    [currenciesTableView setBackgroundColor:TABLEVIEW_COLOR];
    [currenciesTableView setSeparatorInset:UIEdgeInsetsMake(0, 10.0f, 0, 10.0f)];
    [currenciesTableView setSeparatorColor:MAIN_BACKGROUND_COLOR];
    [currenciesTableView setDataSource:(id)self];
    [currenciesTableView setDelegate:(id)self];
    [currenciesTableView setAutoresizingMask:(UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth)];
    [currenciesTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellId];
    [currenciesTableView reloadData];
    [self.view addSubview:currenciesTableView];
}

#pragma mark - Table View Datasource & Delegate Methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(!isFiltered)
    {
        return totalCurrencies.count;
    }
    return filteredCurrencies.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    
    [cell setBackgroundColor:[UIColor clearColor]];
    
    if(!isFiltered)
    {
        cell.textLabel.text = [[totalCurrencies objectAtIndex:indexPath.row] valueForKey:displayKey];
    }
    else
    {
        cell.textLabel.text = [[filteredCurrencies objectAtIndex:indexPath.row] valueForKey:displayKey];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *selectedCurrency = [totalCurrencies objectAtIndex:indexPath.row];
    
    if(isFiltered)
        selectedCurrency = [filteredCurrencies objectAtIndex:indexPath.row];
    
    
    if(targetCurrency)
    {
        [[_GISCurrencies sharedCurrencies] setSelectedTargetCurrency:selectedCurrency];
    }
    else
    {
        [[_GISCurrencies sharedCurrencies] setSelectedSourceCurrency:selectedCurrency];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma Mark - SearchBarDelegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if(searchText.length == 0)
    {
        isFiltered = NO;
    }
    else
    {
        isFiltered = YES;
        
        filteredCurrencies = [[NSMutableArray alloc] init];
        
        for(NSDictionary *currency in currencuesWithoutTop)
        {
            NSString *string = [currency valueForKey:displayKey];
            NSRange stringRange = [string rangeOfString:searchText options:NSCaseInsensitiveSearch];
            
            if(stringRange.location != NSNotFound)
            {
                [filteredCurrencies addObject:currency];
            }
        }
    }
    
    [currenciesTableView reloadData];
}

-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    [currenciesTableView setFrame:CGRectMake(currenciesTableView.frame.origin.x,
                                            currenciesTableView.frame.origin.y,
                                            currenciesTableView.frame.size.width,
                                             currenciesTableView.frame.size.height-keyBoardHeight)];
    [currenciesTableView reloadData];
    
    return YES;
}

#pragma mark - Actions

- (IBAction)closeScreen:(UIButton *)button
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
