#import <objc/Object.h>

@interface Node : Object
{
  id next;
  id data;
}

-init: anItem;		// create a Node and store anItem in it
-free;			// free a Node and return the item in it
-next;			// report the id of the next node after this one
-setNext: aNode;	// make the next node be aNode

@end
