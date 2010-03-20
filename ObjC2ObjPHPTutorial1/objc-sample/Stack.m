#import "Stack.h"

@implementation	Stack

-empty
{
  while([self size])
    [[self get] free];
  return self;
}

-put: anItem
{
  stack = [[[Node alloc] init: anItem] setNext : stack];
  ++stack_size;
  return self;
}

-get
{
  id contents;
  id old_stack = stack;

  stack = [stack next];
  contents = [old_stack free];
  --stack_size;
  return contents;
}

-(unsigned) size
{
  return stack_size;
}

@end
