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
        
        v1 = vector([2, 1])
        v2 = vector([-1, 2])
        v3= 2*v1+3*v2

        # Set the limits for the grid coefficients
        min_val = -5
        max_val = 5

        # Create an empty Graphics object
        g = Graphics()

        # Plot the grid lines using linear combinations
        for i in range(min_val, max_val + 1):
            # Lines parallel to v2
            start_pt1 = i * v1 + min_val * v2
            end_pt1 = i * v1 + max_val * v2
            g += line([start_pt1, end_pt1], color='lightgray', thickness=1)
            
            # Lines parallel to v1
            start_pt2 = min_val * v1 + i * v2
            end_pt2 = max_val * v1 + i * v2
            g += line([start_pt2, end_pt2], color='lightgray', thickness=1)

        # Plot the basis vectors as arrows from the origin (removed legend_label)
        g += arrow([0,0], v1, color='red', width=2)
        g += arrow([0,0], v2, color='blue', width=2)

        # Add text labels slightly offset from the vector endpoints
        # vertical_alignment and horizontal_alignment help keep text from overlapping the arrow
        g += text("v1", v1 + vector([0.3, 0.3]), color='red', fontsize=12, horizontal_alignment='left')
        g += text("v2", v2 + vector([-0.3, 0.3]), color='blue', fontsize=12, horizontal_alignment='right')

        # Set plot aesthetics and display (ticks=[[], []] removes them)
        g.set_axes_range(-10, 10, -10, 10)
        g.show(aspect_ratio=1, title="Custom Basis Grid and Vectors", ticks=[[], []])

        return {
            "ls": ls,
            "veclist": TBIL.VectorList(A.columns()),
            "veclist2": TBIL.Vector_Naming(A),
            "vectors": vectors,
            "basis":g,
            # "combovector": column_matrix(A.column(-1)),
            # "statement": choice([True,False]),
            # "matrix": A,
            # "rref": A.rref(),
            # "pivots": A.pivots(),
        }