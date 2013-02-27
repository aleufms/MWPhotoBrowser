//
//  MWCaptionView.m
//  MWPhotoBrowser
//
//  Created by Michael Waterfall on 30/12/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MWCaptionView.h"
#import "MWPhoto.h"

static const CGFloat labelPadding = 10;

// Private
@interface MWCaptionView () {
    id<MWPhoto> _photo;
    UILabel *_label;    
}
@end

@implementation MWCaptionView

- (id)initWithPhoto:(id<MWPhoto>)photo {
    self = [super initWithFrame:CGRectMake(0, 0, 320, 44)]; // Random initial frame
    if (self) {
        _photo = [photo retain];
        self.opaque = NO;
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin;
        [self setupCaption];
    }
    return self;
}

- (CGSize)sizeThatFits:(CGSize)size {
    CGFloat maxHeight = 9999;
    if (_label.numberOfLines > 0) maxHeight = _label.font.leading*_label.numberOfLines;
    CGSize textSize = [_label.text sizeWithFont:_label.font 
                              constrainedToSize:CGSizeMake(size.width - labelPadding*2, maxHeight)
                                  lineBreakMode:_label.lineBreakMode];
    if (textSize.height < 44)
        textSize.height = 44;
    return CGSizeMake(size.width, textSize.height/* + labelPadding*2*/);
}

- (void)setupCaption {
    _label = [[UILabel alloc] initWithFrame:CGRectMake(labelPadding, 0,
                                                       self.bounds.size.width-labelPadding*2,
                                                       44)];
//    _label.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    _label.opaque = NO;
    _label.backgroundColor = [UIColor clearColor];
    _label.textAlignment = UITextAlignmentCenter;
    _label.lineBreakMode = UILineBreakModeWordWrap;
    _label.numberOfLines = 0;
    _label.textColor = [UIColor whiteColor];
    _label.shadowColor = [UIColor blackColor];
    _label.shadowOffset = CGSizeMake(1, 1);
    _label.font = [UIFont systemFontOfSize:17];
    if ([_photo respondsToSelector:@selector(caption)]) {
        _label.text = [_photo caption] ? [_photo caption] : @" ";
    }
    
    _labelScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    [_labelScrollView setBounces:YES];
    [_labelScrollView addSubview:_label];
    
    [self addSubview:_labelScrollView];
}

- (void)dealloc {
    [_label release];
    [_photo release];
    [super dealloc];
}

@end
