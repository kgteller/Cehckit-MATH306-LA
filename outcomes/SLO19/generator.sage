load("sagemath/library.sage")
TBIL.config_matrix_typesetting()
import random
class Generator(BaseGenerator):
    def data(self):
            m=choice([4,5,6])
            n=choice([2,3])
            T = 10
            while True:
                A = random_matrix(ZZ, m, n, x=-3, y=4)
                if A.rank() == n:
                    Q_int = TBIL.primitive_orthogonal_Q(A, threshold=T)
                    if Q_int is not None:
                        v_out = TBIL.external_vector_nonzero_proj(Q_int, threshold=T)
                        if v_out is not None:
                            break
            #print(Q_int.dimensions())
            #print(n)
            #v_out=Q_int*random_vector(ZZ,n)+v_out
            cols = [col / col.norm() for col in Q_int.columns()]
            Qint_normalized = matrix(cols).transpose()
            P=Qint_normalized*Qint_normalized.T
            b_hat=P*v_out

            return {
            "vecset": TBIL.VectorList(Q_int.columns()),
            "b":column_matrix(v_out),
            "dim":n,
            "space":m,
            "P":P,
            "bhat":column_matrix(b_hat),
          



        }