load("sagemath/library.sage")
TBIL.config_matrix_typesetting()

class Generator(BaseGenerator):
    def data(self):
        cl=choice([4,5])
        A=CheckIt.simple_random_matrix_of_rank(3,rows=3,columns=cl)

        vec_names=TBIL.Vector_Naming3(A)
        temp=srange(0,cl)
        shuffle(temp)
        vecbasis1=A[:,temp[:3]]
        vecnames1=[r"\mathbf v_"+str(i+1) for i in temp[:3]]
        vecbasis2=A[:,temp[1:4]]
        vecnames2=[r"\mathbf v_"+str(i+1) for i in temp[1:4]]
        if cl==5:
            vecbasis2=A[:,temp[2:5]]
            vecnames2=[r"\mathbf v_"+str(i+1) for i in temp[2:5]]
            
        basis1="is a basis"
        if vecbasis1.det()==0:
            basis1= "is not a basis"
        basis2='is a basis'
        if vecbasis2.det()==0:
            basis2="is not a basis"
        vecstring1=", ".join(vecnames1)    
        vecstring2=", ".join(vecnames2)

        # basis = choice([True,False])
        # if basis:
        #     rank = 4
        # else:
        #     rank = choice([2,3])
        # A=CheckIt.simple_random_matrix_of_rank(rank,rows=4,columns=4)
 
        # tasks +=  [{
        #     "basis": basis,
        #     "vecset": TBIL.Vector_Naming3(A),
        #     "matrix": A,
        #     "rref": A.rref(),
        #     statements[1]: True,
        #     "veceqleft": TBIL.LinearCombinationFromMatrix(A),
        # }]

        # basis = not basis
        # if basis:
        #     rank = 4
        # else:
        #     rank = choice([2,3])
        # A=CheckIt.simple_random_matrix_of_rank(rank,rows=4,columns=4)
 
        # tasks +=  [{
        #     "basis": basis,
        #     "vecset": TBIL.Vector_Naming3(A),
        #     "matrix": A,
        #     "rref": A.rref(),
        #     statements[2]: True,
        #     "veceqleft": TBIL.LinearCombinationFromMatrix(A),
        # }]

        # single_task=choice(tasks)

        return {
            "vecset": TBIL.Vector_Naming3(A),
            "matrix": A,
            "rref": A.rref(),
            "veceqleft": TBIL.LinearCombinationFromMatrix(A),
            "vb1":vecbasis1,
            "vb1rref":vecbasis1.rref(),
            "vn1":vecstring1,
            "vb2":vecbasis2,
            "vb2rref":vecbasis2.rref(),
            "vn2":vecstring2,
            "b1":basis1,
            "b2":basis2}