//
//  TestView.m
//  驾考宝典(王达仿制版)
//
//  Created by wangda on 15/6/17.
//  Copyright (c) 2015年 wang. All rights reserved.
//

#import "TestView.h"
@interface TestView ()
@property (strong,nonatomic) UIView *backView;
@property (strong,nonatomic) UIImageView *titleImageView;
@property (assign,nonatomic) float backViewHeight;
@property (strong,nonatomic) UILabel *subjectLabel;
@property (strong,nonatomic) UIImageView *subjectImageView;
@property (strong,nonatomic) NSDictionary *viewDictionary;
@property (strong,nonatomic) UIView *alternativeView;


@property (strong,nonatomic) UIView *explainView;
@property (strong,nonatomic) UILabel *label1;
@property (strong,nonatomic) UILabel *label2;
@property (strong,nonatomic) UILabel *label3;
@property (strong,nonatomic) UILabel *label4;

@property (assign,nonatomic) float labelHeight;
@property (assign,nonatomic) float viewHeight;


@end
@implementation TestView

-(instancetype) init{
    
    self = [super init];
    self.backView = [[UIView alloc]init];
    self.titleImageView = [[UIImageView alloc]init];
    self.subjectLabel = [UILabel new];
    self.subjectImageView = [[UIImageView alloc]init];
    self.alternativeView = [UIView new];
    self.r = 0.1;
    self.g = 0.9;
    self.b = 0.8;
    
    self.explainView = [UIView new];
    self.label1 = [UILabel new];
    self.label2 = [UILabel new];
    self.label3 = [UILabel new];
    self.label4 = [UILabel new];
    
        //选项的初始化
    self.buttonA = [UIButton new];
    self.buttonB = [UIButton new];
    self.buttonC = [UIButton new];
    self.buttonD = [UIButton new];
    
    
    self.AContent = [UILabel new];
    self.BContent = [UILabel new];
    self.CContent = [UILabel new];
    self.DContent = [UILabel new];
    
    [self addSubview:self.backView];
    [self.backView addSubview:self.titleImageView];
    [self.backView addSubview:self.subjectLabel];
    [self.backView addSubview:self.subjectImageView];
    
        //加入选项
    [self addSubview:self.buttonA];
    [self addSubview:self.buttonB];
    [self addSubview:self.buttonC];
    [self addSubview:self.buttonD];
    
    [self addSubview:self.AContent];
    [self addSubview:self.BContent];
    [self addSubview:self.CContent];
    [self addSubview:self.DContent];
    
        //解释界面的加入
    [self addSubview:self.explainView];
    [self.explainView addSubview:self.label1];
    [self.explainView addSubview:self.label2];
    [self.explainView addSubview:self.label3];
    [self.explainView addSubview:self.label4];
    
    self.viewDictionary = @{@"backView":self.backView,@"titleImageView":self.titleImageView,@"subjectLabel":self.subjectLabel,@"subjectImageView":self.subjectImageView,@"buttonA":self.buttonA,@"AContent":self.AContent,@"buttonB":self.buttonB,@"BContent":self.BContent,@"buttonC":self.buttonC,@"CContent":self.CContent,@"buttonD":self.buttonD,@"DContent":self.DContent,@"explainView":self.explainView,@"label1":self.label1,@"label2":self.label2,@"label3":self.label3,@"label4":self.label4};
    return self;
}


-(void)createMultipleChoiceQuestionWithSubjectContent:(NSString *)subjectContent subjectImage:(NSString *)subjectImage alternatives:(NSArray *)alternatives answer:(NSString *)answer explain:(NSString *)explain
{
    CGRect a = [[UIScreen mainScreen]bounds];
    [self setBackViewAttributes:self.backView];
    [self setTitleImageViewAttributes:self.titleImageView];
    [self setSubjectLabel:self.subjectLabel withSubjectContent:subjectContent];
    
    if (subjectImage != nil) {
        [self setSubjectImageView:self.subjectImageView withSubjectImage:[UIImage imageNamed:subjectImage]];
    }
        //[self setAlternativeViewAttributes:self.alternativeView];
    [self setButtonAAttributes:self.buttonA];
    [self setButtonBAttributes:self.buttonB];
    [self setButtonCAttributes:self.buttonC];
    [self setButtonDAttributes:self.buttonD];
    
    
    
    [self setAContentAttributes:self.AContent withAlternativeA:alternatives[0]];
    [self setBContentAttributes:self.BContent withAlternativeB:alternatives[1]];
    [self setCContentAttributes:self.CContent withAlternativeC:alternatives[2]];
    [self setDContentAttributes:self.DContent withAlternativeD:alternatives[3]];
    [self setExplainViewAttributes:self.explainView];
    [self setLabel1Attributes:self.label1];
    [self setLabel2Attributes:self.label2 withAnswer:answer];
    [self setLabel3Attributes:self.label3];
    [self setLabel4Attributes:self.label4 withExplain:explain];
    
    [self addConstraintToTitleImageView];
    [self addConstrainToLabel];
    [self addConstraintTOBackView];
    [self addContraintToSubjectImageView];
    [self addConstraintToButtons];
    
    if (!([alternatives[2] isEqualToString: @"nil"])) {
        [self addConstraintToButtons1];
    }
        //计算视图的高度
    float backaViewHeight = self.backView.frame.size.height;
    float explainViewHeight = self.explainView.frame.size.height;
    self.viewHeight = backaViewHeight + explainViewHeight + 178;
    [self setFrame:CGRectMake(a.origin.x, a.origin.y, a.size.width, self.viewHeight)];
}




#pragma mark -- 初始化视图
    //初始化背景视图
-(void)setBackViewAttributes:(UIView *)backView
{
    UIColor *color = [[UIColor alloc]initWithRed:self.r green:self.g blue:self.b alpha:1];
    
    backView.backgroundColor = color;
    backView.layer.cornerRadius = 4;
    
}

    //初始化标题视图
-(void)setTitleImageViewAttributes:(UIImageView *)titleImageView
{
    titleImageView.backgroundColor = [UIColor clearColor];
    titleImageView.image = [UIImage imageNamed:@"选择题"];
    
}

    //初始化题干label
-(void)setSubjectLabel:(UILabel *)subjectLabel withSubjectContent:(NSString *)subjectContent
{
    subjectLabel.backgroundColor = [UIColor clearColor];
    subjectLabel.font = [UIFont fontWithName:@"Arial" size:20];
    subjectLabel.textAlignment = NSTextAlignmentLeft;
    subjectLabel.lineBreakMode = NSLineBreakByCharWrapping;
    subjectLabel.numberOfLines = 0;
    subjectLabel.text = subjectContent;
}

    //初始化题目的图片
-(void)setSubjectImageView:(UIImageView *)subjectImageView withSubjectImage:(UIImage *)subjectImage
{
    subjectImageView.image = subjectImage;
    self.backViewHeight = self.backViewHeight + self.subjectImageView.image.size.height + 20;
}

    //初始化选项视图
-(void)setAlternativeViewAttributes:(UIView *)alternativeView
{
    alternativeView.backgroundColor = [UIColor whiteColor];
    
}

    //初始化四个选项按钮
-(void)setButtonAAttributes:(UIButton *)buttonA
{
    buttonA.backgroundColor = [UIColor clearColor];
    [buttonA setBackgroundImage:[UIImage imageNamed:@"A"] forState:UIControlStateNormal];
    buttonA.layer.cornerRadius = 12.5;
}

-(void)setAContentAttributes:(UILabel *)AContent withAlternativeA:(NSString *)alternativeA
{
    AContent.text = alternativeA;
    AContent.font = [UIFont fontWithName:@"Arial" size:18];
    AContent.backgroundColor = [UIColor clearColor];
    AContent.layer.cornerRadius = 4;
    AContent.textAlignment = NSTextAlignmentLeft;
    AContent.lineBreakMode = NSLineBreakByCharWrapping;
    AContent.numberOfLines = 0;
}

-(void)setButtonBAttributes:(UIButton *)buttonB
{
    buttonB.backgroundColor = [UIColor clearColor];
    [buttonB setBackgroundImage:[UIImage imageNamed:@"B"] forState:UIControlStateNormal];
    buttonB.layer.cornerRadius = 12.5;
}

-(void)setBContentAttributes:(UILabel *)BContent withAlternativeB:(NSString *)alternativeB
{
    BContent.text = alternativeB;
    BContent.font = [UIFont fontWithName:@"Arial" size:18];
    BContent.backgroundColor = [UIColor clearColor];
    BContent.layer.cornerRadius = 4;
    BContent.textAlignment = NSTextAlignmentLeft;
    BContent.lineBreakMode = NSLineBreakByCharWrapping;
    BContent.numberOfLines = 0;
}

-(void)setButtonCAttributes:(UIButton *)buttonC
{
    buttonC.backgroundColor = [UIColor clearColor];
    [buttonC setBackgroundImage:[UIImage imageNamed:@"C"] forState:UIControlStateNormal];
    buttonC.layer.cornerRadius = 12.5;
}

-(void)setCContentAttributes:(UILabel *)CContent withAlternativeC:(NSString *)alternativeC
{
    CContent.text = alternativeC;
    CContent.font = [UIFont fontWithName:@"Arial" size:18];
    CContent.backgroundColor = [UIColor clearColor];
    CContent.layer.cornerRadius = 4;
    CContent.textAlignment = NSTextAlignmentLeft;
    CContent.lineBreakMode = NSLineBreakByCharWrapping;
    CContent.numberOfLines = 0;
}

-(void)setButtonDAttributes:(UIButton *)buttonD
{
    buttonD.backgroundColor = [UIColor clearColor];
    [buttonD setBackgroundImage:[UIImage imageNamed:@"D"] forState:UIControlStateNormal];
    buttonD.layer.cornerRadius = 12.5;
}



-(void)setDContentAttributes:(UILabel *)DContent withAlternativeD:(NSString *)alternativeD
{
    DContent.text = alternativeD;
    DContent.font = [UIFont fontWithName:@"Arial" size:18];
    DContent.backgroundColor = [UIColor clearColor];
    DContent.layer.cornerRadius = 4;
    DContent.textAlignment = NSTextAlignmentLeft;
    DContent.lineBreakMode = NSLineBreakByCharWrapping;
    DContent.numberOfLines = 0;
}

    //注释界面的设置
-(void)setExplainViewAttributes:(UIView *)explainView
{
    explainView.backgroundColor = [UIColor lightGrayColor];
    explainView.layer.cornerRadius = 4;
}

-(void)setLabel1Attributes:(UILabel *)label1
{
    label1.text = @"答案:";
    
}
-(void)setLabel2Attributes:(UILabel *)label2 withAnswer:(NSString *)answer
{
    label2.text = answer;
}
-(void)setLabel3Attributes:(UILabel *)label3
{
    label3.text = @"解释:";
}
-(void)setLabel4Attributes:(UILabel *)label4 withExplain:(NSString *)explain
{
    label4.text = explain;
    
    label4.backgroundColor = [UIColor clearColor];
    label4.font = [UIFont fontWithName:@"Arial" size:18];
    label4.textAlignment = NSTextAlignmentLeft;
    label4.lineBreakMode = NSLineBreakByCharWrapping;
    label4.numberOfLines = 0;
}
    //
-(void)addConstraintToTitleImageView
{
    [self.titleImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[titleImageView(titleWidth)]" options:0 metrics:@{@"titleWidth":@(TITLE_WIDTH)} views:self.viewDictionary]];
    
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-viewToTop-[titleImageView(distance)]" options:0 metrics:@{@"distance":@(TITLE_HEIGHT),@"viewToTop":@(TITLE_TO_VIEW)} views:self.viewDictionary]];
    [self.titleImageView layoutIfNeeded];
    self.backViewHeight = self.backViewHeight + self.titleImageView.frame.size.height;
}

-(void)addConstrainToLabel
{
    
    [self.subjectLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-5-[subjectLabel]-5-|" options:0 metrics:nil views:self.viewDictionary]];
    
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[titleImageView]-[subjectLabel]" options:0 metrics:nil views:self.viewDictionary]];
    [self.subjectLabel layoutIfNeeded];
    self.backViewHeight = self.backViewHeight + [self getTextHeight:self.subjectLabel];
    
}

    //增加背景视图的约束
-(void)addConstraintTOBackView
{
        // self.labelHeight = [self getTextHeight:self.subjectLabel];
    float viewHeight = TITLE_TO_VIEW + self.backViewHeight + VIEW_BUTTON;
    [self.backView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[backView]-20-|" options:0 metrics:nil views:self.viewDictionary]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[backView(distance)]" options:0 metrics:@{@"distance":@(viewHeight)} views:self.viewDictionary]];
    [self.backView layoutIfNeeded];
}

    //增加图片的约束
-(void)addContraintToSubjectImageView
{
    [self.subjectImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    NSLayoutConstraint * centerX = [NSLayoutConstraint constraintWithItem:self.subjectImageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.backView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[subjectLabel]-[subjectImageView(height)]" options:0 metrics:@{@"height":@(self.subjectImageView.image.size.height)} views:self.viewDictionary]];
    
    NSArray * constraintArray = @[centerX];
    
    [self addConstraints:constraintArray];
    
    [self.subjectImageView layoutIfNeeded];
}

    //增加选项视图的约束
-(void)addContraintToAlterAlternativeView
{
    [self.alternativeView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[alternativeView]-20-|" options:0 metrics:nil views:self.viewDictionary]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[backView]-0-[alternativeView(distance)]" options:0 metrics:@{@"distance":@(210)} views:self.viewDictionary]];
    [self.alternativeView layoutIfNeeded];
    
}

    //增加选项的约束
-(void)addConstraintToButtons
{
    [self.buttonA setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.buttonB setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.AContent setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.BContent setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    
    float heightA = [self getTextHeight:self.AContent];
    float heightB = [self getTextHeight:self.BContent];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[buttonA(25)]" options:0 metrics:nil views:self.viewDictionary]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[backView]-10-[buttonA(25)]" options:0 metrics:nil views:self.viewDictionary]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[buttonB(25)]" options:0 metrics:nil views:self.viewDictionary]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[AContent]-10-[buttonB(25)]" options:0 metrics:nil views:self.viewDictionary]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[buttonA]-[AContent]-20-|" options:0 metrics:nil views:self.viewDictionary]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[backView]-10-[AContent(heightA)]" options:0 metrics:@{@"heightA":@(heightA)} views:self.viewDictionary]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[buttonB]-[BContent]-20-|" options:0 metrics:nil views:self.viewDictionary]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[AContent]-10-[BContent(heightB)]" options:0 metrics:@{@"heightB":@(heightB)} views:self.viewDictionary]];
    
    [self.buttonA layoutIfNeeded];
    [self.buttonB layoutIfNeeded];
    
    [self.AContent layoutIfNeeded];
    [self.BContent layoutIfNeeded];
    
}

    //增加选项的约束
-(void)addConstraintToButtons1
{
    [self.buttonC setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.buttonD setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.CContent setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.DContent setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    float heightC = [self getTextHeight:self.CContent];
    float heightD = [self getTextHeight:self.DContent];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[buttonC(25)]" options:0 metrics:nil views:self.viewDictionary]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[BContent]-10-[buttonC(25)]" options:0 metrics:nil views:self.viewDictionary]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[buttonD(25)]" options:0 metrics:nil views:self.viewDictionary]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[CContent]-10-[buttonD(25)]" options:0 metrics:nil views:self.viewDictionary]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[buttonC]-[CContent]-20-|" options:0 metrics:nil views:self.viewDictionary]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[BContent]-10-[CContent(heightC)]" options:0 metrics:@{@"heightC":@(heightC)} views:self.viewDictionary]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[buttonD]-[DContent]-20-|" options:0 metrics:nil views:self.viewDictionary]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[CContent]-10-[DContent(heightD)]" options:0 metrics:@{@"heightD":@(heightD)} views:self.viewDictionary]];
    
    [self.buttonC layoutIfNeeded];
    [self.buttonD layoutIfNeeded];
    [self.CContent layoutIfNeeded];
    [self.DContent layoutIfNeeded];
    
}



    //对注释视图的约束
-(void)addconstraintToExplianView
{
    if (self.DContent.frame.size.height > 0) {
        float explainHeight = 80 + [self getTextHeight:self.label4];
        [self.explainView setTranslatesAutoresizingMaskIntoConstraints:NO];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[explainView]-20-|" options:0 metrics:nil views:self.viewDictionary]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[DContent]-[explainView(distance)]" options:0 metrics:@{@"distance":@(explainHeight)} views:self.viewDictionary]];
        [self.explainView layoutIfNeeded];
    }else{
        float explainHeight = 80 + [self getTextHeight:self.label4];
        [self.explainView setTranslatesAutoresizingMaskIntoConstraints:NO];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[explainView]-20-|" options:0 metrics:nil views:self.viewDictionary]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[BContent]-[explainView(distance)]" options:0 metrics:@{@"distance":@(explainHeight)} views:self.viewDictionary]];
        [self.explainView layoutIfNeeded];
    }
    
}

    //对注释界面中的label1添加约束
-(void)addConstraintToLabel1
{
    [self.label1 setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[label1(40)]" options:0 metrics:nil views:self.viewDictionary]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[label1(distance)]" options:0 metrics:@{@"distance":@(20)} views:self.viewDictionary]];
    [self.label1 layoutIfNeeded];
}

    //对注释界面中的label2添加约束
-(void)addConstraintToLabel2
{
    [self.label2 setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[label1]-[label2(20)]" options:0 metrics:nil views:self.viewDictionary]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[label2(distance)]" options:0 metrics:@{@"distance":@(20)} views:self.viewDictionary]];
    [self.label1 layoutIfNeeded];
    
    [self.label2 layoutIfNeeded];
}

    //对注释界面中的label3添加约束
-(void)addConstraintToLabel3
{
    [self.label3 setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-10-[label3(40)]" options:0 metrics:nil views:self.viewDictionary]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[label1]-10-[label3(distance)]" options:0 metrics:@{@"distance":@(20)} views:self.viewDictionary]];
    [self.label3 layoutIfNeeded];
}

    //对注释界面中的label4添加约束
-(void)addConstraintToLabel4
{
    float labelHeight = [self getTextHeight:self.label4];
    
    [self.label4 setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-10-[label4]-10-|" options:0 metrics:nil views:self.viewDictionary]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[label3]-10-[label4(distance)]" options:0 metrics:@{@"distance":@(labelHeight)} views:self.viewDictionary]];
    [self.label4 layoutIfNeeded];
}

    //计算label的高度
- (double)getTextHeight:(UILabel *)lbText
{
    NSDictionary *attribute = @{NSFontAttributeName: lbText.font};
    CGSize size = CGSizeMake(SCREENSIZE.size.width-60.0f, 0);
    CGSize retSize = [lbText.text boundingRectWithSize:size
                                               options:\
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                            attributes:attribute
                                               context:nil].size;
    return retSize.height;
}

    //设置约束字典
-(void)setViewDictionary1:(NSDictionary *)viewDictionary
{
    viewDictionary = @{@"backView":self.backView,@"titleImageView":self.titleImageView,@"subjectLabel":self.subjectLabel,@"subjectImageView":self.subjectImageView};
}

-(void)showExplain
{
    
    [self addconstraintToExplianView];
    [self addConstraintToLabel1];
    [self addConstraintToLabel2];
    [self addConstraintToLabel3];
    [self addConstraintToLabel4];
    CGRect a = [[UIScreen mainScreen]bounds];
    float backaViewHeight = self.backView.frame.size.height;
    float explainViewHeight = self.explainView.frame.size.height;
    
    self.viewHeight = backaViewHeight + explainViewHeight + 178;
    
    [self setFrame:CGRectMake(a.origin.x, a.origin.y, a.size.width, self.viewHeight)];
}@end
