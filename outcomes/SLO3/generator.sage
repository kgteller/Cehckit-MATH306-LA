load("sagemath/library.sage")
TBIL.config_matrix_typesetting()

class Generator(BaseGenerator):
    def data(self):
        # create a 4x3 or 3x4 matrix
        rows = randrange(3,5)
        columns = 7-rows
        a,b,c,d = var("a b c d")
        ls = [a,b,c,d][:rows]

        # roll different statements
        statements = [f"statement{l}" for l in "ABCDEF"]
        shuffle(statements)

        #start with nice RREF
        number_of_pivots = 2
        A = CheckIt.simple_random_matrix_of_rank(number_of_pivots,rows=rows,columns=columns)

        #linear combo
        coeffs = [
            randrange(1,4)*choice([-1,1])
            for _ in range(columns)
        ]
        lin_combo = sum([
            coeffs[p]*A.column(p)
            for p in A.pivots()
        ])
        lin_combo_exp = TBIL.LinearCombination(
            [
                coeffs[A.pivots()[i]]
                for i in range(number_of_pivots)
            ],
            [
                column_matrix(A.column(A.pivots()[i]))
                for i in range(number_of_pivots)
            ],
        )
        A_aug = A.augment(column_matrix(lin_combo), subdivide=True)
        vectors = [
            {
                "v": column_matrix(lin_combo),
                "lin_combo": True,
                "lin_combo_exp": lin_combo_exp,
                "A": A_aug,
                "rref": A_aug.rref(),
                "veceq": TBIL.VectorEquation(A_aug),
                statements[0]: True,
            }
        ]

        # non-linear combo
        non_lin_combo = lin_combo + vector(ZZ, [
            choice([-1,1])
            for _ in range(rows)
        ])
        while non_lin_combo in A.column_space():
            non_lin_combo += vector(ZZ, [
                choice([-1,1])
                for _ in range(rows)
            ])
        A_aug = A.augment(column_matrix(non_lin_combo), subdivide=True)
        vectors += [
            {
                "v": column_matrix(non_lin_combo),
                "lin_combo": False,
                "A": A_aug,
                "rref": A_aug.rref(),
                "veceq": TBIL.VectorEquation(A_aug),
                statements[1]: True,
            }
        ]

        shuffle(vectors)

        

        return {
            "ls": ls,
            "veclist": TBIL.VectorList(A.columns()),
            "veclist2": TBIL.Vector_Naming(A),
            "vectors": vectors,
            # "combovector": column_matrix(A.column(-1)),
            # "statement": choice([True,False]),
            # "matrix": A,
            # "rref": A.rref(),
            # "pivots": A.pivots(),
        }

    @provide_data
    def graphics(data):
        """
        Variables generated above are available in the
        data dictionary (see `data["lines"]` below). Graphics
        take a long time to generate and take up a lot of
        space on the disk, so consider carefully if they are necessary.

        This should return a dictionary of the form
        `{filename_string: graphics_object}` which will each produce
        `f"{filename_string}.png}"`.
        """
        # Define your basis vectors in R2
        v1 = vector([choice([-1,1])*randrange(1,2), choice([-1,1])*randrange(1,3)])
        v2 = vector([choice([-1,1])*randrange(1,3), randrange(1,3)])
        dproduct=(v1/v1.norm())*(v2/v2.norm()).n()
        while abs(dproduct.n())>.5:
            v1 = vector([choice([-1,1])*randrange(1,2), choice([-1,1])*randrange(1,3)])
            v2 = vector([choice([-1,1])*randrange(1,3), randrange(1,3)])
            dproduct=(v1/v1.norm())*(v2/v2.norm()).n() 
        v3 = choice([-1,1])*randrange(1,4)*v1-choice([-1,1])*randrange(1,4)*v2
            
        # Define grid range constraints
        grid_min, grid_max = -30, 30

        # Generate lines parallel to v2, shifting along v1
        grid_v1 = sum(plot(line([i*v1 + grid_min*v2, i*v1 + grid_max*v2], color='lightblue', thickness=1)) 
                    for i in range(grid_min, grid_max + 1))

        # Generate lines parallel to v1, shifting along v2
        grid_v2 = sum(plot(line([grid_min*v1 + j*v2, grid_max*v1 + j*v2], color='lightblue', thickness=1)) 
                    for j in range(grid_min, grid_max + 1))


        # Plot the basis vectors using the plot command wrapper for arrows
        arrow1 = plot(arrow((0,0), v1, color='black', width=2, arrowsize=3))
        arrow2 = plot(arrow((0,0), v2, color='black', width=2, arrowsize=3))
        arrow3 = plot(arrow((0,0), v3, color='black', width=2, arrowsize=3))

        # Add text labels positioned slightly past the tip of each vector (multiplied by 1.15)
        label1 = plot(text("v1", 1.15 * v1, color='black', fontsize=12, fontweight='bold'))
        label2 = plot(text("v2", 1.15 * v2, color='black', fontsize=12, fontweight='bold'))
        label3=  plot(text("b", 1.15 * v3, color='black', fontsize=12, fontweight='bold'))

        # Combine all elements
        final_plot = grid_v1 + grid_v2 + arrow1 + arrow2+ arrow3+label1 + label2 + label3

        # Calculate the exact outer corners of your grid to dynamically set limits

        n_max=round(max(v1.norm(),v2.norm(),v3.norm()))
        final_plot.set_axes_range(-2*n_max,2*n_max,-2*n_max,2*n_max)
        final_plot.show()
        return {
            "basis": final_plot,
        }