
#include <RcppArmadillo.h>
//using namespace Rcpp;
using namespace arma;

// [[Rcpp::depends(RcppArmadillo)]]

// You can source this function into an R session using the Rcpp::sourceCpp
// function (or via the Source button on the editor toolbar). Learn
// more about Rcpp at:
//
//   http://www.rcpp.org/
//   http://adv-r.had.co.nz/Rcpp.html
//   http://gallery.rcpp.org/
//

// [[Rcpp::export]]
arma::mat TT_GS_sp(arma::uword n, arma::mat R, double nu, arma::vec x, arma::vec lower, arma::vec upper) {
  arma::mat Rinv=R.i();
//  vec x=(lower+upper)/2;
  uword p=R.n_cols;
  double nup=nu+p;
  mat X(n,p,fill::zeros);
  umat minusj(p-1,p,fill::zeros);
  for(uword j=0;j<p;j++){
    uword k=0;
    for(uword l=0;l<p;l++){
      if(l!=j){
        minusj(k,j)=l;
        k++;
      }
    }
  }

  for(uword i=0;i<n;i++){
    double delta=as_scalar(x.t()*Rinv*x);
    double y=arma::randu<double>()*exp(-nup*log(1+delta/nu)/2);
    double kap = nu * (pow(y,-2/nup) - 1);
    for(uword j=0;j<p;j++){
      uvec pj=minusj.col(j);
      vec xj=x(pj);
      rowvec a1=xj.t()*Rinv.rows(pj);
      double ss=as_scalar(a1.cols(pj)*xj);
      double mj=-a1(j)/Rinv(j,j);
      double tj=sqrt(mj*mj+(kap-ss)/Rinv(j,j));
      double lv=(lower(j)<mj-tj)?(mj-tj):(lower(j));
      double rv=(upper(j)<mj+tj)?(upper(j)):(mj+tj);
      double xij=lv+(rv-lv)*arma::randu<double>();
      X(i,j)=xij;
      x(j)=xij;
    }
  }

  return X;
}
