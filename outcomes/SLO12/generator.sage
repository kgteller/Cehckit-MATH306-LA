load("sagemath/library.sage")
TBIL.config_matrix_typesetting()

class Generator(BaseGenerator):
    def data(self):

        var('k')
        entries=[randrange(1,7)*choice([-1,1]) for _ in range(8)]
        entries.append(k)
        shuffle(entries)
        A=matrix(3,3,entries)
        sln=solve(A.det()==0,k)
        #ans=k.subs(sols[1])

        return {
            "det": A.det(),
            "matrix": A, 
            "sln":sln,
            }