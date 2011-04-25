//
//  EditingTableViewCell.m
//  KDClient
//
//  Created by Tair Sabirgaliev on 12.03.11.
//  Copyright 2011 BEE Software. All rights reserved.
//

#import "EditingCell.h"
#import "DetailViewController.h"
#import "RootViewController.h"
#import "NSObject+BeeExtensions.h"

@interface EditingCell (asdf) <UITextFieldDelegate>
@end

@implementation EditingCell

@synthesize textField = _textField;

@synthesize detailViewController = _detailViewController;

@synthesize managedObject = _managedObject;

@synthesize field=_field;

- (void)useField:(NSString *)field ofManagedObject:(NSManagedObject *)managedObject {
    if (_managedObject) {
        [_managedObject removeObserver:self forKeyPath:self.field];
        [_textField removeObserver:self forKeyPath:@"text"];
    }
    
    [_managedObject release];
    [_field release];
    
    _field = [field copy];
    _managedObject = [managedObject retain];

    self.textField.text = [_managedObject valueForKey:field];
    
    [_managedObject addObserver:self forKeyPath:field options:0 context:nil];
    [_textField addObserver:self forKeyPath:@"text" options:0 context:nil];
    [self setNeedsDisplay];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([self.textField.text isEqualToString:[self.managedObject valueForKey:self.field]]) {
        NSLog(@"ignore");
        return;
    }

    if (object == self.textField) {
        NSLog(@"textField");
        [self.managedObject setValue:self.textField.text forKey:self.field];
    } else if (object == _managedObject) {
        NSLog(@"managedObject");
        self.textField.text = [self.managedObject valueForKey:self.field];
    }
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier])) {
        _textField = [[UITextField alloc] initWithFrame: CGRectZero];
        _textField.borderStyle = UITextBorderStyleNone;
        _textField.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _textField.userInteractionEnabled = NO;
        _textField.textAlignment = UITextAlignmentRight;
        _textField.textColor = self.detailTextLabel.textColor;
        _textField.delegate = self;

        [self.contentView addSubview:_textField];
        [self setNeedsLayout];
    }
    return self;
}

- (void)layoutSubviews {
	[super layoutSubviews];
	CGRect labelFrame = self.textLabel.frame;
	labelFrame = CGRectMake(10, 11, labelFrame.size.width, labelFrame.size.height);
	self.textLabel.frame = labelFrame;
	self.textField.frame = CGRectMake(labelFrame.size.width + 20, 13, self.contentView.frame.size.width - labelFrame.size.width - 31, 21);
	[self.detailTextLabel removeFromSuperview];
}

- (void)dealloc {
    [_managedObject removeObserver:self forKeyPath:_field];
    [_textField removeObserver:self forKeyPath:@"text"];
    [_textField release];
    [_field release];
    [_managedObject release];
    [super dealloc];
}

- (UIView*)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if ([self.textField isFirstResponder] && [self pointInside:point withEvent:event]) {
        return self.textField;
    } else {
        return [super hitTest:point withEvent:event];
    }
}

-(BOOL) isActive
{
    return [self.textField isFirstResponder];
}

-(void) setActive:(BOOL)active
{
    if (active && ![self isActive]) {
        self.textField.userInteractionEnabled = YES;
        NSLog(@"enable");
        if (![self.textField becomeFirstResponder]) {
            self.textField.userInteractionEnabled = NO;
        }
    } 
    
    if (!active && [self isActive]) {
        if ([self.textField endEditing:NO]) {
        }
    }
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    NSLog(@"disable");
    self.textField.userInteractionEnabled = NO;
}

@end
