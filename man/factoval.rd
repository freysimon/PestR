\name{factoval}
\alias{factoval}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Convert factors into parameters for COSERO
}
\description{
The PEST optimization routine of PestR is using factors to adjust the parameters of COSERO instead of adjusting the parameters itself. This has the advantage that all adjustable factors are in the same order of magnitude. factoval calculates the parameters from the factors that were adjusted by PEST.
Factors in this sense must not be confused with factors in the R sense as in \link{default.stringsAsFactors} for instance.
Needs a Transfermatrix and a matix containing the factors. Writes a matrix containing the parameters that can be read by COSERO.
}
\usage{
factoval(file_in,file_out,transferfile,NB,upriverNB=NB)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{file_in}{
 A string pointing towards a file containing the fators
}
\item{file_out}{
 A string pointing towards the outputfile
}
\item{transferfile}{
 A string pointing towards a transfermatrix
}
\item{NB}{
 A numeric giving the number of the subbasin that will be optimized
}
\item{upriverNB}{
A numeric or a numerical vator (see Details)
}
}
\details{
The transfermatrix must be a matrix with as many columns as parameters that are optimized by PEST. The length (nrow) of the matrix must be the same as there are cells in the complete catchment (NZ). The values are the base which the factors are multiplied with.
upriverNB gives the number of (ungauged) subbasins upriver from the subbasin which is optimized. The parameters of the upriverNB subbasins are adjusted, too.
}
\value{
Only writes a file containing the parameters for COSERO. Nothing is returned to R.
}

\author{
Simon Frey
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
\link{readcosero}
}
\examples{
factoval(file_in = paste(path.package("PestR"),"/extdata/sample/PEST_Para.txt",sep=""),
         file_out = "PEST4COSERO.txt",
         transferfile = paste(path.package("PestR"),"/extdata/sample/Baseparameters.txt",sep=""),
         NB = 40,
         upriverNB = c(38,39))

}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }% use one of  RShowDoc("KEYWORDS")
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
