//
//  FoodSearchViewController.m
//  Project_App
//
//  Created by 刘轩 on 15/3/13.
//  Copyright (c) 2015年 刘轩. All rights reserved.
//

#import "IssueListSearchViewController.h"
#import "IssueModule.h"
#import "IssueQuestionListCell.h"

#import "NetworkHandle.h"
#import "MJRefresh.h"


@interface IssueListSearchViewController() <UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>{
    
    NSInteger pageIndex;
    
}


//** ViewType 当前视图处理事件的类型
@property(nonatomic,strong)NSString *viewType;


@property(nonatomic,strong) NSMutableArray *questionList;

@property (strong, nonatomic) UISearchBar *searchBar;

@property (strong, nonatomic) IBOutlet UITableView *tableView_SearchList;

//** 缓存搜索内容
@property (strong, nonatomic) NSString *searchConBak;

@property(strong,nonatomic) NSIndexPath *lastIndexPaht;

@property(strong,nonatomic) IssueQuestionListCell *issueCell;

@end

@implementation IssueListSearchViewController

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}



-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /**
     *  初始化SearchBar
     *
     *  @return
     */
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 50, 44)];
    _searchBar.placeholder = @"输入搜索内容";
    _searchBar.delegate = self;
    [_searchBar setBackgroundColor:[UIColor clearColor]];
    _searchBar.backgroundImage = [self imageWithColor:[UIColor clearColor]];
    _searchBar.keyboardType = UIKeyboardTypeDefault;
    _searchBar.barTintColor = [UIColor clearColor];
    _searchBar.showsCancelButton = YES;
    [_searchBar canBecomeFirstResponder];
    [_searchBar becomeFirstResponder];
    
    [self.navigationItem setTitleView:_searchBar];
    
    UIView *subViewSearchBar = _searchBar.subviews[0]; // IOS7.0中searchBar组成复杂点
    if ([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0) {
        for (UIView *subView in subViewSearchBar.subviews)
        {
            // 获得UINavigationButton按钮，也就是Cancel按钮对象，并修改此按钮的各项属性
            if ([subView isKindOfClass:[UIButton class]]) {
                UIButton *cannelButton = (UIButton*)subView;
                [cannelButton setTitle:@"取消"forState:UIControlStateNormal];
                [cannelButton setTintColor:[UIColor blackColor]];
                break;
            }
        }
        
    }
    
    /**
     *  注册自定义Cell
     */
    [self.tableView_SearchList registerNib:[UINib nibWithNibName:@"IssueQuestionListCell" bundle:nil] forCellReuseIdentifier:@"IssueQuestionListCell"];
    
    self.questionList = [NSMutableArray array];
    
    
    pageIndex = 1;
    
    [self setupRefresh];
    
}


- (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


-(void)backToView{
    
    [self.navigationController popViewControllerAnimated:YES];
}




#pragma mark -- UITabelViewDelegate
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return _questionList.count;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dict = [_questionList objectAtIndex:indexPath.row];
    
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
    
    NSDictionary *dict = [_questionList objectAtIndex:indexPath.row];
    
    [cell.lb_Question setText:[dict objectForKey:@"question"]];
    
    [cell.lb_Answer setText:[[_questionList objectAtIndex:indexPath.row] objectForKey:@"answer"]];
    
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
        [[_questionList objectAtIndex:_lastIndexPaht.row] setObject:@"0" forKey:@"status"];
        [updateArray addObject:_lastIndexPaht];
    }
    
    //** 取得索引填充数据 ，刷新当前cell
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:sender.tag inSection:0];
    
    
    [[_questionList objectAtIndex:sender.tag] setObject:@"1" forKey:@"status"];
    
    IssueQuestionListCell *cell = (IssueQuestionListCell *)[_tableView_SearchList cellForRowAtIndexPath:indexPath];
    
    [cell.lb_Answer setText:[[_questionList objectAtIndex:indexPath.row] objectForKey:@"answer"]];
    
    [updateArray addObject:indexPath];
    [_tableView_SearchList beginUpdates];
    [_tableView_SearchList reloadRowsAtIndexPaths:updateArray withRowAnimation:UITableViewRowAnimationAutomatic];
    [_tableView_SearchList endUpdates];
    
    _lastIndexPaht = indexPath;
}



#pragma mark - UISearchBarDelegate

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    [_searchBar setShowsCancelButton:YES animated:YES];
    
}


-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    
    [self backToView];
    
}


/**
 *  开始搜索
 *
 *  @param searchBar 搜索控件
 */
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [_searchBar setShowsCancelButton:YES animated:YES];
    [searchBar canResignFirstResponder];
    [searchBar resignFirstResponder];
    
    if (searchBar) {
        
        if(![_searchBar.text isEqualToString:_searchConBak]){
            pageIndex = 1;
            [_questionList removeAllObjects];
        }
        
    }
    
    WEAKSELF
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        // 调用接口 执行登陆验证操作
        
        void(^tempBlock)(void) = ^{
            
            stopTableViewRefreshAnimation(_tableView_SearchList);
            
        };
        
      
         
         [NetworkHandle loadDataFromServerWithParamDic:@{@"key":searchBar.text}
         signDic:nil
         interfaceName:InterfaceAddressName(@"issue/search")
         success:^(NSDictionary *responseDictionary, NSString *message) {
         
         if ([responseDictionary objectForKey:Return_data]) {
         
         //* 新增单菜结果集
         [weakSelf makeTbvDataSoureWithData:responseDictionary];
         
         if (_questionList.count == 0) {
         
         [self setEmptyHintMessage:@"没有你要问题"];
         }else{
         [self removeEmptyHint];
         }
         
         }
         
         tempBlock();
         }
         failure:tempBlock
         networkFailure:tempBlock];
         
        
    });
}




-(void)makeTbvDataSoureWithData:(NSDictionary *)dict{
    
    if ([dict isKindOfClass:[NSDictionary class]]) {
        
        if ([dict objectForKey: Return_data]) {
            
            
            NSArray *issueList = [dict objectForKey: Return_data];
            
            for (NSObject *obj  in issueList) {
                NSDictionary *issueDict = (NSDictionary *)obj;
                
                NSMutableDictionary *muIssueDict = [NSMutableDictionary dictionaryWithDictionary:issueDict];
                [muIssueDict setObject:@"0" forKey:@"status"];
                
                [_questionList addObject:muIssueDict];
                
            }
            
            [_tableView_SearchList reloadData];
            
        }
        
    }
    
}


#pragma mark - 集成下拉上提

- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    //[self.tableView_SearchList addHeaderWithTarget:self action:@selector(headerRereshing)];
    
    //[self.view_newsView headerBeginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.tableView_SearchList addFooterWithTarget:self action:@selector(footerRereshing)];
    
    //    [self.view_newsView setFooterHidden:YES];
    // [self beginRefresh];
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    //刷新代码
    pageIndex = 1;
    
    
}

- (void)footerRereshing
{
    //加载代码
    pageIndex ++;
    
    [self searchBarSearchButtonClicked:nil];
}


@end


