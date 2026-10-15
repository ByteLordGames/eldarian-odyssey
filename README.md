Eldarian Odyssey is a text adventure game that I started programming in TRS-80 Level II BASIC in 1978. As a novice programmer, I didn't make it very far. So, 40 years later, I decided to finish it. The title and the Green Dragon Inn are direct carryovers from the original as they are about all I could remember!

This game is dedicated to that youthful nerd who never realized people would actually start paying him to do what he loved.

This cross-platform open source project is programmed in PureBasic(tm), by Fantaisie Software. It's a bit of a cross between C and BASIC, coincidentally the two languages I am most proficient in. It was very important to write this game in some form of BASIC, since that's where it started way back in time.

Eldarian Odyssey is a classic late 1970's text adventure game. Your goal is to explore the environment, find clues, solve puzzles, and achieve the final objective.

The game can generally only recognize two word commands such as "LIGHT TORCH." Certain words will be ignored, however, so you have some leeway. As you play, you'll get a feel for what type of input is expected. For instance, sometimes a single verb will work if it's possible to figure out which object it uniquely applies to. You usually only have to type the first four letters of each word, but it's okay to type the whole word. 

Some commands are: SAVE, LOAD, INV or INVENTORY, GET/TAKE, DROP, EXAMINE, LOOK, QUIT, EXIT, GO/MOVE <direction: N,S,E,W>. There are several other actions you can take, and most can be combined with the name of an object. If you try a command and it doesn't work, try again with different words. You can even try to strike up a conversation!

Windows builds are validated with the PureBasic 6.41 x64 and x86 ASM compilers (`pbcompiler.exe`). From the repository directory, run `powershell -NoProfile -File .\Validate.ps1` to check the source, build release/debug executables, and run the parser/state regression suite on both architectures. The script accepts `-Compiler` and `-CompilerX86` for other installation paths; it skips x86 validation when the x86 compiler is absent. Use the ASM backend because the grayscale module contains inline assembly. The script embeds Windows 1.06 version resources in all four executables. Generated executables stay in `Binaries` and are ignored by Git; the four published x64 and x86 ZIP archives are tracked there.

The x86 release and debug builds compile and pass the same automated regression suite as x64. The x86 graphical application has not yet had a manual playthrough, and non-Windows builds remain unvalidated. See [the September 2026 review and manual regression guide](REVIEW-AND-WALKTHROUGH-2026-09.md) for results, remaining limitations, and a complete test walkthrough. **That guide and the regression test source contain major game spoilers.**

## License

Eldarian Odyssey is licensed under the [BSD 3-Clause License](LICENSE.md) (`BSD-3-Clause`). Modified source and binary redistributions are permitted, including commercial redistribution, provided they preserve the required ByteLord copyright and license notices. The license also prohibits using ByteLord or contributor names to endorse derived products without prior written permission.
