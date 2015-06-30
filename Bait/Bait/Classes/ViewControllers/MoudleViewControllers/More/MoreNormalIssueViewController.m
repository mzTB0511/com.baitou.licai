//
//  MoreNormalIssueViewController.m
//  Bait
//
//  Created by 刘轩 on 15/6/23.
//  Copyright (c) 2015年 刘轩. All rights reserved.
//

#import "MoreNormalIssueViewController.h"
#import "IssueQuestionListCell.h"

@interface MoreNormalIssueViewController ()<UITableViewDelegate,UITableViewDataSource>


@property (weak, nonatomic) IBOutlet UISearchBar *sb_Searchbar;

@property (weak, nonatomic) IBOutlet UITableView *tbv_IssureList;

@property(strong,nonatomic) NSMutableArray *dataList;

@property(strong,nonatomic) IssueQuestionListCell *issueCell;

@property(strong,nonatomic) NSIndexPath *lastIndexPaht;


@end

@implementation MoreNormalIssueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setViewTitle:@"常见问题"];
    // Do any additional setup after loading the view, typically from a nib.
    _dataList = [NSMutableArray array];
    
    NSMutableDictionary *dict1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"这个是测试问题是测试问题的答案是测试问题的答案是测试问题的答案",@"question",
                                  @"这条是测试问题的答案这条是测试问题的答案这条是测试问题的答案这条是测试问题的答案这条是测试问题的答案这条是测试问题的答案",@"answer",@"0",@"status", nil];
    
    
    NSMutableDictionary *dict2 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"这个是测试问题的答案这条是测试问题的是测试问题",@"question",
                                  @"这条是测试问题的答案这条是测试问题的答案这条是测试问题的答案这条是测试问题的答案这条是测试问题的答案这条是测试问题的答案",@"answer",@"0",@"status", nil];
    
    
    NSMutableDictionary *dict3 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"这个是测试问题",@"question",
                                  @"这条是测试问题的答案这条是测试问题的答案这条是测试问题的答案这条是测试问题的答案这条是测试问题的答案这条是测试问题的答案",@"answer",@"0",@"status", nil];
    
    NSMutableDictionary *dict4 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"这个是测试问题",@"question",
                                  @"这条是测试问题的答案这条是测试问题的答案这条是测试问题的答案这条是测试问题的答案这条是测试问题的答案这条是测试问题的答案",@"answer",@"0",@"status", nil];
    
    NSMutableDictionary *dict5 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"这个是测试问题",@"question",
                                  @"这条是测试问题的答案这条是测试问题的答案这条是测试问题的答案这条是测试问题的答案这条是测试问题的答案这条是测试问题的答案",@"answer",@"0",@"status", nil];
    
    [_dataList addObjectsFromArray:@[dict1,dict2,dict3,dict4,dict5]];
    
    //**注册cell
    [_tbv_IssureList registerNib:[UINib nibWithNibName:@"IssueQuestionListCell" bundle:nil] forCellReuseIdentifier:@"IssueQuestionListCell"];
    
    _issueCell = [_tbv_IssureList dequeueReusableCellWithIdentifier:@"IssueQuestionListCell"];
    
}


-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataList.count;
}


-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dict = [_dataList objectAtIndex:indexPath.row];
    
    [_issueCell.lb_Question setText:[dict objectForKey:@"question"]];
    [_issueCell.lb_Answer setText:[dict objectForKey:@"answer"]];
    
    
    if ([[dict objectForKey:@"status"] integerValue] == 1) {
        [_issueCell.lb_Answer setHidden:NO];
        _issueCell.ly_bottom.priority = 250;
        _issueCell.ly_center.priority = 750;
        
        
    }else{
        [_issueCell.lb_Answer setHidden:YES];
        _issueCell.ly_bottom.priority = 750;
        _issueCell.ly_center.priority = 250;
    }
    
    //  [_issueCell.lb_Answer setText:[dict objectForKey:@"answer"]];
    
    CGSize size = [_issueCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    
    return size.height + 1;
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    IssueQuestionListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IssueQuestionListCell" forIndexPath:indexPath];
    
    NSDictionary *dict = [_dataList objectAtIndex:indexPath.row];
    
    [cell.lb_Question setText:[dict objectForKey:@"question"]];
    
    [cell.lb_Answer setText:[[_dataList objectAtIndex:indexPath.row] objectForKey:@"answer"]];
    
    if ([[dict objectForKey:@"status"] integerValue] == 1) {
        [cell.lb_Answer setHidden:NO];
        cell.ly_bottom.priority = 250;
        cell.ly_center.priority = 750;
        
    }else{
        [cell.lb_Answer setHidden:YES];
        cell.ly_bottom.priority = 750;
        cell.ly_center.priority = 250;
        
    }
    
    [cell.btn_Arraw setTag:indexPath.row];
    
    
    [cell.btn_Arraw addTarget:self action:@selector(actionBtnArrow:) forControlEvents:UIControlEventTouchUpInside];
    
    
    return cell;
    
}



-(void)actionBtnArrow:(UIButton *)sender{
    
    NSMutableArray *updateArray = [NSMutableArray array];
    //** 如果之前已经有有展开的项目需要关闭
    if (_lastIndexPaht) {
        [[_dataList objectAtIndex:_lastIndexPaht.row] setObject:@"0" forKey:@"status"];
        [updateArray addObject:_lastIndexPaht];
    }
    
    //** 取得索引填充数据 ，刷新当前cell
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:sender.tag inSection:0];
    
    
    [[_dataList objectAtIndex:sender.tag] setObject:@"1" forKey:@"status"];
    
    IssueQuestionListCell *cell = (IssueQuestionListCell *)[_tbv_IssureList cellForRowAtIndexPath:indexPath];
    
    [cell.lb_Answer setText:[[_dataList objectAtIndex:indexPath.row] objectForKey:@"answer"]];
    
    [updateArray addObject:indexPath];
    [_tbv_IssureList beginUpdates];
    [_tbv_IssureList reloadRowsAtIndexPaths:updateArray withRowAnimation:UITableViewRowAnimationAutomatic];
    [_tbv_IssureList endUpdates];
    
    _lastIndexPaht = indexPath;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
