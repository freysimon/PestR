\name{kge_nse}
\alias{kge_nse}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Calculate both KGE and NSE of a time series.
}
\description{
Calculate both Kling-Gutpa model efficiency (\link{KGE}), and Nash-Sutcliffe model efficiency (\link{NSE}) from an extended time series (\link{xts}) and return the negative value
}
\usage{
kge_nse(x, simcol=2,
        OUT = "kge_nse.txt",
        from = NULL, to = NULL)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{
 An xts object
}
\item{simcol}{
 A numeric
}
\item{OUT}{
 A character specifiing the output file or NULL to supress the file
}
\item{from, to}{
 characters giving the start and enddate of the window that is to be evaluated (see details)
}
}
\details{
If from and to are given (not NULL), a window of the time series will be evaluated. If one of both is NULL the time series will be cut and evaluated. See \link{xts} for more details.
If OUT is given, the negative values of KGE and NSE are written whithout column- and rownames.
}
\value{
A data.frame containing the KGE and NSE value.
}
\references{
\emph{Nash, J. E. and J. V. Sutcliffe (1970), River flow forecasting through conceptual models part I -A discussion of principles, Journal of Hydrology, 10 (3), 282-290}

\emph{Gupta, Hoshin V., Harald Kling, Koray K. Yilmaz, Guillermo F. Martinez. Decomposition of the mean squared error and NSE performance criteria: Implications for improving hydrological modelling. Journal of Hydrology, Volume 377, Issues 1-2, 20 October 2009, Pages 80-91. DOI: 10.1016/j.jhydrol.2009.08.003.}
}
\author{
Simon Frey
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
\link{KGE}
\link{NSE}
\link{readcosero}
}
\examples{
### load sample output data from cosero
data(qobsqsim)

kge_nse(qobsqsim,
  simcol= 6, # select subbasin nr 3
  OUT = NULL, # suppress writing of an output file
  from = "2008-09-01",
  to = "2013-08-30")
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }% use one of  RShowDoc("KEYWORDS")
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
