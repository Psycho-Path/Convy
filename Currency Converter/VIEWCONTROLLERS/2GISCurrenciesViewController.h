//
//  2GISCurrenciesViewController.h
//  Currency Converter
//
//  Created by Alexander Dupree on 24.02.15.
//  Copyright (c) 2015 Alexander Dupree - [~/psycho/path]>_. All rights reserved.
//

#import <UIKit/UIKit.h>

#define MAIN_BACKGROUND_COLOR [UIColor colorWithPatternImage:[UIImage imageNamed:@"mainBackgroundPattern"]]
#define SEARCHBAR_COLOR [UIColor colorWithPatternImage:[UIImage imageNamed:@"searchBar_pattern"]]
#define TABLEVIEW_COLOR [UIColor colorWithPatternImage:[UIImage imageNamed:@"currencyTableViewBackGround"]]
#define SOURCE_FONT_COLOR [UIColor colorWithRed:45.0f/255.0f green:214.0f/255.0f blue:124.0f/255.0f alpha:1.0f]
#define TARGET_FONT_COLOR [UIColor colorWithRed:250.0f/255.0f green:85.0f/255.0f blue:132.0f/255.0f alpha:1.0f]

/**
 This view controller holds provides user to choose any currency he want
 There is a search bar in this controller, that helps user to find needed currency faster.
 
 By the way. The implementation of this class is pretty dirty, I know it. But I showed how could I write code in MainViewController. And in this controller I show how could I write code fast. It took about half an hour to write all of this stuff :)
 */
@interface _GISCurrenciesViewController : UIViewController<UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate>

/**
 The search bar
 */
@property (strong, nonatomic) IBOutlet UISearchBar *currenciesSearchBar;

/**
 Table view with currencies
 */
@property (strong, nonatomic) IBOutlet UITableView *currenciesTableView;

/**
 Array with all of the currencies
 */
@property (strong, nonatomic) NSMutableArray *totalCurrencies;

/**
 Filtered currencies. Filtered by search request.
 */
@property (strong, nonatomic) NSMutableArray *filteredCurrencies;

/**
 Currencies without top three (two) currencies.
 */
@property (strong, nonatomic) NSMutableArray *currencuesWithoutTop;


/**
 Flag that tells if currencies data nave been filtered
 */
@property (nonatomic) BOOL isFiltered;

/**
 Header view. Just view where screen title and close button are.
 */
@property (nonatomic, strong) IBOutlet UIView *headerView;

/**
 Button that closes this viewcontroller
 */
@property (nonatomic, strong) IBOutlet UIButton *closeButton;

/**
 Flag that determines kind of currency that user wants to choose.
 */
@property (nonatomic) BOOL targetCurrency;

@end
