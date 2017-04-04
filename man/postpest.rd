\name{postpest}
\alias{postpest}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Extract the optimized parameters from a PEST output file
}
\description{
PEST writes an outputfile containing the parameters that were optimized. These parameters are not sorted. postpest extracts them and writes them into a matrix that will be written into a file.
}
\usage{
postpest(NB,wd,PESTfile="standard",outputfile=NULL,
         PP = c("tab1","tvs1","tab2","tvs2","tab4","h1","h2","kbf","beta"))
}
%- maybe also 'usage' for other objects documented here.
\arguments{
\item{NB}{
 A numeric giving the number of the subbasin that was optimized
}
\item{wd}{
 A character string giving the working directory
}
\item{PESTfile}{
 A character string pointing towards the outputfile of PEST. See details
}
\item{outputfile}{
 A character string pointing towards the outputfile that will be written
}
\item{PP}{
 A character vector of the parameters that were optimized by PEST
}
}
\details{
If PESTfile == standard, the standard outputfile of PEST. Normally this does not need to be changed.
}
\value{
Only writes a file containing the parameters opimized by PEST. Nothing is returned to R.
}

\author{
Simon Frey
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
\link{prepest}
}
\examples{
####
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }% use one of  RShowDoc("KEYWORDS")
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
