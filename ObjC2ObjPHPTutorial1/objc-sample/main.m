/* main.m - comp.lang.objective-c simple sample Objective-C program.  */

// This is a comment, just like the previous line.  Everything to the right
// of a double slash is ignored.

/* Classes are the one real extension which Objective-C adds to C.  A class
   is a description of a collection of data, like a C structure, and the
   methods by which that data may be accessed or manipulated.  Instances of
   a class are called objects, and methods are invoked by sending messages
   to either the class itself, to produce objects, or to those objects.  The
   recipient of a message is called a "receiver".  The form of a message is:

	[receiver method andMaybeSomeArguments]

   the receiver and method components are mandatory, as are the square
   brackets surrounding the message.  Additional arguments may or may not be
   present, depending upon the method definition.  Messages may appear
   anywhere a statement is allowed in C.

   The first thing we do is bring in some include files, as in C.  On the
   NeXT, it is customary to use the "import" statement which guarantees that
   the file isn't included more than once.  Using GNU CC this is not all
   that nice sinds it generates a huge warning for every file being
   compiled.  So, since it does not really matter, we'll stick to
   `#include'.  */

#import <stdio.h>
#import <objc/Object.h>
#import "Queue.h"
#import "Stack.h"

/* That brought in class definitions for Objects, Queues, and Stacks.  The
   Object class is the basis for all other classes, which is why it gets
   brought in first.  It provides basic functional behavior which is
   inherited by all derived classes.  All user created classes normally have
   Object somewhere in their ancestry.

   Queue and Stack are classes of our own construction, and provide FIFO and
   LIFO storage capabilities, respectively.  I'm not going to go into
   implementation details here.  It's irrelevant how they work, all that is
   important is that they both respond to 'put:' and 'get'.  If you want to
   inspect them, look into the Queue.m, Stack.m, Queue.h and Stack.h files.

   A simple Class definition follows.  It inherits directly from the base
   class "Object".  This gives it lots of nice properties, not the least of
   which is the ability to be referenced by any pointer of the generic
   object type "id".  All objects can be pointed to by any id variable, and
   the default return type from methods is id.  This allows messages to be
   embedded in other messages, either as receivers or arguments.

   An Int object allocates space for a single integer.  The "report" message
   causes it to report its value.  Everything between the @implementation
   and the @end is part of the class definition.

   Note - It is *highly* unusual to have a class implementation in your main
   program.  Since the object is fully defined before it gets used, no
   interface description is required.  There is nothing illegal about doing
   things this way, but it is so unusual that the compiler will produce a
   warning for this class.  The Int class implementation is here solely for
   expository purposes.  */

@implementation Int: Object	// Int is derived from Object
{
    int value;		// This is the data portion.  Like a struct.
}

/* The following are the method definitions.  A `+' prefix means it is a
   factory method, i.e., how to manufacture instances of the class.  The
   body of the method is between braces, like a C function.

   This class doesn't define any factory methods.  It relies on the +alloc
   method defined in class Object.  For examples of factory methods, look at
   the +new method defined in the Stack or Queue implementations.

   Self is a special variable, which refers to the object currently being
   manipulated.  Super refers to the parent class of self.  The following
   method asks the parent class (Object) to hand us a new instance, which
   becomes self.  Then we update the instance variables and return a pointer
   to the new object.

   It is standard for methods that do not need to return any special value
   to instead return self.  This allows for a nested syntax of method calls.

   The "-" in front of init means that it's an instance method, i.e.,
   something a particular object should respond to.  */

-init: (int) i
{
  /* We're overriding the `-init' of our superclass, but we add
     functionality instead of replacing it.  Therefore, first call the
     `-init' of our superclass.  */
  [super init];
  value = i;
  return self;
}

-report
{
  printf ("%4d", value);
  return self;
}

@end

/* We have implemented Float and Char classes more traditionally, using
   separate files for the interface (.h) and implementation (.m).  The Float
   and Char objects are like the Int object, but with the obvious difference
   that they work with floats and characters.  We include the interface
   definitions at this point.  */

#import "Float.h"
#import "Char.h"

/* If you inspect those files, note polymorphism -- methods have same
   names as in the Int class.  */

int main (void)
{
    /* First create instances of "Stack" and "Queue" data structures.  */
    id queue = [[Queue alloc] init];
    id stack = [[Stack alloc] init];
    int i, reply;

    fprintf (stderr, "Include the Char class in the demo? (y/n): ");

    /* Anything not matching `y.*' means no.  */
    reply = getchar ();

    for (i = 5; i > -6; --i)
      {
	/* Depending on which version of the demo we're running, we
	   alternately put Ints and Floats onto the queue and stack, or
	   Ints, Floats, and Chars.  */
	if (reply == 'y')
	  {
	    /* If I is odd we put an Int on the queue and a Char on the
	       stack.  If I is even we put an Char on the queue and a Float
	       on the stack.

	       Since there is more than one method `-init:' and since
	       `+alloc' returns a plain, typeless, `id', the compiler
	       doesn't know the type of the object returned by alloc.  An
	       explicit cast (i.e. static type indication) ensures that the
	       compiler knows which `init:' is invoked---the one accepting a
	       char or the other one accepting an int.

	       Another solution, which avoids the static type indication, is
	       to put typing information on the method in the method's name.
	       This is done for the Float class.  */
	    id my_char = [(Char *) [Char alloc] init: 'm' + i];

	    if (i & 1)
	      {
		[queue put: [(Int *) [Int alloc] init: i]];
		[stack put: my_char];
	      }
	    else
	      {
		[queue put: my_char];
		[stack put: [[Float alloc] initFloatValue: i]];
	      }
          }
	else
	  {
	    /* If I is odd we put an Int on the queue and a Float on the
	       stack.  If I is even we put a Float on the queue and an Int
	       on the stack.  */
            [queue put: ((i & 1)
			 ? [(Int *) [Int alloc] init: i]
			 : [[Float alloc] initFloatValue: i])];
            [stack put: ((i & 1)
			 ? [[Float alloc] initFloatValue: i]
			 : [(Int*) [Int alloc] init: i])];
	}
    }

    while ([queue size] && [stack size])
      {
	/* The following illustrates run-time binding.  Will report be
	   invoked for a Float object or an Int object?  Did the user elect
	   for Char objects at run time?  We don't know ahead of time, but
	   with run-time binding and polymorphism it works properly.  The
	   burden is on the class implementer rather than the class user.

	   Note that the following lines remain unchanged, whether we are
	   using the Char class or not.  The queue and stack hand us the
	   next object, it reports itself regardless of its type, and then
	   it frees itself.  */

	printf ("queue:");
	[[[queue get] report] free];
	printf (", stack:");
	[[[stack get] report] free];
	putchar('\n');
      }
  return 0;
}
