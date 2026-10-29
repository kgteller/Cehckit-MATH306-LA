load("sagemath/library.sage")
TBIL.config_matrix_typesetting()
import random
class Generator(BaseGenerator):
    def data(self):
            evals = random.sample(srange(1, 11), 3)

# Build a 3x3 upper triangular matrix
# The main diagonal gets 'evals', and entries above the diagonal get random integers
            A = Matrix(QQ,3,3,[evals[0]*choice([-1,1]),random.randint(1, 5)*choice([-1,1]),random.randint(-5, 5)*choice([-1,1]),0, evals[1]*choice([-1,1]),random.randint(-5, 5)*choice([-1,1]),0,0,evals[2]*choice([-1,1])])
            #n=3
            #A = matrix(ZZ, n, n, {(i, j): ZZ.random_element(-10, 10) for i in range(n) for j in range(n) if i <= j})
            #P1,L,U=A.LU()
            D, P = A.eigenmatrix_right()
            B=CheckIt.simple_random_matrix_of_rank(rank=2,rows=2, columns=2)
            v1=column_matrix(B.column(0))
            v2=column_matrix(B.column(1))
            lambda1=round(1.5*RR.random_element(0, 1),2)
            lambda2=round(1.5*RR.random_element(0,1)*choice([1,-1]),2)
            x=column_matrix([choice(srange(1,7))*choice([1,-1]),choice(srange(1,7))*choice([1,-1])])
            sln=B.inverse()*x
            power=choice(srange(2,9))




            return {
            "matrix": A,
            "D":D,
            "P": P,
            "v1": v1,
            "v2": v2,
            "l1": lambda1,
            "l2": lambda2,
            "x": x,
            "lincom1":sln[0],
            "lincom2":sln[1],
            "pwr":power,



        }