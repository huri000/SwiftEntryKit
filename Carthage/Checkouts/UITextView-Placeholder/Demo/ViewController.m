// The MIT License (MIT)
//
// Copyright (c) 2014 Suyeol Jeon (http:xoul.kr)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

#import "ViewController.h"
#import <UITextView_Placeholder/UITextView+Placeholder.h>

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UITextView *textView = [[UITextView alloc] init];
    textView.frame = CGRectMake(50, 120, 200, 200);
    textView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    textView.placeholder = @"Are you sure you don\'t want to reconsider? Could you tell us why you wish to leave StyleShare? Your opinion helps us improve StyleShare into a better place for fashionistas from all around the world. We are always listening to our users. Help us improve!";
//    NSDictionary *attrs = @ {
//        NSFontAttributeName: [UIFont boldSystemFontOfSize:20],
//    };
//    textView.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Hi" attributes:attrs];
    textView.font = [UIFont systemFontOfSize:15];
    textView.layer.borderColor = UIColor.redColor.CGColor;
    textView.layer.borderWidth = 1.0;
    textView.textContainerInset = UIEdgeInsetsMake(20, 20, 20, 20);
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, 50, 50)];
    textView.textContainer.exclusionPaths = @[path];
    [self.view addSubview:textView];
}

@end
