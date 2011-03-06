/***********************************************************************
 
 Please see 
 http://www.memo.tv/nsarray_vs_c_array_performance_comparison
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

@interface Array_Speed_TestViewController : UIViewController {
	int						numberOfItems;			// number of items in array
	float					*cArray;				// normal c array
	NSMutableArray			*nsArray;				// ns array
	double					machTimerMillisMult;	// multiplier to convert mach_absolute_time() to milliseconds
	

	IBOutlet	UISlider	*sliderCount;
	IBOutlet	UILabel		*labelCount;

	IBOutlet	UILabel		*labelResults;
}

-(IBAction) doNSArray:(id)sender;
-(IBAction) doCArray:(id)sender;

-(IBAction) sliderChanged:(id)sender;

@end

