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
        options=[[S,R],[R,S]]
        temp=choice(options)
        A=prod(temp)
        op1=temp[0]
        op2=temp[1]
        if sum(op1-R)==0:
            string='Scaled by '+ latex(sx) + 'in the x direction and ' +latex(sy)+ 'in the y direction and then Rotated by <m>'+latex(theta)+'</m>'
        else:
            string='Rotated by <m>'+latex(theta)+'</m> and then scaled by '+ latex(sx) + 'in the x direction and ' +latex(sy)+ 'in the y direction'
        
        tasks=[{
            'A':A,
            'ans':string,
            '2or3':trans,
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
        options=[[R,S,T],[R,T,S],[T,R,S],[T,S,R],[S,R,T],[S,T,R]]
        temp=choice(options)
        A=prod(temp)
        op1=temp[0]
        op2=temp[1]
        op3=temp[2]
        if sum(op1-R)==0:
            if sum(op2-S)==0:
                string='Translated by '+latex(tx)+ ' units horizontally and '+latex(ty)+ ' units vetically, scaled by '+ latex(sx) + 'in the x direction and ' +latex(sy)+ 'in the y direction and, rotated by <m>'+latex(theta)+'</m>'  
            else:
                string='Scaled by '+ latex(sx) + 'in the x direction and ' +latex(sy)+ 'in the y direction, translated by '+latex(tx)+ ' units horizontally and '+latex(ty)+ ' units vetically, and rotated by '+latex(theta)+'</m>'
        elif sum(op1-T)==0:
            if sum(op2-S)==0:
                string='Rotated by '+latex(theta)+', scaled by '+ latex(sx) + 'in the x direction and ' +latex(sy)+ 'in the y direction, and translated by '+latex(tx)+ ' units horizontally and '+latex(ty)+ ' units vetically'   
            else:
                string='Scaled by '+ latex(sx) + 'in the x direction and ' +latex(sy)+ 'in the y direction, rotated by <m>'+latex(theta)+'</m>, and tanslated by '+latex(tx)+ ' units horizontally and '+latex(ty)+ ' units vetically'   

        elif sum(op1-S)==0:
            if sum(op2-R)==0 :
                string='Translated by '+latex(tx)+ ' units horizontally and '+latex(ty)+ ' units vetically, rotated by <m>'+latex(theta)+'</m>, and scaled by '+ latex(sx) + 'in the x direction and ' +latex(sy)+ 'in the y direction'
            else:
                string='Rotated by <m>'+latex(theta)+'</m>,Tanslated by '+latex(tx)+ ' units horizontally and '+latex(ty)+ ' units vetically, and scaled by '+ latex(sx) + 'in the x direction and ' +latex(sy)+ 'in the y direction'
                    

        tasks+=[{
            'A':A,
            'ans':string,
            '2or3':trans,
        }]

        
        shuffle(tasks)
  

       
        return {"tasks":tasks


            
        }
        
        
        
        