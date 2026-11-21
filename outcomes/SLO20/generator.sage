load("sagemath/library.sage")
TBIL.config_matrix_typesetting()
import random
class Generator(BaseGenerator):
    def data(self):
            m=choice([4,5])
            n=choice([m-2,m-1])
            A=CheckIt.simple_random_matrix_of_rank(rank=n,rows=m, columns=n)
            G, M = A.transpose().gram_schmidt()
            Orthog_basis=G.transpose()
            
            

            return {
            "vecset": TBIL.VectorList(A.columns()),
            "basis":TBIL.VectorList(Orthog_basis.columns()),
            "dim":n,
            "space":m,
            "R":M.T,
            "A":A,
            "Q":Orthog_basis,
          



        }