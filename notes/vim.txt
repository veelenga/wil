################################################################################
# Basics
################################################################################
wq, ZZ                              # Saves and exits
set wm=10                           # Wrapmargin
w, W(b, B)                          # Navigation on words
23G                                 # Go to line

(command)(number)(text obj)
        d2w
        y3w

s, S                                # Substitutes symbol or line
r, R                                # Replaces sysmbol or line
x, X                                # Deletes symbol before, after cursor

c, C                                # Replaces <object>, end of line
d, D                                # Deletes <object>, end of line
y, Y, yy                            # Yanks the line

~                                   # Inverts case
.                                   # Repeat last command

u, U                                # Undo, undo all changes on the cur line
C-R                                 # Redo

25i*
10aword                             # Multiple insert

################################################################################
# Scrolling
################################################################################
C-F                                 # Scroll hole page forward
C-B                                 # Back

C-D                                 # Scroll half of the page forward
C-U                                 # Back

C-E                                 # Scroll one line forward
C-Y                                 # Back

z<Enter>                            # Moves current line to the top
z.                                  # Center
z-                                  # Bottom

H                                   # Moves cursor to the top
M                                   # Middle
L                                   # Bottom

################################################################################
# Moving around the text
################################################################################
(                                   # move to the beginning of current sentence
)                                   # move to the beginning of next sentence
{                                   # move to the beginning of current paragraph
}                                   # move to the beginning of next paragraph
[[                                  # move to beginning of current section
]]                                  # move to beginnign of next section                                 

################################################################################
# Searching
################################################################################
/, ?
f, F
;, ,

dfx, cfx
dtx, ctx
ct.                                 # Change the hole sentence


################################################################################
# Navigation
################################################################################
5G
``                                  # Go back before 5G
''                                  # Go back before 5G to the begging of line

################################################################################
# Change  Delete  Copy            From cursor to...
################################################################################
    cH      dH      yH              # Top of screen
    cL      dL      yL              # Bottom of screen
    c+      d+      y+              # Next line
    c5|     d5|     y5|             # Column 5 of current line
    2c)     2d)     2y)             # Second sentence following
    c{      d{      y{              # Previous paragraph
    c/prn   d/prn   y/prn           # Pattern
    cn      dn      yn              # Next pattern
    cG      dG      yG              # End of file
    c13G    d13G    y13G            # Line number 13

################################################################################
# Opening files
################################################################################
vi +n files                         # Opens file and puts curson on line n
vi + file                           # Puts curson on last line
vi +/prn                            # Puts curson on pattern

################################################################################
# Buffering
################################################################################
"1p                                 # Restores from buffer #1
"1pu.u.u.u                          # Search through this buffer
"ayy
"aP
"Ayy                                # Append to buffer a

################################################################################
# Marks
################################################################################
mx    
`x
'x                                  # Went to begging of the line

################################################################################
# Global replacement
################################################################################
50, 100s:old:new:gc                 # g - global, c - confirm
%s:old:new:g                        # % - entire file
g:pattern:s:old:new:g               # Replaces in lines with /pattern/
%s:[a-zA-Z]\+.:sentence:g           # With regular expression
%s:\(That\) or \(this\):\2 or \1    # Uses buffers
%s:File:&, here:g                   # & - use matched text
1,10s:.*:(&):g                      # Surrounds with brackets
%s:his:their:g
%s:her:~:g                          # ~ - use same text from previous
s:\(That\) \(this\):\u\2 \l\1:g     # \u,\l - upper, lower case
s:\<child\>:children:g              # \<\> - matches a word

################################################################################
# Advanced editing
################################################################################
set autoindent
C-T                                # New level of indentation (in insert mode)
C-D                                # One level of indentation back
>>                                 # 8 spaces fight
<<                                 # 8 spaces left
set shiftwidth = 2
ctags
tag mytag                          # Finds a tag
^]                                 # Go to the tag under cursor

################################################################################
# Window control
################################################################################
C-Wh
C-Wl
C-Wj
C-Wk                               # Goes to window ...
C-Wt                               # Goes to top left window
C-Wb                               # Goes to right down window
C-Wp                               # Goes to previous (last accessed) window

C-Wr                               # Rotates two windows
C-Wx                               # Exchange windows
3C-Wx                              # Exchange current with 3rd one

C-WK                               # Moves curr window to the top 
C-WJ                               # Bottom
C-WH                               # Left
C-WL                               # Right
C-WT                               # Goes to next free tap

C-W=                               # Sets all windows to be equal
C-W-                               # Descreases window size
C-W+                               # Increases window size
C-W>                               # Descreases in vertical
C-W<                               # Increases in vertical
resize -10
vertical resize 5
C-W|                               # Resizes most widely

################################################################################
# Enhancement for programmers
################################################################################
zf                                 # Creates fold
zo                                 # Opens fold
zO                                 # Opens all folds
zc                                 # Closes fold
zd                                 # Deletes fold
zD                                 # Deletes all folds
set foldcolumn=6
set foldermethod=syntax            # Manual, indent, expr, syntax, diff, marker
set foldenabled

C-X,C-F                            # File completion
C-X,C-L                            # Line completion
C-N                                # Moves to next completion
C-P                                # Moves to previous completion

################################################################################
# Another cool stuff
################################################################################
set binary                         # Enables binary mode
:digraphs                          # Shows all digraphs
C-K23                              # ⅔
20, 44Tohtml                       # Converts to html file

vimdiff file1 file2
vim -dO file1 file2
[c                                 # Goes to previous difference
]c                                 # Next
do                                 # Gets changes from other window to curr
dp                                 # Puts changes from curr to other
:diffthis
:diffoff 

:mksession mysession.vim           # Saves a session
:source mysession.vim              # Loads a session
set sessionoptions=                # Adds some options to be saved in session
