/***********************************************************************
 
 Please see 
 http://www.memo.tv/nsarray_vs_c_array_performance_comparison_part_ii_makeobjectsperformselector
 for context
 
 Copyright (c) 2008, Memo Akten, www.memo.tv
 
 This program is free software: you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation, either version 3 of the License, or
 (at your option) any later version.
 
 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.
 
 You should have received a copy of the GNU General Public License
 along with this program.  If not, see <http://www.gnu.org/licenses/>.
 
 ***********************************************************************/
#import <UIKit/UIKit.h>

@class Array_Speed_TestViewController;

@interface Array_Speed_TestAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    Array_Speed_TestViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet Array_Speed_TestViewController *viewController;

@end

