class Generator(BaseGenerator):
    def data(self):
        # Create 3x4,3x5,4x4,5x3 RREF matrices
        dims = sample([
            (3, 4, choice([2,3])),
            (3, 5, choice([2,3])),
            (4, 4, choice([2,3])),
            (5, 3, 2)
        ], 1)
        i=0
        A= CheckIt.simple_random_matrix_of_rank(
                dims[0][2], rows=dims[0][0], columns=dims[0][1]
            ).rref()
        num_ops=choice([3,4,5])
        Row_ops=[]
        op=['add','add','swap','scale','add','add','scale']
        for k in range(num_ops):
            #op=choice(['add','swap','scale'])
            if op[k]=='add':
                rows=sample(range(dims[0][0]),2)
                toprow = rows[0]
                bottomrow = rows[1] #andrange(1, dims[i][2])
                scale = randrange(2,5)*choice([-1,1])
                E = elementary_matrix(dims[i][0], row1=toprow, row2=bottomrow, scale=scale)
                A = E*A
                Row_ops.append( f"R_{{ {toprow+1} }} + ({-scale}) R_{{ {bottomrow+1} }} \\to R_{{ {toprow+1} }}")
            elif op[k]=="swap" :
                rows=sample(range(dims[0][0]),2)
                toprow = rows[0]
                bottomrow = rows[1]#andrange(1, dims[i][2])
                E = elementary_matrix(dims[i][0], row1=toprow, row2=bottomrow)
                A = E*A
                Row_ops.append( f"R_{{ {toprow+1} }} \\leftrightarrow R_{{ {bottomrow+1} }}")
            elif op[k]=="scale" :
                onlyrow = randrange(1, dims[i][0])
                scale = randrange(2,5)*choice([-1,1])
                E = elementary_matrix(dims[i][0], row1=onlyrow, scale=scale)
                A= E*A
                Row_ops.append(f"{latex(1/scale)} R_{{ {onlyrow+1} }} \\to R_{{ {onlyrow+1} }}")
        ab_rnk=A.rank()
        a_rnk=A[:,0:dims[0][1]-1].rank()
        if ab_rnk==a_rnk:
            if a_rnk==dims[0][1]-1:
                num_sln='consistent, unique solution'
            else:
                num_sln='consistent, infinitely many solutions'
        else:
            num_sln='inconsistent, No solution'


        A.subdivide(None,[dims[i][1]-1])       

        return {
            "A": A,
            "Arref": A.rref(),
            "Row_Operations": Row_ops[::-1],
            "nsolution": num_sln,
        }