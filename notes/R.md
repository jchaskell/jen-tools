# R language
## Data.table
`.SD` holds all of the columns except the ones specified in “by” (can specify
what it includes)
* Apply a function to cols: `dt[, lapply(.SD, mean)]`

`dt[is_admission == T, candidate_visit_id := NA]` updates dt so that if
is_admission == T, then candidate_visit_id is assigned NA
`:=` updates assignment

Using variables with data.table with lazy eval
* for i statement, use get()
* for LHS of := , wrap in parens ()
* for RHS of := or general reference, use get() or eval(parse(text=))
* when a char string representing a vector, use eval(parse(text=))
* for by statement, use c() or eval()

`tstrsplit` transposes and `strsplit` so it string splits columns and makes
them into new ones

## Apply functions
apply - works over 1 dimension of an array (1 for rows, 2 for cols); output
format varies; 
apply(x, 2, sum)

lapply - applies a function to every element of a list
-extract first row from a list of matrices: lapply(MyList, “[“, 1)
-extract first element from a list of matrices: lapply(MyList, “[“ 1, 2)
-need to return(x) if you want to change values

sapply - works like lapply but simplifies output to most elementary data
structure (eg vector instead of list
mapply - (fn, arg1, arg2) applies to more than 1 object; mapply(rep, 1:4, 4)])])

If you need to access names(MyList) in an lapply function, run lapply on
names(MyList) and use MyList(x) to access values

## Grep
`grep(pattern, x)` - returns a vector w/ indices of values that match; set value
= T to return character vector with matches
`grepl(pattern, x)` returns T or F
`sub(pattern, replacement, x)` only replaces first instance
`gsub()` replaces all instances

## SparkR
data[[varname]] or column(varname)

## GGplot
use aes_string instead of aes to use variable names

## Misc
`break` stops loop entirely
`next` skips to next iteration

`commandArgs()` read args from the command line 

`list.dirs(path = , full.names = T, recursive = F)`
`file.exists(path)`
`list.files()` lists files in a directory - lots of parameters

`readChar()` to read file as a string
`yaml::yaml.load(string)`

`ifelse()` can’t return Null because expects a vector; instead use
if(condition) non-null

`on.exit(command)`    will run command on any kind of function exit including
error; examples include delete object, setwd(), etc
`quit(status = )`        can set exit code
`options(scipen=999)`    turns off scientific notation
`exists(“varname”)`    test if variable exists

`cut(x, breaks, labels)``    x = vector you want to group ie. grades (98, 65, 83);
breaks = vector defining groups ie (90, 80, 70, 60); labels to be applied to
the groups like (“A”, “B”, “C”, “D”)
