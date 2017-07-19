--*************************************************
--*************************************************
--*************************************************
--*************************************************
--This file is used for doing basic computations 
--i.e. things using only lists, numbers, etc.
-- that support other functions in the Fsing
--package.  
--*************************************************
--*************************************************
--*************************************************
--*************************************************

--*************************************************
--Basic Manipulations with Numbers 
--*************************************************
--===================================================================================

denominator( ZZ ) := x -> 1;
numerator( ZZ ) := x -> x;

--===================================================================================

--Finds the fractional part of a number.
fracPart = x -> x - floor(x)

--===================================================================================

--*************************************************
--Information Regarding Factors and Factorization
--*************************************************

--===================================================================================

nontrivialPowerSet = L -> delete( {}, subsets L )

--===================================================================================

--Returns a list of factors of a number with repeats.
numberToPrimeFactorList = n ->
(
     prod := factor n;
     flatten apply( toList prod, x -> toList( x#1:x#0 ) )
)

--===================================================================================

--Returns a list of all proper -- not one -- factors of number.
--Has funny order...
getFactorList = n ->
(
     if (n < 1) then error "getFactorList: expected an integer greater than 1.";
     powSet := nontrivialPowerSet( numberToPrimeFactorList( n ) ); 
     toList set apply( powSet, x -> product( x ) )
)

--===================================================================================

--*************************************************
--Finding Numbers in Given Range
--*************************************************

--===================================================================================

findNumberBetween = method(); 

--This function finds rational numbers in the range of 
--the interval; the max denominator allowed is listed. 
findNumberBetween( ZZ, ZZ, ZZ) := ( maxDenom, firstN, secondN)->
(
     divisionChecks :=  new MutableList from maxDenom:true; 
         -- creates a list with maxDenom elements all set to true.
     outList := {};
     i := maxDenom;
     while (i > 0) do (
	  if ((divisionChecks#(i-1)) == true) then --if we need to do a computation..
	      outList = join(outList,findNumberBetweenWithDenom(i, firstN, secondN ));
	  factorList := getFactorList(i);
     	  apply(factorList, j-> (divisionChecks#(j-1) = false) );
	  i = i - 1;
     );
     sort(toList set outList)
)

--for backwards compatibility
--findNumberBetween( ZZ, List ) := ( maxDenom, myInterv )-> findNumberBetween( maxDenom, myInterv#0, myInterv#1);

--===================================================================================

--*************************************************
--Manipulations with Vectors   
--*************************************************

--===================================================================================

--Given a vector w of rational integers in [0,1], returns a number of digits such that
--it suffices to check to see if the components of w add without carrying in base p
carryTest = ( p, w ) ->
(
    if any( w, x -> x < 0 or x > 1 ) then 
        error "carryTest: Expected the second argument to be a list of rational numbers in [0,1]";
     div := apply( w, x -> divideFraction(p, x) );
     c := max (transpose div)#1; --max of second components of div
     v := selectNonzero (transpose div)#2; -- nonzero third components of div
     d := if v === {} then 1 else lcm v;
     c+d+1
)

--===================================================================================

--Given a vector w of rational integers in [0,1], returns the first spot 
--e where the the sum of the entries in w carry in base p
firstCarry = ( p, w ) ->
(   
    if any( w, x -> x < 0 or x > 1 ) then 
        error "firstCarry: Expected the second argument to be a list of rational numbers in [0,1]";
    if product( w ) == 0 then -1 else
    (
	i := 0;	
	d := 0;
	while d < p and i < carryTest(p,w) do 
	(
	    i = i + 1;
	    d = sum digit( p, i, w )
	);
        if i == carryTest(p,w) then -1 else i
     )
)

--===================================================================================

getCanVector = method()

--canVector(i,n) returns the i-th canonical basis vector in dimension n
--Warning: for convenience, this uses Macaulay2's convention of indexing lists starting 
--with 0; so, for example, {1,0,0,0} is canVector(0,4), not canVector(1,4).
getCanVector ( ZZ, ZZ ) := ( i, n ) -> 
(
    if ( (i<0) or (i>=n) ) then error "canVector(i,n) expects integers i and n with 0<=i<n.";   
    apply( n, j -> if i==j then 1 else 0 )
)
 
--===================================================================================

getNumAndDenom = method()

-- Takes a rational vector u and returns a pair (a,q), where a
--is an integer vector and q an integer such that u=a/q.
getNumAndDenom ( List ) := u -> 
(
    den := lcm apply( u, denominator );
    a := apply( u, n -> lift( n*den, ZZ ) );
    ( a, den )        
)

--===================================================================================

taxicabNorm = method()

--Computes the taxicab norm of a vector.
taxicabNorm ( List ) := u -> sum( u, abs )

--===================================================================================

--Selects or finds positions of nonzero, zero, positive entries in a list
selectNonzero = L -> select( L, x -> x != 0 )
selectPositive = L -> select( L, x -> x > 0 )
nonzeroPositions = L -> positions( L, x -> x != 0 )
zeroPositions = L -> positions( L, x -> x == 0 )

--===================================================================================

--*************************************************
--Tests for various types of polynomials   
--*************************************************

--===================================================================================

--isPolynomial(F) checks if F is a polynomial
isPolynomial = method( TypicalValue => Boolean )

isPolynomial (RingElement) := Boolean => F -> isPolynomialRing( ring F ) 

--===================================================================================

--isPolynomialOverPosCharField(F) checks if F is a polynomial over a field
--of positive characteristic
isPolynomialOverPosCharField = method( TypicalValue => Boolean )

isPolynomialOverPosCharField (RingElement) := Boolean => F ->
    isPolynomial F and isField( kk := coefficientRing ring F ) and ( char kk ) > 0

--===================================================================================

--isPolynomialOverFiniteField(F) checks if F is a polynomial over a finite field.
isPolynomialOverFiniteField = method( TypicalValue => Boolean )

isPolynomialOverFiniteField (RingElement) := Boolean => F ->
    isPolynomialOverPosCharField( F ) and isFinitePrimeField(coefficientRing ring F)

--===================================================================================

--Determines whether a polynomial f is a diagonal polynomial (i.e., of the form 
--x_1^(a_1)+...+x_n^(a_n)) over a field of positive characteristic 
isDiagonal = method( TypicalValue => Boolean )

isDiagonal (RingElement) := Boolean => f ->
    isPolynomialOverPosCharField( f ) and 
    ( product( exponents( f ), v -> #(positions( v, x -> x != 0 )) ) == 1 )

--===================================================================================

--Returns true if the polynomial is a monomial
isMonomial = method( TypicalValue => Boolean )

isMonomial (RingElement) := Boolean => f -> 
    isPolynomial f and #( terms f ) == 1

--===================================================================================

--Returns true if the polynomial is a binomial over a field of positive characteristic
isBinomial = method( TypicalValue => Boolean )

isBinomial (RingElement) := Boolean => f -> 
    isPolynomialOverPosCharField f and #( terms f ) == 2

--===================================================================================
  
--isBinaryForm(F) checks if F is a homogeneous polynomial in two variables.
--WARNING: what we are really testing is if the *ring* of F is a polynomial ring in two 
--variables, and not whether F explicitly involves two variables. (For example, if F=x+y 
--is an element of QQ[x,y,z], this test will return "false"; if G=x is an element of 
--QQ[x,y], this test will return "true".)
isBinaryForm = method( TypicalValue => Boolean )

isBinaryForm (RingElement) := Boolean => F ->
    isPolynomial F and numgens ring F == 2 and isHomogeneous F 

--===================================================================================

--isNonconstantBinaryForm(F) checks if F is a nonconstant homogeneous polynomial in two 
--variables. See warning under "isBinaryForm".
isNonConstantBinaryForm = method( TypicalValue => Boolean )

isNonConstantBinaryForm (RingElement) := Boolean => F -> 
    isBinaryForm F  and ( degree F )#0 > 0

--===================================================================================

--isLinearBinaryForm(F) checks if F is a linearform in two variables. See warning 
--under "isBinaryForm".
isLinearBinaryForm = method( TypicalValue => Boolean )

isLinearBinaryForm (RingElement) := Boolean => F -> 
    isBinaryForm F and ( degree F )#0 == 1

--===================================================================================

--*************************************************
--Miscelaneous
--*************************************************

--===================================================================================

--===================================================================================

--Finds the x-intercept of a line passing through two points
xInt = ( x1, y1, x2, y2 ) ->
(
    if x1 == x2 then error "xInt: x1==x2 no intersection";
    x1-(y1/((y1-y2)/(x1-x2)))
)

--===================================================================================

