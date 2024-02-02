# zkr

Zig katas based on exercises from K&R (fundamental C text):

  https://www.amazon.com/Programming-Language-2nd-Brian-Kernighan/dp/0131103628

Ideally, would love to finish a chapter a day. So far I'm surprised and running into more areas than I expected where basic C logic becomes significantly *more* complicated when implemented in Zig. Hoping that's just the familiarity.

The "structure" of the project retains the "current" working exercise in `src/main.zig`, with subfolders for caching the completed exercises from each chapter by their corresponding number. A basic `> zig build run` command should compile & execute the contents of `src/main.zig`.

## Core Lessons Learned

I'm keeping this section as a place where I can take notes on key differences and important concepts. Sometimes learning a language comes with significant ideas that you have to wrap your head around before you can feel comfortable with the concept of how a langauge "works" with familiarity.

* *Organize Allocation*: Because allocation must be directed explicitly, you will find yourself thinking ahead of time about ways to organize where memory is allocated, which in turn means doing some work to figure out how much memory will be needed. This makes subsequent coding much easier.

* *Manipulate Bytes, Not Types*: What is the underlying representation of your data? Spend some time figuring out how data is transformed by specific functions with respect to its underlying primitives.

* *Standardize Parameter Structures*: There appears to be some divergence in approach when passing around common parameters, like listing allocators first (or last), primitives followed by structs and arrays (or vice-versa), etc. My guess is, this will stabilize at some point.
