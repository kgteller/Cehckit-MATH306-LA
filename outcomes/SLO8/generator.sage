load("sagemath/library.sage")
TBIL.config_matrix_typesetting()

class Generator(BaseGenerator):
    def data(self):
        trans=2
        theta=choice([pi/3,pi/4,pi/6,pi/2])
        R = matrix(SR, 2, 2, [cos(theta), -sin(theta), sin(theta), cos(theta)])
        sx=choice([-1,1])*randrange(1,7)
        sy=choice([-1,1])*randrange(1,7)
        S=diagonal_matrix([sx, sy])
        options=[[S,R,'Scaled','Rotated'],[R,S,'Rotated','Scaled']]
        temp=choice(options)
        op1=temp[0]
        op2=temp[1]
        op1txt=temp[2]
        op2txt=temp[3]
        A=op1*op2
        if op2txt=='Scaled':
            string='Scaled by '+ latex(sx) + 'in the x direction and ' +latex(sy)+ 'in the y direction and then Rotated by <m>'+latex(theta)+'</m>'
        else:
            string='Rotated by <m>'+latex(theta)+'</m> and then scaled by '+ latex(sx) + 'in the x direction and ' +latex(sy)+ 'in the y direction'
        
        tasks=[{
            'A':A,
            'ans':string,
            '2or3':trans,
            'op1':op1,
            'op2':op2,
        }]
        trans=3
        theta=choice([pi/3,pi/4,pi/6,pi/2])
        R = matrix(SR, 3, 3, [cos(theta), -sin(theta),0, sin(theta), cos(theta),0,0,0,1])
        sx=choice([-1,1])*randrange(1,7)
        sy=choice([-1,1])*randrange(1,7)
        S=diagonal_matrix([sx, sy,1])
        tx=choice([-1,1])*randrange(1,7)
        ty=choice([-1,1])*randrange(1,7)
        T=matrix(3,3,[1,0,tx,0,1,ty,0,0,1])
        options=[[R,S,T,'R','S','T'],[R,T,S,'R','T','S'],[T,R,S,'T','R','S'],[T,S,R,'T','S','R'],[S,R,T,'S','R','T'],[S,T,R,'S','T','R']]
        temp=choice(options)
        op1=temp[0]
        op2=temp[1]
        op3=temp[2]
        optxt1=temp[3]
        opt2txt=temp[4]
        A=op1*op2*op3
        if optxt1=='R':
            if opt2txt=='S':
                string='Translated by '+latex(tx)+ ' units horizontally and '+latex(ty)+ ' units vetically, scaled by '+ latex(sx) + 'in the x direction and ' +latex(sy)+ 'in the y direction and, rotated by <m>'+latex(theta)+'</m>'  
            else:
                string='Scaled by '+ latex(sx) + 'in the x direction and ' +latex(sy)+ 'in the y direction, translated by '+latex(tx)+ ' units horizontally and '+latex(ty)+ ' units vetically, and rotated by <m>'+latex(theta)+'</m>'
        elif optxt1=='T':
            if opt2txt=='S':
                string='Rotated by <m>'+latex(theta)+'</m>, scaled by '+ latex(sx) + 'in the x direction and ' +latex(sy)+ 'in the y direction, and translated by '+latex(tx)+ ' units horizontally and '+latex(ty)+ ' units vetically'   
            else:
                string='Scaled by '+ latex(sx) + 'in the x direction and ' +latex(sy)+ 'in the y direction, rotated by <m>'+latex(theta)+'</m>, and tanslated by '+latex(tx)+ ' units horizontally and '+latex(ty)+ ' units vetically'   

        elif optxt1=='S':
            if opt2txt=='R' :
                string='Translated by '+latex(tx)+ ' units horizontally and '+latex(ty)+ ' units vetically, rotated by <m>'+latex(theta)+'</m>, and scaled by '+ latex(sx) + 'in the x direction and ' +latex(sy)+ 'in the y direction'
            else:
                string='Rotated by <m>'+latex(theta)+'</m>,Tanslated by '+latex(tx)+ ' units horizontally and '+latex(ty)+ ' units vetically, and scaled by '+ latex(sx) + 'in the x direction and ' +latex(sy)+ 'in the y direction'
                    

        tasks+=[{
            'A':A,
            'ans':string,
            '2or3':trans,
            'op1':op1,
            'op2':op2,
            'op3':op3,
        }]

        
        shuffle(tasks)
  

       
        return {"tasks":tasks


            
        }
        
        
        
        