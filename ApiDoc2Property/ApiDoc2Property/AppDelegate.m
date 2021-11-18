//
//  AppDelegate.m
//  ApiDoc2Property
//
//  Created by zyc on 2021/5/17.
//

#import "AppDelegate.h"
#import "InputViewController.h"

@interface AppDelegate ()<NSWindowDelegate>

@property (strong) IBOutlet NSWindow *window;

@property (strong,nonatomic) IBOutlet InputViewController *inputVC;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {


    self.inputVC = [[InputViewController alloc] initWithNibName:@"InputViewController" bundle:[NSBundle mainBundle]];
    self.window.delegate = self;
    [self.window.contentView addSubview:self.inputVC.view];
    self.inputVC.view.frame = self.window.contentView.frame;
    
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

-(NSSize)windowWillResize:(NSWindow *)sender toSize:(NSSize)frameSize
{

    self.inputVC.view.frame = CGRectMake(sender.contentView.frame.origin.x, sender.contentView.frame.origin.y, frameSize.width, frameSize.height);
    return frameSize;
}

@end
