\name{prepest}
\alias{prepest}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Create a PEST control file
}
\description{
Create a PEST control file as well as several batch files necessary to run COSERO in PEST mode (see details).
}
\usage{
prepest(NB, upriverNB=NA, wd = getwd(),
        updateparasofar=FALSE,transferfile=NULL,
        placeholders = NULL,
        tempchek, pestgen, file_in, file_out,
        file_objfunc = "kge_nse.txt",
        lb = 0.3, ub = 3.0)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
 \item{NB}{
 A numeric giving the number of the subbasin that will be optimized
}
\item{upriverNB}{
 A numeric or a numerical vector (see Details)
}
\item{wd}{
 A character string giving the working directory
}
\item{updatesofar}{
 Logical. Automatically update the baseparameters from a previous PEST run (not in use)
}
\item{transferfile}{
 A string pointing towards a transfermatrix
}
\item{placeholders}{
 A string pointing towards a file containing the PEST-wise names of the parameters to be optimized (see details)
}
\item{tempchek}{
 A string pointing towards the executable tempchek.exe (see details)
}
\item{pestgen}{
 A string pointing towards a the executable pestgen.exe (see details)
}
\item{file_in}{
 A string pointing towards a file containing the factors for \link{factoval}
}
\item{file_out}{
 A string pointing towards the outputfile for \link{factoval}
}
\item{file_objfunc}{
 A string pointing towards the outputfile for \link{kge_nse}
}
\item{lb}{
 A numeric giving the lower bound of the parameter range
}
\item{ub}{
 A numeric giving the upper bound of the parameter range
}


}
\details{
This function relies on the presence of PEST (Doherty 2016) being installed on the computer running windows. PEST can be downloaded from \url{http://www.pesthomepage.org/Downloads.php}. More precisely it relies on the two executables “tempchek.exe” and “pestgen.exe”. See Doherty 2016 for more details about the use of these executables.
pretest reads a table “placeholders” containing the PEST-wise parameter names of the parameters that can be altered (note that this file can hold parameter names of the whole catchment, not only of the subbasin that will be optimized by PEST).  It reads in a transfer table, too. That table contains the base parameters of the total catchment (see \link{factoval}).  pretest automatically selects the subbasin (NB) and the subbasins upstream (upriverNB) and only the respective parameters to PEST. \cr
It then creates a PEST control file named “cosero_subbasinNB.pst”, where NB represents the number of the subbasin that will be optimized. \cr
Further, it will create a batchfile that will call COSERO and let the model read in the table with altered parameter values into a new parameter file. Then it calls COSERO again and perform a model run with the new parameter set.
pretest also creates a second batchfile for post processing. This second batchfile will call R and do some post processing like calculating the Kling-Gupta-Model efficiency via calling \link{kge_nse}.

The filenames may be given in relative or absolute paths. If relative, they are extended into absolute paths using the path given by wd. An exception is file_objfunc. That is extended by "output\\" because it normally is written to the output directory of COSERO.
}
\value{
Nothing is returned to R.
}
\references{
\emph{Doherty, J., 2015. Calibration and Uncertainty Analysis for Complex Environmental Models. Watermark Numerical Computing, Brisbane, Australia. ISBN: 978-0-9943786-0-6.}

\emph{Doherty, J., 2016, PEST, Model-independent parameter estimation—User manual (6th ed.): Brisbane, Australia, Watermark Numerical Computing. }

\url{http://www.pesthomepage.org/Home.php}

}
\author{
Simon Frey
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
\link{kge_nse}
\link{factoval}
\link{postpest}
}
\examples{
####
}
