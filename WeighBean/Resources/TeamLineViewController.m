//
//  TeamLineViewController.m
//  WeighBean
//
//  Created by sealband on 16/8/17.
//  Copyright © 2016年 lmd. All rights reserved.
//

#import "TeamLineViewController.h"
#import "PersonalViewController.h"
#import "TeamObjModel.h"

@implementation TeamLineViewController

- (id)initWithTeamID:(NSString *)tid
{
    self = [super init];
    if (self) {
        teamid = tid;
    }
    return self;
}


- (void)initModel
{
    self.handle = [[TeamLineModelHandler alloc] initWithController:self];
    self.listModel = [[TeamListModel alloc] initWithHandler:self.handle];
    _dataArray = [[NSMutableArray alloc] init];
    
    self.likeHandle = [[LikeModelHandler alloc] initWithController:self];
    self.likeModel = [[LikeModel alloc] initWithHandler:self.likeHandle];

    if (teamid) {
        [self.listModel getTeamLisetInfoWithTeamID:teamid];
    }
}

- (void)initNavbar
{
}

- (void)initView
{
    
    
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    collection=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:layout];
    collection.backgroundColor = [UIColor clearColor];
    collection.delegate = self;
    collection.dataSource = self;
    [self.view addSubview:collection];
    
    [collection registerClass:[TeamLineCell class] forCellWithReuseIdentifier:@"MBImageCell"];

    
}

#pragma mark - collectionview delegate
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *rid = @"MBImageCell";
    TeamLineCell *cell = (TeamLineCell *)[collectionView dequeueReusableCellWithReuseIdentifier:rid forIndexPath:indexPath];
    if (!cell) {
        cell = [[TeamLineCell alloc] init];
    }
    cell.delegate =self;
    [cell loadContent:_dataArray[indexPath.row] path:indexPath];
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_dataArray count];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(DEVICEW/2-2, 420*(DEVICEW/2-2)/304);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 2;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 2;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsZero;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeZero;
}


- (void)syncFinished:(TeamLineResponse *)response
{
    [_dataArray removeAllObjects];
    [_dataArray addObjectsFromArray:response.data];
    [collection reloadData];

    
}
- (void)syncFailure
{
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    TeamObjModel *obj = _dataArray[indexPath.row];
    
    PersonalViewController *vc = [[PersonalViewController alloc] initPersonalUid:obj.uid];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)likeFinished:(LikeResponse *)response
{
    [self alert:nil message:response.msg delegate:nil cancelTitle:@"确定" otherTitles:nil];

}
- (void)likeFailure
{
    
}

- (void)likeDidClickWithDakaID:(NSString *)dakaID
{
    [self.likeModel postLikeWithPicID:dakaID];
}

- (void)commentDidClickWithDakaID:(NSString *)dakaID author:(NSString *)author
{
    CommentViewController *vc = [[CommentViewController alloc] initWithDakaID:dakaID anthor:author];
    [self.navigationController pushViewController:vc animated:YES];
}

//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
//{
//    //    return _dataArray.count;
//    return 1;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 360;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
//{
//    static NSString *identier = @"identier";
//    PersonalCell *cell = [tableView dequeueReusableCellWithIdentifier:identier];
//    if (!cell)
//    {
//        cell = [[PersonalCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identier];
//    }
//    __weak typeof(self) weakSelf = self;
//    //    [cell setSelectBlock:^(NSInteger index,OLProductModel *obj,NSIndexPath *path) {
//    //        [weakSelf selectIndex:index product:obj indexPath:path];
//    //    }];
//    //    [cell loadContent:_dataArray[indexPath.row] path:indexPath];
//    return cell;
//}
//
////- (void)selectIndex:(NSInteger )index product:(OLProductModel *)obj indexPath:(NSIndexPath *)path
////{
////    if (index == 3)
////    {
////        VerifyOrderViewController *ver = [[VerifyOrderViewController alloc] init];
////        ver.weburl = obj.taobaourl;
////        //        ver.weburl = @"http://item.taobao.com/item.htm?id=41029553793";
////        //        ver.clienturl = @"taobao://item.taobao.com/item.htm?id=41029553793";
////        [self.navigationController pushViewController:ver animated:YES];
////    }
////    else
////    {
////        self.selectPath = path;
////        NSString *msg = [NSString stringWithFormat:@"你确定要拨打%@电话%@吗?",(index == 1 ? @"售前":@"售后"),(index == 1 ?obj.preTel : obj.afterTel)];
////        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:msg delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
////        alert.tag = index == 1 ? 0xfab : 0xfbc;
////        [alert show];
////    }
////}
//
//- (void)syncFinished:(PersonalListResponse *)response
//{
//    [_dataArray removeAllObjects];
//    [_dataArray addObjectsFromArray:response.data];
//    [_tableView reloadData];
//}
//
//- (void)syncFailure
//{
//    
//}

//- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
//{
//    if (buttonIndex == 1 &&( alertView.tag == 0xfab || alertView.tag == 0xfbc))
//    {
//        if (_selectPath.row < _dataArray.count)
//        {
//            OLProductModel *obj = _dataArray [_selectPath.row];
//            NSString *tell = [NSString stringWithFormat:@"tel:%@",(alertView.tag == 0xfab ?obj.preTel : obj.afterTel)];
//            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:tell]];
//        }
//    }
//    _selectPath = nil;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
