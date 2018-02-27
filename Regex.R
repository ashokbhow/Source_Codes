txt <- c("arm","foot","lefroo", "bafoobarfoo")
grep("foo", txt)
grepl("foo", txt)

# Substitution
sub(pattern = 'foo', replacement = 'oof' , txt, ignore.case = T)

# Global Substitution
gsub(pattern = 'foo', replacement = 'oof', txt, ignore.case = FALSE)

# The . wild card
# SELECT Only the string ending with a .
txt <- c('cat.', '896.', '896.', 'abc1')
grep(pattern = '.', txt)
grep(pattern = '\\.', txt)

# Square brackets and matching specific characters
# Select only first three
txt <- c('can', 'man', 'fan', 'dan', 'ran', 'pan')
grep(pattern = '[cmf]an', txt)

# Excluding characters
grep(pattern = '[^drp]an', txt)

# Characeter ranges -
# Select ones starting with capital letter
txt <- c('Ana', 'Bob', 'Cpc', 'aax', 'bby', 'ccz')
grepl(pattern = '[A-Z].', txt)
grepl(pattern = '[^a-z].', txt)

# matching digits
txt <- c('123', '323', '332', 'dan', 'ran', 'pan')
grepl(pattern = '\\d', txt)

# matching digits
txt <- c('123', '323', '332', 'd2n', 'r22', 'p222')
grepl(pattern = '\\d{1}', txt)

txt <- c("abc", "def", "cba a", "aa")
grepl("a+", txt, perl=TRUE)
regexpr("a+", txt, perl=TRUE)

# The use of fixed argument
txt <- "log(M)"
gsub("log", "", txt) 
gsub("log(", "", txt)
gsub("log(", "", txt, fixed = T)

#https://www.w3schools.com/jsref/jsref_obj_regexp.asp
