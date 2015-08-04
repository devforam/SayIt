//
//  FBLabel.m
//  Tetéu
//
//  Created by DevRepublic on 25/06/14.
//  Copyright (c) 2014 DevRepublic. All rights reserved.
//

#import "FBLabel.h"

@implementation BoldLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setFonts];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setFonts];
    }
    return self;
}

-(id)init
{
    self = [super init];
    if (self) {
        [self setFonts];
    }
    return self;
}

-(void)setFonts
{
    [self setFont:[UIFont fontWithName:@"OpenSans-Light" size:self.font.pointSize]];
}

@end

@implementation RegularLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setFonts];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setFonts];
    }
    return self;
}

-(id)init
{
    self = [super init];
    if (self) {
        [self setFonts];
    }
    return self;
}

-(void)setFonts
{
   [self setFont:[UIFont fontWithName:@"OpenSans-Light" size:self.font.pointSize]];
}

@end

@implementation RegularLight

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setFonts];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setFonts];
    }
    return self;
}

-(id)init
{
    self = [super init];
    if (self) {
        [self setFonts];
    }
    return self;
}

-(void)setFonts
{
    [self setFont:[UIFont fontWithName:@"OpenSans-Light" size:self.font.pointSize]];
}

@end

@implementation RegularSemiBold

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setFonts];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setFonts];
    }
    return self;
}

-(id)init
{
    self = [super init];
    if (self) {
        [self setFonts];
    }
    return self;
}

-(void)setFonts
{
  [self setFont:[UIFont fontWithName:@"OpenSans-Light" size:self.font.pointSize]];
}

@end


@implementation ItalicLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setFonts];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setFonts];
    }
    return self;
}

-(id)init
{
    self = [super init];
    if (self) {
        [self setFonts];
    }
    return self;
}

-(void)setFonts
{
    [self setFont:[UIFont fontWithName:@"OpenSans-Light" size:self.font.pointSize]];
}

@end

@implementation RegularSemiLight

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setFonts];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setFonts];
    }
    return self;
}

-(id)init
{
    self = [super init];
    if (self) {
        [self setFonts];
    }
    return self;
}

-(void)setFonts
{
    [self setFont:[UIFont fontWithName:@"OpenSans-Light" size:self.font.pointSize]];
}

@end

@implementation ItalicSemiBoldLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setFonts];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setFonts];
    }
    return self;
}

-(id)init
{
    self = [super init];
    if (self) {
        [self setFonts];
    }
    return self;
}

-(void)setFonts
{
    [self setFont:[UIFont fontWithName:@"OpenSans-Light" size:self.font.pointSize]];
}

@end


@implementation RegularButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setFonts];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setFonts];
    }
    return self;
}

-(id)init
{
    self = [super init];
    if (self) {
        [self setFonts];
    }
    return self;
}

-(void)setFonts
{
  [self.titleLabel setFont:[UIFont fontWithName:@"OpenSans-Light" size:self.titleLabel.font.pointSize]];
}

@end

@implementation BoldButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setFonts];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setFonts];
    }
    return self;
}

-(id)init
{
    self = [super init];
    if (self) {
        [self setFonts];
    }
    return self;
}

-(void)setFonts
{
  [self.titleLabel setFont:[UIFont fontWithName:@"OpenSans-Light" size:self.titleLabel.font.pointSize]];
}
@end

//Semi Bold Button
@implementation SemiBoldButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setFonts];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setFonts];
    }
    return self;
}

-(id)init
{
    self = [super init];
    if (self) {
        [self setFonts];
    }
    return self;
}

-(void)setFonts
{
    [self.titleLabel setFont:[UIFont fontWithName:@"OpenSans-Light" size:self.titleLabel.font.pointSize]];
}
@end


@implementation RegularTextView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setFonts];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setFonts];
    }
    return self;
}

-(id)init
{
    self = [super init];
    if (self) {
        [self setFonts];
    }
    return self;
}

-(void)setFonts
{
    [self setFont:[UIFont fontWithName:@"OpenSans-Light" size:self.font.pointSize]];
}


@end

@implementation RegularTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setFonts];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setFonts];
    }
    return self;
}

-(id)init
{
    self = [super init];
    if (self) {
        [self setFonts];
    }
    return self;
}

-(void)setFonts
{
    [self setFont:[UIFont fontWithName:@"OpenSans-Light" size:self.font.pointSize]];
}
@end

@implementation BoldTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setFonts];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setFonts];
    }
    return self;
}

-(id)init
{
    self = [super init];
    if (self) {
        [self setFonts];
    }
    return self;
}

-(void)setFonts
{
 [self setFont:[UIFont fontWithName:@"OpenSans-Light" size:self.font.pointSize]];
}
@end

@implementation SemiBoldTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setFonts];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setFonts];
    }
    return self;
}

-(id)init
{
    self = [super init];
    if (self) {
        [self setFonts];
    }
    return self;
}

-(void)setFonts
{
 [self setFont:[UIFont fontWithName:@"OpenSans-Light" size:self.font.pointSize]];
}
@end


@implementation SemiBoldTextFieldLight

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setFonts];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setFonts];
    }
    return self;
}

-(id)init
{
    self = [super init];
    if (self) {
        [self setFonts];
    }
    return self;
}

-(void)setFonts
{
    [self setFont:[UIFont fontWithName:@"OpenSans-Light" size:self.font.pointSize]];
}
@end
