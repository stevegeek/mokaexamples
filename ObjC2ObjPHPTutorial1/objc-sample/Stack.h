#import <objc/Object.h>
#import "Node.h"

@interface Stack: Object
{
  id stack;
  unsigned int stack_size;
}

-empty;				// clear out all contents of the Stack
-put: anItem;			// put anItem on the Stack
-get;				// return the item on top of the Stack
-(unsigned) size;		// tell us the current size of the Stack

@end
