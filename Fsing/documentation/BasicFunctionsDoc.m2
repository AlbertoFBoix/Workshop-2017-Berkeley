--***********************************************
--***********************************************
--Documentation for BasicFunctions.m2
--***********************************************
--***********************************************

doc ///
    Key
        adicExpansion
        (adicExpansion, ZZ, ZZ)
        (adicExpansion, ZZ, ZZ, QQ)
        (adicExpansion, ZZ, ZZ, ZZ)
    Headline
        computes base p expansions
    Usage
        adicExpansion(p,N)
        adicExpansion(p,e,x)
    Inputs 
        p:ZZ
	    positive
        N:ZZ
	    positive	
        e:ZZ
	    positive
        x:QQ
	    in the interval [0,1]
	    x:ZZ
	    in the inverval [0,1]	
    Outputs
        :List
    Description
        Text
            {\tt adicExpansion(p,0)} returns $\{ 0 \}$.  
            If $N$ is nonzero, then {\tt adicExpansion(p,N)} returns a list in 
            which the $i$th element is the coefficient of $p^i$ in the base $p$ 
            expansion of $N$.  
        Example
            5==1*2^0+0*2^1+1*2^2
            adicExpansion(2,5)
        Text
            {\tt adicExpansion(p,e,0)} returns a list with $e$ elements, all of which
            are zero. If $x$ is nonzero, then {\tt adicExpansion(p,e,x)} returns a 
            list of size $e$ in which the $i$th element is the coefficient of 
            $p^{-i-1}$ in the unique nonterminating base $p$ expansion of $x$.  
            For example, the non-terminating base 2 expansion of 1/2 is 
            $1/2 = 0/2 + 1/4 + 1/8 + 1/16 + \cdots$, and so 
        Example
            adicExpansion(2,4,1/2)
///


doc ///
    Key
        adicDigit
        (adicDigit, ZZ, ZZ, ZZ)
        (adicDigit, ZZ, ZZ, QQ)
        (adicDigit, ZZ, ZZ, List)
    Headline
        computes the digit of the non-terminating expansion of a number in [0,1] in a given base
    Usage 
        adicExpansion(p,e,x)
        adicExpansion(p,e,L)
    Inputs
        p:ZZ
            positive
        e:ZZ
            positive
        x:QQ
            in the interval [0,1]
    Outputs   
        :ZZ
    Description
        Text    
            The command {\tt adicDigit(p,e,0)} returns 0.  If $x\in (0,1]$, 
            then {\tt adicDigit(p,e,x)} returns the coefficient of $p^{-e-1}$ in 
            the non-terminating base $p$ expansion of $x$.  
        Example
            adicDigit(5,4,1/3)
        Text
            If $L$ is a list
            of numbers in the unit interval,  {\tt adicDigit(p,e,L)}
            returns a list where this function is applied to each 
            element of $L$. 
        Example
            adicDigit(5,4,{1/3,1/7,2/3})
///




doc ///
    Key
        floorLog
        (floorLog, ZZ, ZZ)
    Headline
        computes the floor of the log base b of x
    Usage
     	floorLog(b,x)         
    Inputs
        b:ZZ
            greater than 1
        x:ZZ
	    positive
    Outputs
        :ZZ
    Description
        Text
            {\tt floorLog(b,x)} computes {\tt floor(log_b(x))}, correcting occasional 
            errors due to rounding.
        Example
            floor( log_3 3^5 )
            floorLog( 3, 3^5 )
/// 
    
doc ///
    Key
        multiplicativeOrder
        (multiplicativeOrder, ZZ, ZZ)
    Headline
        computes the multiplicative order of an integer modulo another
    Usage
        multiplicativeOrder(a,b)
    Inputs
        a:ZZ
        b:ZZ
            prime to {\tt a}		
    Outputs
        :ZZ
    Description
        Text
            This computes the multiplicative order of $a$ modulo $b$.  
            If $a$ and $b$ are not relatively prime, it returns an error.
        Example
            multiplicativeOrder(2, 11^2)
            multiplicativeOrder(3, 11^2)
            multiplicativeOrder(4, 11^2)
///

doc ///
    Key
        decomposeFraction
        (decomposeFraction, ZZ, QQ)
        (decomposeFraction, ZZ, ZZ)
    Headline
        decompose a rational number into a/(p^b(p^c-1))
    Usage
        L = decomposeFraction(p,t)
        L = decomposeFraction(p,n)
    Inputs
        p:ZZ
            a prime
        t:QQ
        n:ZZ		
    Outputs
        L:List
    Description
        Text
            Given a rational number $t$ and a prime $p$, {\tt decomposeFraction(p,t)} 
            returns a list {\tt \{a,b,c\}} of nonnegative integers such that 
            $t = a/(p^b(p^c-1))$.
        Example
            decomposeFraction( 3, 4/45 )
            4/45 == 64/( 3^2 * ( 3^4 -1 ) )
        Text
            If the denominator is a pure power of $p$, then $t = a/p^b$ and the 
            function returns {\tt c = 0}. See the option @TO NoZeroC@ to avoid this.
        Example
            decomposeFraction( 3, 4/27 )
///

doc ///
    Key
        [decomposeFraction, NoZeroC]
    Headline
        decompose a rational number into a/p^b(p^c-1) and force c not equal to zero
    Usage
        L = decomposeFraction(..., NoZeroC => b)
    Inputs
        b:Boolean
    Outputs
        L:List
    Description
        Text
            We are writing a rational number as $a/(p^b(p^c-1))$.
            If our number is $a/p^b$ then there is no valid value of $c$ and the 
            function returns $c = 0$. Setting the option {\tt NoZeroC => true} 
            forces the third entry of the output list to be nonzero, even if
            that means increasing the first entry.
        Example
            decomposeFraction( 3, 4/27)
            decomposeFraction( 3, 4/27, NoZeroC => true )
            4/27 == 8/( 3^3 * ( 3 - 1 ) )
///   

doc ///
    Key
        NoZeroC
    Headline
        an option for decomposeFraction
    Description
        Text
            Valid values are {\tt true} or {\tt false}.
    SeeAlso
        decomposeFraction
///         

 
doc ///
    Key
        adicTruncation
        (adicTruncation, ZZ, ZZ, ZZ)
        (adicTruncation, ZZ, ZZ, QQ)
        (adicTruncation, ZZ, ZZ, List)
    Headline
        computes the e-th truncation of the non-terminating base p expansion of a rational number
    Usage
        adicTruncation(p, e, r)
        adicTruncation(p, e, L)
    Inputs
        p:ZZ
            a prime
        e:ZZ
        r:QQ
            a rational number to compute the truncation of
        L:List
            a list of rational numbers to compute the truncation of
    Outputs
        :QQ
            the trunction
    Description
        Text
            This function computes the rational number equal to the $e$th truncation 
            of a rational number.  If you pass it zero, it returns zero.            
        Example
            adicTruncation(5, 2, 1/100)
            adicTruncation(5, 4, 1/100)
            adicTruncation(5, 5, 1/1000)
        Text
            You can also pass it a list of numbers, in which case it returns the 
            list of the truncations.
        Example
            adicTruncation(5, 5, {1/100, 1/1000})
///
