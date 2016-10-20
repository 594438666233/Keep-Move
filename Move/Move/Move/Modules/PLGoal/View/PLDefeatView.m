//
//  PLDefeatView.m
//  
//
//  Created by PhelanGeek on 2016/10/20.
//
//

#import "PLDefeatView.h"
#import "PLDefeatModel.h"

@interface PLDefeatView ()

@property (weak, nonatomic) IBOutlet UILabel *defeatPeoplePercentageLabel;
@property (weak, nonatomic) IBOutlet UILabel *activeAgeLabel;

@end

@implementation PLDefeatView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].lastObject;
    }
    return self;
}

- (void)setPlDefeatModel:(PLDefeatModel *)plDefeatModel {
    _defeatPeoplePercentageLabel.text = plDefeatModel.defeatPeoplePercentage;
    _activeAgeLabel.text = plDefeatModel.activeAge;
}

@end
