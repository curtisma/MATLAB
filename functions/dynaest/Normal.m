%NORMAL  generate Gaussian random vector with certain mean and covariance    
function x=normal(mean,cov)
if any(any(cov-zeros(size(cov))))==0, x=mean; return, end
OK=Ishermit(cov);
if OK~=1, cov, error('Covariance matrix (cov) is not Hermitian.'), end
%OK=ispsd(cov);
%if OK~=1, error('Covariance matrix (cov) is not positive semidefinite.'), end
   y=randn(size(mean));
x = mean + cov^(1/2)*y;
return

