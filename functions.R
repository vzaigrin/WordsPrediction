require("R.utils")
require("stringr")
require("data.table")

load("data/model.RData")
setkey(unigram,index)

w2i <- function ( word )  {
    return( unigram[token==word,]$index)
}

i2w <- function( ind )  {
    return( unigram[index==ind,]$token )
}

p3 <- function ( word1, word2, n=3 )  {
    return(unigram[index==trigram[t1==w2i(word1)&t2==w2i(word2),t3][1:n],token])
}

p2 <- function ( word1, n=3 )  {
    return(unigram[index==bigram[t1==w2i(word1),t2][1:n],token])
}

p1 <- function (n=3)  {
    return(unigram[order(unigram$p,decreasing=TRUE),token][1:n])
}

string2tokens <- function ( text )  {
    text<-tolower(text)
    text<-gsub("[[:digit:]]"," ",text)
    text<-gsub("[[:punct:]]"," ",text)
    text<-gsub("[^[a-z]]"," ",text)
    tokens<-unlist(sapply(1:length(text), function(x) str_extract_all(text[x],"([a-z]+)")))
    tokens<-gsub("(.)\\1{2,}","\\1",tokens)
    profanity <- c("arse", "ass", "asshole", "bastard", "bitch", "bloody", "bollocks", "childfucker", "cunt", "damn", "fuck", "goddamn", "godsdamn", "hell", "motherfucker", "shit", "shitass", "whore")
    tokens<-tokens[!(tokens %in% profanity)]
    return(tokens)
}

pstring <- function( string, n=3 )  {
    tokens<-string2tokens(string)
    tokens<-tokens[tokens %in% unigram$token]
    return(predict(tokens,n))
}

predict <- function ( tokens, n=3 )  {
    tl<-length(tokens)
    if ( tl > 1 )  {
        res<-p3(tokens[tl-1],tokens[tl],n)
        if ( is.na(res[1]) )  res<-predict(tokens[1:tl-1],n)
        return(res)
    }
    if ( tl > 0 )  {
        res<-p2(tokens[tl],n)
        if ( is.na(res[1]) )  res<-p1(n)
        return(res)
    }    
    return(p1(n))
}
