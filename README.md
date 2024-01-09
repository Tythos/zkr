# zkr

Zig katas based on exercises from K&R (fundamental C text):

  https://www.amazon.com/Programming-Language-2nd-Brian-Kernighan/dp/0131103628

Ideally, would love to finish a chapter a day. So far I'm surprised and running into more areas than I expected where basic C logic becomes significantly *more* complicated when implemented in Zig. Hoping that's just the familiarity.

The "structure" of the project retains the "current" working exercise in `src/main.zig`, with subfolders for caching the completed exercises from each chapter by their corresponding number. A basic `> zig build run` command should compile & execute the contents of `src/main.zig`.
