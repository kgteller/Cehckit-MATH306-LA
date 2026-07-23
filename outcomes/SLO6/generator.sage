load("sagemath/library.sage")
TBIL.config_matrix_typesetting()

class Generator(BaseGenerator):
    def data(self):
        independent = choice([True,False])
        cols=choice([3,4])
        rows=4
        if independent:
            rank = cols
            ind='independant'
        else:
            rank= cols-choice([1,2])
            ind='dependant'

        A=CheckIt.simple_random_matrix_of_rank(rank,rows=rows,columns=cols)

        coefficients=[var(f"v_{i}") for i in range(1,cols+1)]
        vectors=[column_matrix(v) for v in A.columns()]
        string=""
        for i in range(0,cols-1):
            string+= latex(coefficients[i])+'='
            string+=latex(vectors[i])
            string+=", "
        string2=latex(coefficients[-1])+'='
        string2+=latex(vectors[-1])

        return {"vecset": TBIL.VectorSet(A.columns()),
                "matrix": A,
                "rref": A.rref(),
                "statement1":string,
                "statement2":string2,
                'independence':ind,
        }
        
        
        
        