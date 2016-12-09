\name{TT_GS_sp}
\alias{TT_GS_sp}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
%%  ~~function to do ... ~~
A special case of function TT.GS with mu is a zero vector and S is a corelation matrix
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
This function is used in \code{\link{TT.GS}}. This function uses Rcpp/RcppArmadillo packages for computational effects.
}
\usage{
TT_GS_sp(n, R, nu, x, lower, upper)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
\item{n}{Number of observations.}
\item{R}{Scale matrix, default is diag(length(x)).}
\item{nu}{Degree of freedom, nu>2 is required to confirm the existence of the first two moments of TMVT distribution under slice sampling.}
\item{x}{Initial vector}
\item{lower, upper}{Truncation bounds on the random vectors, default is rep(-Inf, length(x)), rep(Inf, length(x)).}
}

%\details{
%%  ~~ If necessary, more details than the description above ~~
%}
\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
An n by p matrix
}
\references{
%% ~put references to the literature/web site here ~
Hsiu J. Ho, Tsung-I Lin, Hsuan-Yu Chen, Wan-Lun Wang (2012), Some results on the truncated multivariate t distribution.
Journal of Statistical Planning and Inference, 142, 25-40.
}
\author{
%%  ~~who you are~~
Hsiu J. Ho, Tsung-I Lin, Wan-Lun Wang, Aldo M. Garay, Victor H. Lachos, and Mauricio Castro
}
%\note{
%%  ~~further notes~~
%}

%% ~Make other sections like Warning with \section{Warning }{....} ~

%\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
%}
\examples{
# A test example
rho=0.9
S=matrix(c(1, rho ,rho, 1),2,2)
nu=5
p=2
mu = rep(0, p)
Y= TT.GS(n=10000, mu, S, nu, lower=c(1,2), upper=c(4,6))
# Empirical first moment
y.bar=colMeans(Y)
y.bar
# Sample covariance matrix
S.y=cov(Y)
S.y

M.Y=TT.moment(R=S, nu, lower=c(1,2), upper=c(4,6))
# First two moments
M.Y$EX
M.Y$EXX
# Covariance matrix
M.Y$EXX-M.Y$EX\%*\%t(M.Y$EX)
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{Multivariate t distribution}
\keyword{Truncation}% __ONLY ONE__ keyword per line
