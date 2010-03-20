#import <stdio.h>
#import "Char.h"

@implementation Char
{
  int value;
}

- init: (int) x
{
  [super init];		// In case the parent class is doing
  			// something special in its init...
  value = x;
  return self;
}

- report
{
  printf("   %c", value);
  return self;
}

@end
