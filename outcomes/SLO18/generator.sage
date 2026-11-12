load("sagemath/library.sage")
TBIL.config_matrix_typesetting()
import random
class Generator(BaseGenerator):
    def data(self):
            m=choice([4,5,6])
            n=choice([2,3])
            A=CheckIt.simple_random_matrix_of_rank(rank=n,rows=m, columns=n)
            AT_null=A.transpose().rref()
            pivots = AT_null.pivots()
            free_vars = [c for c in range(m) if c not in pivots]

            parametric_basis = []
            for f in free_vars:
                # Create a zero vector of length equal to the number of columns in A^T
                vec = vector(QQ, m)
                # Set the current free variable to 1 (and all other free variables to 0)
                vec[f] = 1
                # Solve for each pivot variable: x_pivot = -AT_null[row, free_var]
                for row_idx, p_col in enumerate(pivots):
                    vec[p_col] = -AT_null[row_idx, f]
                parametric_basis.append(vec)    
            pb=matrix(parametric_basis).T



            return {
            "vecset": TBIL.VectorList(A.columns()),
            "AT_null":AT_null,
            "Vec_null":TBIL.VectorSet(pb.columns()),
            "dim":n,
            "space":m,
          



        }