//
//  AddtagToolView.m
//  百思不得姐
//
//  Created by user on 16/9/14.
//  Copyright © 2016年 ZJQ. All rights reserved.
//

#import "AddtagToolView.h"

#import "AddTagViewController.h"
@interface AddtagToolView()

@property (weak, nonatomic) IBOutlet UIView *tagView;
/** 存放所以标签数组*/
@property(nonatomic,strong)NSMutableArray *labelArr;
/** 添加按钮*/
@property(nonatomic,strong)UIButton *addButton;

@end
@implementation AddtagToolView

-(NSMutableArray *)labelArr
{
    if (!_labelArr) {
        _labelArr=[NSMutableArray array];
    }
    return _labelArr;
}
+(instancetype)GetView
{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]firstObject];
}
- (void)awakeFromNib
{
    // 添加一个加号按钮
    UIButton *addButton = [[UIButton alloc] init];
    [addButton addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [addButton setImage:[UIImage imageNamed:@"tag_add_icon"] forState:UIControlStateNormal];
    //    addButton.size = [UIImage imageNamed:@"tag_add_icon"].size;
    //    addButton.size = [addButton imageForState:UIControlStateNormal].size;
    addButton.size = addButton.currentImage.size;
    addButton.x = TopicCellMargin;
    [self.tagView addSubview:addButton];
    self.addButton=addButton;
    
    // 默认就拥有2个标签
    [self setupTagsLabel:@[@"吐槽", @"糗事"]];
    
    [super awakeFromNib]; 
}

- (void)addButtonClick
{
    __weak typeof (self) weakSelf=self;
   AddTagViewController *vc = [[AddTagViewController alloc] init];
    
    vc.tagsArr=[self.labelArr valueForKeyPath:@"text"];
   
    [vc setTagsBlock:^(NSArray *tagsArr) {
        [weakSelf setupTagsLabel:tagsArr];
    }];
    UIViewController *root = [UIApplication sharedApplication].keyWindow.rootViewController;
    UINavigationController *nav = (UINavigationController *)root.presentedViewController;
    [nav pushViewController:vc animated:YES];
}
-(void)setupTagsLabel:(NSArray*)tagsArr
{
    [self.labelArr makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.labelArr removeAllObjects];
    
    for (int i=0; i<tagsArr.count; i++) {
        UILabel *tagLabel = [[UILabel alloc] init];
        [self.labelArr addObject:tagLabel];
        tagLabel.backgroundColor = RGBColor(74, 139, 209);
        tagLabel.textAlignment = NSTextAlignmentCenter;
        tagLabel.text = tagsArr[i];
        tagLabel.font = [UIFont systemFontOfSize:15];
        // 应该要先设置文字和字体后，再进行计算
        [tagLabel sizeToFit];
        tagLabel.width += 2 * TextMargin;
        tagLabel.height = 25;
        tagLabel.textColor = [UIColor whiteColor];
        [self.tagView addSubview:tagLabel];
        
    }
    [self setNeedsLayout];

    
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    for (int i=0; i<self.labelArr.count; i++) {
        UILabel *tagLabel = self.labelArr[i];
        
        // 设置位置
        if (i == 0) { // 最前面的标签
            tagLabel.x = 0;
            tagLabel.y = 0;
        } else { // 其他标签
            UILabel *lastTagLabel = self.labelArr[i - 1];
            // 计算当前行左边的宽度
            CGFloat leftWidth = CGRectGetMaxX(lastTagLabel.frame) + TextMargin;
            // 计算当前行右边的宽度
            CGFloat rightWidth = self.tagView.width - leftWidth;
            if (rightWidth >= tagLabel.width) { // 按钮显示在当前行
                tagLabel.y = lastTagLabel.y;
                tagLabel.x = leftWidth;
            } else { // 按钮显示在下一行
                tagLabel.x = 0;
                tagLabel.y = CGRectGetMaxY(lastTagLabel.frame) + TextMargin;
            }
        }
    }
    
    // 最后一个标签
    UILabel *lastTagLabel = [self.labelArr lastObject];
    CGFloat leftWidth = CGRectGetMaxX(lastTagLabel.frame) + TextMargin;
    
    // 更新textField的frame
    if (self.tagView.width - leftWidth >= self.addButton.width) {
        self.addButton.y = lastTagLabel.y;
        self.addButton.x = leftWidth;
    } else {
        self.addButton.x = 0;
        self.addButton.y = CGRectGetMaxY(lastTagLabel.frame) + TextMargin;
    }
    
    UILabel *label=[self.labelArr lastObject];
    CGFloat ViewY=CGRectGetMaxY(label.frame);
    CGFloat OlHeight=self.height;
    self.height=ViewY+TextMargin+35;
    
    self.y-=self.height-OlHeight;

}

@end
