class Generator(BaseGenerator):
    def data(self):
        # Create 3x4,3x5,4x4,5x3 RREF matrices
        dims = sample([
            (3, 4, choice([2,3])),
            (3, 5, choice([2,3])),
            (4, 4, choice([2,3])),
            (5, 4, 2)], 1)
        i=0
        tsteps=0
        Row_ops=[]
        while tsteps<3:
            #tsteps=3
            matrix= CheckIt.simple_random_matrix_of_rank(
                    dims[0][2], rows=dims[0][0], columns=dims[0][1])
            A = matrix.change_ring(QQ)

            matrices = [copy(A)]
            M = copy(A)
            num_rows = M.nrows()
            num_cols = M.ncols()
            col = 0
            for row in range(num_rows):
                if col >= num_cols:
                    break
        
                # Find a non-zero entry below/in the current row
                pivot = M[row, col]
                if pivot == 0:
                    # Search for a non-zero row to swap
                    for r in range(row + 1, num_rows):
                        if M[r, col] != 0:
                            M.swap_rows(row, r)
                            Row_ops.append( f"R_{{ {row+1} }} \\leftrightarrow R_{{ {r+1} }}")
                            matrices.append(copy(M))
                            pivot = M[row, col]
                            break
        
                if pivot != 0:
                # Scale the pivot row to make the leading entry 1
                    if pivot != 1:
                        M.rescale_row(row, 1/pivot)
                        Row_ops.append(f"{latex(1/pivot)} R_{{ {row+1} }} \\to R_{{ {row+1} }}")
                        matrices.append(copy(M))
            
                    # Eliminate entries below the pivot
                    for r in range(row + 1, num_rows):
                        if M[r, col] != 0:
                            factor = -M[r, col] #/ M[row, col]
                            M.add_multiple_of_row(r, row, factor)
                            Row_ops.append( f"R_{{ {r+1} }} + ({factor}) R_{{ {row+1} }} \\to R_{{ {row+1} }}")
                            matrices.append(copy(M))
                col += 1

            # --- STEP 2: Backward Elimination ---
            for row in range(num_rows - 1, -1, -1):
                # Find the pivot column for this row
                pivot_col = None
                for c in range(num_cols):
                    if M[row, c] == 1:
                        pivot_col = c
                        break
                
                # Eliminate entries above the pivot
                if pivot_col is not None:
                    for r in range(row):
                        if M[r, pivot_col] != 0:
                            factor = -M[r, pivot_col]
                            M.add_multiple_of_row(r, row, factor)
                            Row_ops.append( f"R_{{ {r+1} }} + ({factor}) R_{{ {row+1} }} \\to R_{{ {row+1} }}")
                            matrices.append(copy(M))

            tsteps=len(matrices) - 1
        A=matrices[-4]
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
            "nsolution": num_sln,
            "Row_Op1": Row_ops[-3],
            "Row_Op2":Row_ops[-2],
        }