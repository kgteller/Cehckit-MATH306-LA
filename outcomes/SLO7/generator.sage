load("sagemath/library.sage")
TBIL.config_matrix_typesetting()

class Generator(BaseGenerator):
    def data(self):
        e1=column_matrix([1,0])
        e2=column_matrix([0,1])
        B = matrix(QQ,2,[choice([-1,1])*randrange(2,7) for _ in range(4)])
        C = matrix(QQ,2,[choice([-1,1])*randrange(2,7) for _ in range(4)])
        v=column_matrix([choice([-1,1])*randrange(2,7) for _ in range(2)])
        Tmap1 = B*e1
        Tmap2=  B*e2
        Smap1 = C*e1
        Smap2=  C*e2
        Tv=B*v
        Sv=C*v
        w=column_matrix([choice([-1,1])*randrange(2,12) for _ in range(2)])
        ToS=['T','S']
        shuffle(ToS)

        composition=ToS[0] + '\circ ' + ToS[1]
        if ToS[0]=='T':
            comp=B*C*w
        else:
            comp=C*B*w
  

       
        return {"Tmap1":Tmap1,
                "Tmap2": Tmap2,
                "Smap1":Smap1,
                "Smap2": Smap2,
                "e1" :e1,
                "e2":e2,
                "B": B,
                "C": C,
                "v": v,
                "Tv": Tv,
                "Sv": Sv,
                'composition': composition,
                'w':w,
                'comp':comp,


            
        }
        
        
        
        