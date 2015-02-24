//
//  _GISViewController.m
//  Currency Converter
//
//  Created by Alexander Dupree on 21.02.15.
//  Copyright (c) 2015 Alexander Dupree - [~/psycho/path]>_. All rights reserved.
//

#import "_GISViewController.h"

CGFloat const statusBarHeight = 20.0f;
CGFloat const separatorOffset = 40.0f;
CGFloat const separatorheight = 4.0f;

NSString * const segueId = @"showMoreCurrencies";

@interface _GISViewController ()

@end

@implementation _GISViewController
{
    BOOL viewHaveBeenShowedAgain;
}
@synthesize sourceLabel, targetLabel, preloaderView, targetCurrencySeeMore, separator;

#pragma mark - ViewController Lifecicle

- (void)viewDidLoad
{
    [super viewDidLoad];
    //first of all we need to register a notification
    //because we should know when shall we get data from server.
    [self registerForNotifications];
    //after we've registered our notification
    //we should draw the user interface
    [self createUserInterface];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if(viewHaveBeenShowedAgain)
    {
        [sourceLabel removeFromSuperview];
        [targetLabel removeFromSuperview];
        [separator removeFromSuperview];
    
        [self drawLabelsWithSeparator];
        
        if([self.view isKindOfClass:[_GISMainScreenView class]])
        {
            _GISMainScreenView *mainView = (_GISMainScreenView *)self.view;
            [mainView removeDarkness];
        }
    }
}

#pragma mark - Views Drawing Part

- (void)createUserInterface
{
    //setting up main view
    _GISMainScreenView *mainView = [[_GISMainScreenView alloc] init];
    [mainView setFrame:self.view.bounds];
    [self setView:mainView];
    
    [self drawKeyBoard];
    [self drawLabelsWithSeparator];
    
    preloaderView = [[_GISDataReceivingPreloader alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:preloaderView];
}

- (void)drawLabelsWithSeparator
{
    //drawing source label
    sourceLabel = [[_GISSourceSum alloc] init];
    [sourceLabel setFrame:CGRectMake(self.view.bounds.origin.x,
                                     self.view.bounds.origin.y+statusBarHeight,
                                     self.view.bounds.size.width,
                                     (self.view.bounds.size.height/2-statusBarHeight)/2)];
    [sourceLabel setDelegate:(id)self];
    
    //draw separator between labels
    separator = [[_GISSeparator alloc] initWithFrame:CGRectMake(separatorOffset,
                                                                               sourceLabel.bounds.size.height-separatorheight/2+statusBarHeight,
                                                                               self.view.bounds.size.width-2*separatorOffset,
                                                                               separatorheight)];
    [self.view addSubview:separator];
    [self.view addSubview:sourceLabel];
    
    //drawing target label
    targetLabel = [[_GISTargetSumLabel alloc] init];
    [targetLabel setFrame:CGRectMake(self.view.bounds.origin.x,
                                     sourceLabel.bounds.size.height+statusBarHeight,
                                     self.view.bounds.size.width,
                                     (self.view.bounds.size.height/2-statusBarHeight)/2)];
    [targetLabel setDelegate:(id)self];
    [self.view addSubview:targetLabel];
}

- (void) drawKeyBoard
{
    //drawing keyboard
    _GISKeyboardContainer *keyBoard = [[_GISKeyboardContainer alloc] init];
    [keyBoard setFrame:CGRectMake(self.view.bounds.origin.x,
                                  self.view.bounds.size.height/2,
                                  self.view.bounds.size.width,
                                  self.view.bounds.size.height/2)];
    [keyBoard setDelegate:(id)self];
    [self.view addSubview:keyBoard];
}

#pragma mark - Keyboard Delegated Methods

- (void)tapNumeric:(_GISKeyboardButton *)button
{
    if([_GISKeyBoardHelper userCouldTypeMoreNumbersToLabelWithText:sourceLabel.text])
    {
        if(sourceLabel.text && ![sourceLabel.text isEqualToString:@"0"])
        {
            [sourceLabel setText:[NSString stringWithFormat:@"%@%@", sourceLabel.text, button.titleLabel.text]];
        }
        else
        {
            [sourceLabel setText:button.titleLabel.text];
        }
    }
    
    [targetLabel setText:[_GISCountHelper countTargetMoneyUsingSourceMoney:sourceLabel.text]];
}

- (void)tapClean:(_GISKeyboardButton *)button
{
    
    if (sourceLabel.text.length > 1)
    {
        [sourceLabel setText:[sourceLabel.text substringToIndex:(sourceLabel.text.length-1)]];
    }
    else
    {
        [sourceLabel setText:@"0"];
    }
    [targetLabel setText:[_GISCountHelper countTargetMoneyUsingSourceMoney:sourceLabel.text]];
}

#pragma mark - Source Label Delegated Methods

-(void)sourceCurrencyButtonDidTap
{
    if([self.view isKindOfClass:[_GISMainScreenView class]])
    {
        _GISMainScreenView *mainView = (_GISMainScreenView *)self.view;
        [mainView drawDarkness];
        [mainView bringSubviewToFront:sourceLabel];
    }
}

- (void)sourceAdditionalButtonsDidHide
{
    if([self.view isKindOfClass:[_GISMainScreenView class]])
    {
        _GISMainScreenView *mainView = (_GISMainScreenView *)self.view;
        [mainView removeDarkness];
    }
    [targetLabel setText:[_GISCountHelper countTargetMoneyUsingSourceMoney:sourceLabel.text]];
}

- (void)showMoreSourceCurrenciesButtonDidTap
{
    targetCurrencySeeMore = NO;
    
    [self performSegueWithIdentifier:segueId sender:self];
}

#pragma mark - Target Label Delegated Methods

- (void)targetCurrencyButtonDidTap
{
    if([self.view isKindOfClass:[_GISMainScreenView class]])
    {
        _GISMainScreenView *mainView = (_GISMainScreenView *)self.view;
        [mainView drawDarkness];
        [mainView bringSubviewToFront:targetLabel];
    }
}

- (void)targetAdditionalButtonsDidHide
{
    if([self.view isKindOfClass:[_GISMainScreenView class]])
    {
        _GISMainScreenView *mainView = (_GISMainScreenView *)self.view;
        [mainView removeDarkness];
    }
    [targetLabel setText:[_GISCountHelper countTargetMoneyUsingSourceMoney:sourceLabel.text]];
}

- (void)showMoreTargetCurrenciesButtonDidTap
{
    targetCurrencySeeMore = YES;
    
    [self performSegueWithIdentifier:segueId sender:self];
}

#pragma mark - Notifications
/**
 Register "data updating" notification
 */
- (void)registerForNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(remoteServerRespondedWithNotification:)
                                                 name:dataArrivedNotification
                                               object:nil];
}


/**
 Handling recived notification
 To be honest. User could interract with application only after data've been recived.
 */
- (void)remoteServerRespondedWithNotification:(NSNotification *)notification
{
    if(preloaderView) [preloaderView showSuccessStatus];
    viewHaveBeenShowedAgain = YES;
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:segueId])
    {
        if([segue.destinationViewController isKindOfClass:[_GISCurrenciesViewController class]])
        {
            _GISCurrenciesViewController *destVC = (_GISCurrenciesViewController *)segue.destinationViewController;
            
            [destVC setTargetCurrency:targetCurrencySeeMore];
        }
    }
}


@end
