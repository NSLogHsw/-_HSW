//
//  SWSettingViewController.m
//  百思不得姐_HSW
//
//  Created by  677676  on 17/1/6.
//  Copyright © 2017年 艾腾软件. All rights reserved.
//

#import "SWSettingViewController.h"

@interface SWSettingViewController ()

@end

@implementation SWSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"SWSettingViewController";
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView { 
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else{
        return 3;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0) {
        cell.textLabel.text = @"字体大小";
        
    }if (indexPath.section == 1)
    {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        if (indexPath.row == 0)
        {
            
            CGFloat size = [SDImageCache sharedImageCache].getSize / 1000.0 / 1000;
            cell.textLabel.text = [NSString stringWithFormat:@"清除缓存（已使用%.2fMB）", size];
        }else if (indexPath.row == 1)
        {
            cell.textLabel.text = @"常见问题";
        }else
        {
            cell.textLabel.text = @"关于我们";
        }
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CGFloat size = [SDImageCache sharedImageCache].getSize / 1000.0 / 1000;
    if (size != 0) {
        if (indexPath.section == 1 && indexPath.row == 0) {
            [[SDImageCache sharedImageCache] clearDisk];
            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
            [SVProgressHUD showWithStatus:@"删除缓存中..."];
        }
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self.tableView reloadData];
        [SVProgressHUD dismiss];
    });
    
}
@end
