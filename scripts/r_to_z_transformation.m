function p1 = r_to_z_transformation(r1,r2,sample_size)
% r-to-z transformation to determine significance between correlations
%%% Fisher r to z transformation %%%
%r1 = first correlation coefficient
%r2 = second correlation coefficient
x1 = sample_size;
z2 = atanh(r2);
z1 = atanh(r1);
n = numel(x1);
z = (z2 - z1)./sqrt((1./(n-3))+(1./(n-3)));
%p-value
p1 = (1-normcdf(abs(z),0,1))*2;

error2 = 1/(sqrt(numel(x1))-3);
error1 = 1/(sqrt(numel(x1))-3);

%%% confidence interval test %%%
alpha = 0.05;
ci_l = z - 1.96*error1;
ci_u = z + 1.96*error1;

r_l = tanh(ci_l);
r_u = tanh(ci_u);

end