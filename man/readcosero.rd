\name{readcosero}
\alias{readcosero}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Read a COSERO output file into an xts object
}
\description{
Read a COSERO output file (qobs_qsim.txt) into an xts object
}
\usage{
readcosero(file)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{file}{
 A character string pointing to the file to be read in
}
}
\details{
Read an output file from COSERO (qobs_qsim) and store it into an \link{xts} object
}
\value{
An xts object
}
\references{
\emph{Kling, H., Stanzel, P., Fuchs, M., and Nachtnebel, H.-P. (2014): Performance of the COSERO precipitation-runoff model under nonstationary conditions in basins with different climates, Hydrolog. Sci. J., 60, 1374–1393, doi:10.1080/02626667.2014.959956.}
}
\author{
Simon Frey
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
\link{read.table}
\link{xts}
}
\examples{
### load sample output data
readcosero(paste(path.package("PestR"),"/extdata/qobs_qsim.txt",sep=""))
}
