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
                [cannelButton setTintColor:[UIColor whiteColor]];
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


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    IssueQuestionListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IssueQuestionListCell" forIndexPath:indexPath];
    
    IssueModule *naturaItem = [_questionList objectAtIndex:indexPath.row];
    
    //[cell setFoodModule:naturaItem];
    
    return cell;
    
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
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        // 调用接口 执行登陆验证操作
        
        void(^tempBlock)(void) = ^{
            
            stopTableViewRefreshAnimation(_tableView_SearchList);
            
        };
        
        /*
         
         [NetworkHandle loadDataFromServerWithParamDic:@{@"type":@"",
         @"name":_searchBar.text,
         @"page":[NSString stringWithFormat:@"%i",pageIndex]}
         signDic:nil
         interfaceName:InterfaceAddressName(@"nutrition/search")
         success:^(NSDictionary *responseDictionary, NSString *message) {
         
         if ([responseDictionary objectForKey:@"list"]) {
         
         //* 新增单菜结果集
         
         NSMutableArray *foodList = [self makeReturnDataWithData:[responseDictionary objectForKey:@"list"]];
         
         [_foodList addObjectsFromArray:foodList];
         
         [self.tableView_SearchList reloadData];
         
         if (_foodList.count == 0) {
         
         [self setEmptyHintMessage:@"没有你要的食材"];
         }else{
         [self removeEmptyHint];
         }
         
         }
         
         tempBlock();
         }
         failure:tempBlock
         networkFailure:tempBlock];
         
         */
    });
}



-(NSMutableArray *)makeReturnDataWithData:(NSArray *)list{
    
    NSMutableArray *retData = [NSMutableArray array];
    for (NSObject *obj in list) {
        NSDictionary *dict = (NSDictionary *)obj;
        
        if ([[dict objectForKey:@"datatype"] intValue] == 1) {
            
            IssueModule *issue = [IssueModule new];
            [issue voluationWithData:dict];
            
            [retData addObject:issue];
            
        }
        
        
    }
    
    return retData;
    
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


