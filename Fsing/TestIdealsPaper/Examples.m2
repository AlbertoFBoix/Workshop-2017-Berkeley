restart; 
loadPackage "TestIdeals"

R=ZZ/5[x,y,z]
I=ideal(x^6*y*z+x^2*y^12*z^3+x*y*z^18)
frobeniusPower(1/5,I)

frobeniusPower(1/2, ideal(y^2-x^3))
frobeniusPower(5/6, ideal(y^2-x^3))

restart; 
loadPackage "TestIdeals";


R=ZZ/5[x,y,z]

g=x^3+y^3+z^3
u=g^(5-1)

frobeniusPower(1/5,ideal(u))


R=ZZ/7[x,y,z]

g=x^3+y^3+z^3
u=g^(7-1)

frobeniusPower(1/7,ideal(u))

restart; 
loadPackage "TestIdeals"

R = ZZ/3[u,v];

u = u^2*v^2;

compatibleIdeals(u)



restart;

pp=2;
m=5;
R=ZZ/pp[x_1..x_m]; 
E=matrix {{x_1,x_2,x_2,x_5},{x_4,x_4,x_3,x_1}};
I=minors(2,E);
I=gens I;
u=x_1^3*x_2*x_3 + x_1^3*x_2*x_4+x_1^2*x_3*x_4*x_5+ x_1*x_2*x_3*x_4*x_5+ x_1*x_2*x_4^2*x_5+ x_2^2*x_4^2*x_5+x_3*x_4^2*x_5^2+ x_4^3*x_5^2;


