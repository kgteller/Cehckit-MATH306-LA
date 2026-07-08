load("sagemath/library.sage")
TBIL.config_matrix_typesetting()

class Generator(BaseGenerator):
    def data(self):
        rank=choice([2,3,4])
        col=choice([4,5])
        A=CheckIt.simple_random_matrix_of_rank(rank,rows=4,columns=col)
        acopy1=copy(A)
        acopy1.subdivide([],col-1)
        ans1b=acopy1.rref()

        acopy2=copy(A[:,0:-1])
        acopy2.subdivide([],col-2)
        ans2b=acopy2.rref()

        if A[:,0:-1].rank()<4:

            ans3='Does not span'

        else:
            ans3='Does span'
        named_vectors=[r"\mathbf u",r"\mathbf v",r"\mathbf w",r"\mathbf y"]
        veclist=TBIL.Vector_Naming2(A)
        vecnames=named_vectors[0:col-1]
        vecnames2=named_vectors[0:col-2]
        vecname=named_vectors[col-2]
        return {"veclist":veclist,
                "vecnames":vecnames,
                "vecnames2":vecnames2,
                "vecname":vecname,
                "ans1a": acopy1,
                "ans1b": latex(ans1b),
                "ans2a": acopy2,
                "ans2b": ans2b,
                "ans3":ans3,
        
        
        
        }