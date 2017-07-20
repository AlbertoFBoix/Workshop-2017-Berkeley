newPackage(
        "SpaceCurves",
        Version => "0.1", 
        Date => "",
        Authors => {{Name => "", 
                  Email => "", 
                  HomePage => ""}},
        Headline => "database of space curves and generation of such examples",
        DebuggingMode => true
        )

export {
    "isSmooth",
    "AbstractSurface",
    "DivisorClass",
    "RealizedSurface",
    "ExtraData",
    "divisorClass",
    "abstractSurface",
    "abstractQuadric",
    "abstractCubic",
    "realizeSurface",
    "realize",
    "CanonicalClass",
    "Hyperplane",
    "IntersectionPairing",
    "irreducibleOnCubic",
    "effectiveDivisorsOnCubic",
    "realizedDivisorOnCubic",
    "Class",     --Different name??   
    "Chi" -- Euler characteristic of OO_X.
    }

isSmooth = method()
isSmooth Ideal := (I) -> (
    c := codim I;
    dim(I + minors(c, jacobian I)) == 0
    )
AbstractSurface = new Type of HashTable
-- IntersectionMatrix
-- Hyperplane
-- CanonicalClass
-- Chi
AbstractDivisor = new Type of HashTable
-- AbstractSurface
-- DivisorClass
RealizedSurface = new Type of HashTable
-- AbstractSurface
-- Ideal
-- ExtraData (e.g. For cubic: (Phi:P^2-->P^3))
RealizedDivisor = new Type of HashTable
-- AbstractDivisor
-- RealizedSurface
-- Ideal

ideal RealizedSurface := X -> X.Ideal
ideal RealizedDivisor := C -> C.Ideal

abstractSurface = method()
abstractSurface RealizedSurface := X -> X.AbstractSurface
abstractSurface AbstractDivisor := D -> D.AbstractSurface
abstractSurface(Matrix, List, List, ZZ) := (M, hyperplane, canonical, surfaceChi) -> (
    -- M is integer matrix of intersection pairing of Num(X)
    rho := numRows M;
    if rho != numColumns M then error "expected square matrix";
    -- TODO: add hodge index.
    new AbstractSurface from {
        symbol IntersectionPairing => M,
        symbol Hyperplane => hyperplane,
        symbol CanonicalClass => canonical,
        symbol Chi => surfaceChi
        }
    )

abstractQuadric = abstractSurface(matrix{{0,1},{1,0}}, {1,1}, {-2,-2}, 1)
abstractCubic = abstractSurface(
    -- generators are L, -E1, ..., -E6
    diagonalMatrix{1, -1, -1, -1, -1, -1, -1},
    {3,1,1,1,1,1,1}, 
    -{3,1,1,1,1,1,1},
    1)
linesOnCubic = () -> (
    Ds := apply(entries diagonalMatrix{1, -1, -1, -1, -1, -1, -1}, 
             d -> divisorClass(d,abstractCubic)
             );
    L := Ds#0;
    Es := drop(Ds,1);
    join(
        Es,
        for p in subsets(splice {1..6}, 2) list (
            L - Ds#(p#1) - Ds#(p#0)
            ),
        for i from 0 to 5 list (
            2*L - sum drop(Es, {i,i})
            )
        )
    )

abstractDivisor = method()
abstractDivisor(List, AbstractSurface) := (C, X) -> (
    new AbstractDivisor from {
        symbol DivisorClass => C,
        symbol AbstractSurface => X
        }
    )
net AbstractDivisor := D -> net D.DivisorClass

ZZ * AbstractDivisor := (n,D) -> (
    AbstractDivisor(n * D.DivisorClass, D.AbstractSurface)
    )
AbstractDivisor + AbstractDivisor := (C,D) -> (
    assert(C.AbstractSurface === D.AbstractSurface);
    AbstractDivisor(C.DivisorClass + D.DivisorClass, D.AbstractSurface)
    )
AbstractDivisor - AbstractDivisor := (C,D) -> (
    assert(C.AbstractSurface === D.AbstractSurface);
    AbstractDivisor(C.DivisorClass - D.DivisorClass, D.AbstractSurface)
    )

AbstractDivisor * AbstractDivisor := (C,D) -> (
    X := C.AbstractSurface;
    assert(X === D.AbstractSurface);
    (matrix{C.DivisorClass} * X.IntersectionPairing * transpose matrix{D.DivisorClass})_(0,0)
    )

degree AbstractDivisor := C -> (
    X := C.AbstractSurface;
    (matrix{C.DivisorClass} * X.IntersectionPairing * transpose matrix{X.Hyperplane})_(0,0)
    )
genus DivisorClass := C -> (
    X := C.AbstractSurface;
    K := AbstractDivisor(X.CanonicalClass,X);
    1/2*((K+C)*C)+1
    )
chi DivisorClass := C -> (
    X := C.AbstractSurface;
    K := AbstractDivisor(X.CanonicalClass,X);
    1/2 * (C * (C-K)) + X.Chi
    )

-- Checks whether a divisor class on the abstract cubic is irreducible
irreducibleOnCubic = method()
irreducibleOnCubic DivisorClass := Boolean => (C) -> (
    X := C.AbstractSurface;
    if X =!= abstractCubic then error "expected a divisor class on the cubic surface";
    H := divisorClass(X.Hyperplane,X);
    twentysevenLines := linesOnCubic();
    any(twentysevenLines, L -> L.Class == C.Class)
    or -- these are the conics:
    any(twentysevenLines, L -> (H-L).Class == C.Class)
    or (
     all(twentysevenLines, L -> L * C >= 0)
      and
     C*C > 0
     )
    )


realizeSurface = method(Options => {Ring => null, CoefficientRing => ZZ/32003})
realizeSurface AbstractSurface := opts -> X -> (
    -- Note: this is in P^3
    R := if opts#Ring =!= null then 
        opts#Ring 
      else (
        x := getSymbol "x";
        opts.CoefficientRing[x_0..x_3]
      );
    kk := coefficientRing R;
    -- create the polynomial ring.
    if X === abstractCubic then (
        y := getSymbol "y";
        S := kk(monoid[y_0..y_2]);
        RS := R ** S;
        while (
            M := diagonalMatrix({1,1,1}) | matrix{{1},{1},{1}} | random(S^3,S^2);
            points := apply(6,i-> ideal (vars S * syz transpose M_{i}));
            I := intersect points;
            fI := res I;
            phi := map(S,R,fI.dd_1);
            matS := sub(diff(transpose sub(vars S,RS),sub(vars R,RS) * sub(fI.dd_2,RS)),R);
            f := ideal det matS;
            -- now check that this is smooth
            --assert(ker phi == f);
            dim (f + ideal jacobian f) != 0
            ) do ();
        return new RealizedSurface from {
            symbol AbstractSurface => abstractCubic,
            symbol Ideal => f, 
            symbol ExtraData => (phi, points)
            }
        );
    if X === abstractQuadric then (
        IQ := ideal(R_0*R_3-R_1*R_2);
        return (IQ, ideal(R_0, R_1), ideal(R_0, R_2))
        );
    error "don't know how to realize your pathetic surface";
    )

realizeDivisor = method()
realizeDivisor (AbstractDivisor,RealizedSurface) := (C, X) -> (
    if abstractSurface C =!= abstractSurface X then error "expected divisor class on the given surface";
    if abstractSurface X === abstractCubic then (
        -- check irreducibility from numerical criterion
        if not irreducibleOnCubic C then return null else (
            (phi,pts) := X.ExtraData;
            S := target phi;
            R := source phi;
            ab := C.Class;
            a := ab_0;
            ipts := trim intersect (for i from 1 to 6 list (pts_(i-1))^(ab_i));
            gipts := gens ipts;
            if min flatten degrees source gipts > a then return null else (
                cplane := ideal (gipts*random(source gipts,S^{-a}));
                SC := S/cplane;
                cspace := trim ker map(SC,R,phi.matrix);
                return cspace;
            )
        )
        -- 
        );
    error "not implemented yet for your type of surface"
    )
realizeDivisor AbstractDivisor := C -> (
    X := realizeSurface C.AbstractSurface;
    realizeDivisor(C,X)
    )
realize (ZZ,ZZ,RealizedSurface) := (a,d,X) -> (
    dList := effectiveDivisorsOnCubic(a,d);
    irreducibleList := select(dList,C->irreducibleOnCubic C);
    apply(irreducibleList, D -> 
    	(degree D,genus D, D, betti res realize(D,X)))
)

effectiveDivisorsOnCubic = method()
effectiveDivisorsOnCubic (ZZ,ZZ) := (a,d) -> (
    dlist := apply(select(partitions(3*a-d),p->#p<=6),q-> {a} | toList q | splice{(6-#q):0});    
    apply(dlist,L -> divisorClass(L,abstractCubic))
)


beginDocumentation()

TEST ///
  X = abstractQuadric
  R = QQ[a,b]
  C = divisorClass({a,b},X)
  assert(degree C == a+b)
  assert(genus C == (a-1)*(b-1))
  assert(chi C == (a+1)*(b+1))
///

TEST ///
  X = abstractCubic
  R = QQ[a,b_1..b_6]
  C = divisorClass(gens R,X)
  degree C
  genus C
  factor chi C
///

TEST ///
  S = ZZ/32003[a..d]
  X = realizeSurface(abstractCubic, Ring => S)

  C = divisorClass({3,1,1,1,0,0,0},abstractCubic)
  irreducibleOnCubic C
  assert(degree C == 6)
  assert(genus C == 1)
  betti(I = realize(C,X))
  isSmooth I
  betti res I
  assert(degree I == degree C)
  assert(genus I == genus C)
///

TEST ///
  S = ZZ/32003[a..d]
  X = realizeSurface(abstractCubic, Ring => S)

  C = divisorClass({2,1,1,1,0,0,0},abstractCubic)
  irreducibleOnCubic C
  (degree C, genus C)
  I = realize(C,X)
  betti I
  isSmooth I
  betti res I
  assert(degree I == degree C)
  assert(genus I == genus C)
///

end--

restart
needsPackage "SpaceCurves"
check "SpaceCurves"

S = ZZ/32003[x_0..x_3]
X = realizeSurface(abstractCubic, Ring => S)
a = 6
d = 10
L=realize(a,d,X);#L
netList L



