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

#import "Array_Speed_TestViewController.h"

#include <mach/mach.h>
#include <mach/mach_time.h>



@implementation Array_Speed_TestViewController


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	NSLog(@"viewDidLoad");
	
    [super viewDidLoad];
	
	cArray		= NULL;
	nsArray		= NULL;
	
	// read initial slider value setup accordingly
	[self sliderChanged:sliderCount];
	
	// get mach timer unit size and calculater millisecond factor
	mach_timebase_info_data_t info;
	mach_timebase_info(&info);
	machTimerMillisMult = (double)info.numer / ((double)info.denom * 1000000.0);
	NSLog(@"machTimerMillisMult = %f", machTimerMillisMult);
}


// pass in results of mach_absolute_time()
// this converts to milliseconds and outputs to the label
-(void)displayResult:(uint64_t)duration {
	double millis = duration * machTimerMillisMult;
	
	NSLog(@"displayResult: %f milliseconds", millis);
	
	NSString *str = [[NSString alloc] initWithFormat:@"%f milliseconds", millis];
	[labelResults setText:str];
	[str release];
}



// process using NSArray and iterating with normal for loops
-(IBAction) doNSArrayForLoop:(id)sender {
	NSLog(@"doNSArray: %@", sender);

	uint64_t startTime = mach_absolute_time();
	for(int i=0; i<numberOfItems; i++) {
		[[nsArray objectAtIndex:i] doSomething];
	}
	[self displayResult:mach_absolute_time() - startTime];
}

// process using NSArray and using makeObjectsPerformSelector to send messages to all objects
-(IBAction) doNSArrayPerformSelector:(id)sender {
	NSLog(@"doNSArray: %@", sender);
	
	uint64_t startTime = mach_absolute_time();
	[nsArray makeObjectsPerformSelector:@selector(doSomething)];
	[self displayResult:mach_absolute_time() - startTime];
}

// process using C Array
-(IBAction) doCArray:(id)sender {
	NSLog(@"doCArray: %@", sender);
	
	uint64_t start = mach_absolute_time();
	for(int i=0; i<numberOfItems; i++) {
		cArray[i].doSomething();
	}
	[self displayResult:mach_absolute_time() - start];
}


// allocate NSArray and C Array 
-(void) allocateArrays {
	NSLog(@"allocateArrays");
	
	// allocate c array
	if(cArray) delete cArray;
	cArray = new MyCppObject[numberOfItems];
	
	// allocate NSArray
	[nsArray release];
	nsArray = [[NSMutableArray alloc] initWithCapacity:numberOfItems];
	

	// fill with random values
	for(int i=0; i<numberOfItems; i++) {
		// add number to c array
		cArray[i].f = random() * 1.0f/(RAND_MAX+1);
		
		
		// add number to NSArray
		MyNSObject *myObj = [[MyNSObject alloc] init];
		myObj.f = cArray[i].f;
		
		[nsArray addObject:myObj];
		[myObj release];
	}
	
}


// callback for when slider is changed
-(IBAction) sliderChanged:(id)sender {
	numberOfItems = sliderCount.value;
	NSLog(@"sliderChanged: %@, %i", sender, numberOfItems);
	
	NSString *str = [[NSString alloc] initWithFormat:@"%i items", numberOfItems];
	[labelCount setText:str];
	[str release];
	
	[self allocateArrays];
}


//cleanup
- (void)dealloc {
	[nsArray release];
	if(cArray) delete cArray;
	
    [super dealloc];
}

@end
