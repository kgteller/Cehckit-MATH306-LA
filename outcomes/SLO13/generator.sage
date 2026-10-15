load("sagemath/library.sage")
TBIL.config_matrix_typesetting()

class Generator(BaseGenerator):
    def data(self):
        col= choice([4,5,6])
        rank=choice(srange(2,col))
        A= CheckIt.simple_random_matrix_of_rank(rank, rows=4, columns=col)
        Arref=A.rref()
        Null_basis = A.right_kernel().basis()
        pivots = A.rref().pivots()
        col_basis = [A.column(p) for p in pivots]


        return {
            "A": A,
            "Arref": Arref, 
            "null":TBIL.VectorSet(Null_basis),
            "col":TBIL.VectorSet(col_basis),
            "cdim":rank,
            "ndim":col-rank,

            }