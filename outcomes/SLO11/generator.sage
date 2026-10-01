load("sagemath/library.sage")
TBIL.config_matrix_typesetting()

class Generator(BaseGenerator):
    def data(self):
        # create a 4x4 invertible matrix
        A = CheckIt.simple_random_matrix_of_rank(4,rows=4,columns=4)
        new_vector = column_matrix(vector(QQ, [randrange(1,7)*choice([-1,1]) for _ in range(4)]))
        old_vector = A*new_vector
        lin_combo_exp = TBIL.LinearCombination([new_vector[i]for i in range(4)],[LatexExpr(f"\\vec b_{i+1}") for i in range(4)],)

        y_b=column_matrix(vector(QQ, [randrange(1,7)*choice([-1,1]) for _ in range(4)]))
        y=A*y_b
        return {
            "M_B": A^(-1),
            "v": old_vector,
            "lin_combo_exp": lin_combo_exp,
            "b_1": column_matrix(A.columns()[0]),
            "b_2": column_matrix(A.columns()[1]),
            "b_3": column_matrix(A.columns()[2]),
            "b_4": column_matrix(A.columns()[3]),
            "y_b": y_b,
            'y': y ,
        }