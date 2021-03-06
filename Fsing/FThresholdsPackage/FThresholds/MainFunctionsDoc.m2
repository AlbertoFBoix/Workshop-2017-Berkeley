doc ///
     Key
          BinaryFormCheck
     Headline
          An option for the function fpt to check whether input is binary form. 
     Description
          Text
               If {\tt true}, the input is a form in two variables (so that the function "binaryFormFPT" can then be used). 
	       Can take on only Boolean values.  Default value for fpt is {\tt true}.
     SeeAlso
          fpt
///

doc ///
     Key
          BinomialCheck
     Headline
          An option for the function fpt to check whether the input is a binomial polynomial. 
     Description
          Text
               If {\tt true}, the input is a binomial in a polynomial ring.  Can take on only Boolean values. 
	       Default value for fpt is {\tt true}.
     SeeAlso
          fpt
///

doc ///
     Key
          ComputePreviousNus
     Headline
          An option for functions nu and nuList to compute nus recursively. 
     Description
          Text
               If {\tt true}, then nu values are computed recursively, in succession; otherwise, another method can be applied.  
	       Can take on only Boolean values. Default value for nu and nuList is {\tt true}.
     SeeAlso
          nu
          nuList
///

doc ///
     Key
          ContainmentTest
     Headline
          An option for functions nu and nuList to specify containment test used. 
     Description
          Text
               Specifies which test you use to check containment of powers of ideals. Valid values are {\tt FrobeniusPower}, 
	       {\tt FrobeniusRoot}, and {\tt StandardPower}.  Default for nu and nuList applied to a polynomial is {\tt FrobeniusRoot}, 
	       and applied to an ideal is {\tt StandardPower}. 
///

doc ///
     Key
         criticalExponentApproximation
         (criticalExponentApproximation,ZZ,Ideal,Ideal)
         (criticalExponentApproximation,ZZ,RingElement,Ideal)
     Headline
        Gives a list of mu_I^J(p^d)/p^d or mu_f^J(p^d)/p^d for d=0,...,e.
     Usage
          criticalExponentApproximation(e,I,J)
          criticalExponentApproximation(e,f,J) 
     Inputs
         e:ZZ
         I:Ideal
         J:Ideal
         f:RingElement
     Outputs
         :List
     Description
         Text 
             This returns a list of mu_I^J(p^d)/p^d or mu_f^J(p^d)/p^dfor d = 0,...,e.  As p approaches infinity, 
	     the sequence of these terms converges to the critical exponent of I or f with respect to J.       
///

doc ///
     Key
          DiagonalCheck
     Headline
          An option for the function fpt to check whether the input is a diagonal polynomial. 
     Description
          Text
               Enables the user to check whether the input is a diagonal polynomial, i.e., of the form x_1^(d_1) + ... + x_n^(d_n) 
	       in a polynomial ring in variables x_1,...,x_n.  Can only take on Boolean values.  Default value for fpt is {\tt true}. 
     SeeAlso
          fpt
///

doc ///
     Key
         fpt
	 ( fpt, RingElement, ZZ )
	 [fpt, BinaryFormCheck]
	 [fpt, BinomialCheck]
	 [fpt, DiagonalCheck]
	 [fpt, FRegularityCheck]
	 [fpt, NuCheck]
     Headline
         Atempts to compute the F-pure threshold of a polynomial at the origin. 
     Usage
          fpt(f,e)
     Inputs
        f:RingElement
        e:ZZ
        BinaryFormCheck => Symbol
            Option to specify whether to check if f is a binary form.
        BinomialCheck => Symbol 
            Option to specify whether to check if f is a binomial polynomial.
	DiagonalCheck => Symbol
	    Option to specify whether to check if f is a diagonal polynomial.
	FRegularityCheck => Symbol
	    Option to specify whether to check if the given pair is F-regular at the homogeneous maximal ideal 
	    (so that if not, the F-pure threshold can be determined from the F-signature function).
    	NuCheck => Symbol
	    Option to specify whether to check if nu/(p^e-1) of (nu+1)/p^e is the F-pure threshold in computations.
     Outputs
        L:List
        Q:QQ
     Description
          Text 
              This function first tries to find an exact value for the F-pure threshold of f at the origin, and returns the value 
	      if possible.  Otherwise, it returns a range of possible values for the F-pure threshold.  If Options DiagonalCheck, 
	      BinomialCheck, and BinaryFormCheck are set to {\tt true}, respectively (and each have default value {\tt true}), 
	      then the function first checks whether f is a diagonal polynomial, a binomial polynomial, or a form in two variables, 
	      respectively.  If it is one of these, algorithms of D. Hernandez, or D. Hernandez and P. Teixeira, are executed to 
	      compute the F-pure threshold of f.  Otherwise, the function computes nu_f(p^e) and if NuCheck is set to {\tt true}
	      (its default value), then checks whether either nu/(p^e-1) or (nu+1)/p^e equal the F-pure threshold.  If the value 
	      is still unknown, the function uses the convexity of the F-signature function, and a secant line argument, to find 
	      the F-pure threshold.  If FRegularityCheck is set to {\tt true} (its default value), then 
	      
	      finalCheck is a Boolean with default value True that determines whether the last isFRegularPoly is run (it is possibly very slow).  
	      If FinalCheck is false, then a last time consuming check won't be tried.  If it is true, it will be. 
	      Verbose set to {\tt true} displays verbose output.
///

doc ///
     Key
         fptApproximation
         (fptApproximation,ZZ,Ideal)
         (fptApproximation,ZZ,RingElement)
     Headline
         Gives a list of nu_I(p^d)/p^d for d=0,...,e.
     Usage
          fptApproximation(e,I)
          fptApproximation(e,f) 
     Inputs
         e:ZZ
         I:Ideal
         f:RingElement
     Outputs
         :List
     Description
         Text 
             This returns a list of nu_I(p^d)/p^d for d = 0, ..., e.  The sequence {nu_I(p^d)/p^d} converges to the F-pure threshold.        
///


doc ///
     Key
          FRegularityCheck
     Headline
          An option for the function fpt
     Description
          Text
               Enables the user to check whether the given pair is F-regular at the given maximal ideal 
	            (so that if not, the F-pure threshold can be determined from the F-signature function).
		    Only takes on Boolean values. 
     SeeAlso
          fpt
///


doc ///
     Key
         ftApproximation
         (ftApproximation,ZZ,Ideal,Ideal)
         (ftApproximation,ZZ,RingElement,Ideal)
     Headline
         Gives a list of nu_I^J(p^d)/p^d for d=0,...,e.
     Usage
         ftApproximation(e,I,J)
         ftApproximation(e,f,J) 
     Inputs
         e:ZZ
         I:Ideal
         J:Ideal
         f:RingElement
     Outputs
         :List
     Description
         Text 
             This returns a list of nu_I^J(p^d)/p^d for d = 0, ..., e.  The sequence {nu_I^J(p^d)/p^d} converges to the F-threshold of I or f with respect to J.         
///

doc ///
     Key
        guessFPT 
     Headline
        Tries to guess the FPT in a really naive way (this should be improved).
     Usage
         guessFPT(f,e,d) 
     Inputs
         f:RingElement
         e:ZZ
         d:ZZ
     Outputs
        :List
     Description
        Text
             This tries to guess the FPT.  In particular, it computes the number nu such that nu/(p^e - 1) <= FPT < (nu+1)/p^e.  It then outputs a list of all rational numbers with denominators less than or equal to d, which lie in that range.  WARNING:  There are several improvements which should be made to this function to rule out many of the possibilies.
///

doc ///
     Key
        isFJumpingNumber 
        (isFJumpingNumber,QQ,RingElement)
     Headline
        Checks whether a given number is an F-jumping number
     Usage
         isFJumpingNumber(t,f,Verbose=>V)  
     Inputs
         t:QQ
         f:RingElement
         V:Boolean
     Outputs
        :Boolean
     Description
        Text
            Returns true if t is an F-jumping number, otherwise it returns false.
///
 
doc ///
     Key
        isFPT 
        (isFPT,QQ,RingElement)
     Headline
        Checks whether a given number is the FPT
     Usage
          isFPT(t,f,Verbose=>V,Origin=>W)  
     Inputs
        t:QQ
        f:RingElement
        V:Boolean
        W:Boolean
     Outputs
        :Boolean
     Description
        Text
             Returns true if t is the FPT, otherwise it returns false.  If Origin is true, it only checks it at the homogeneous maximal ideal.
///

 
doc ///
     Key
         nu
         (nu,ZZ,Ideal,Ideal)
         (nu,ZZ,Ideal)
         (nu,ZZ,RingElement,Ideal)
         (nu,ZZ,RingElement)
     Headline
        Gives $\nu_I^J(p^e)$ or $\nu_f^J(p^e)$
     Usage
          nu(e,I,J)
          nu(e,I)
          nu(e,f,J)
          nu(e,f) 
     Inputs
         e:ZZ
         I:Ideal
         J:Ideal
         f:RingElement
     Outputs
        :ZZ
     Description
        Text
            Given an ideal I in a polynomial ring k[x1, ..., xn], this function outputs the maximal integer nu such that I^nu is not in ideal J^[p^e].  If the input is (ZZ,Ideal) then the function computes the maximal integer nu such that I^nu in not in (x_1, ...,x_n)^[p^e]. If a RingElement is passed, it computes nu of the principal ideal generated by this element. This is used frequently to compute the F-pure threshold.
///

doc ///
     Key
          NuCheck
     Headline
          An option for the function fpt to specify whether the user would like to check whether nu/(p^e-1) or (nu+1)/p^e is the F-pure threshold.
     Description
          Text
               Takes on only Boolean values.  Default value for fpt is {\tt true}. 
     SeeAlso
          fpt
///

doc ///
     Key
         nuList
         (nuList,ZZ,Ideal,Ideal)
         (nuList,ZZ,Ideal)
         (nuList,ZZ,RingElement,Ideal)
         (nuList,ZZ,RingElement)
     Headline
        Lists nu_I^J(p^d)$ for d = 1,...,e
     Usage
          nuList(e,I,J)
          nuList(e,I)
          nuList(e,f,J)
          nuList(e,f) 
     Inputs
         e:ZZ
         I:Ideal
         J:Ideal
         f:RingElement
     Outputs
        :List
     Description
        Text
            Given an ideal I in a polynomial ring k[x1,...,xn], this function computes nu(d,I) for d = 0,...,e. If a RingElement is passed, it computes nu of the principal ideal generated by this element for d = 0,...,e.
///

doc ///
     Key
          OutputRange
     Headline
          An option for guessFPT
     Description
          Text
               Valid values are {\tt true} and {\tt false}
///

doc ///
     Key
          Search
     Headline
          An option for the functions nu and nuList
     Description
          Text
               Lets user specify the order in which ideal containment of powers are computed. Valid values are 
	            {\tt Binary, BinaryRecursive}, and {\tt Linear}. 
     SeeAlso
          nu
          nuList
///

doc ///
     Key
          UseColonIdeals
     Headline
          An option for nu and nuList
     Description
          Text
               Valid values are {\tt true} and {\tt false}. 
     SeeAlso
          nu
          nuList
///
