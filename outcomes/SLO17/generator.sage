load("sagemath/library.sage")
TBIL.config_matrix_typesetting()
import random
class Generator(BaseGenerator):
    def data(self):
            import random

            # --- Configuration parameters ---
            # Lower bounds mean smaller integer components (e.g., -5 to 5)
            min_val = -7
            max_val = 7

            # 1. Generate a random target angle between 0 and pi radians
            target_angle = RR(random.uniform(0, float(pi)))

            # 2. Generate a random non-zero small integer vector u
            while True:
                w = vector(ZZ, [random.randint(min_val, max_val) for _ in range(3)])
                if w != 0:
                    break

            # 3. Search the local integer grid for the vector v that best matches the angle
            best_v = None
            min_error = float('inf')

            # Scan all possible small integer combinations for v
            for x in range(min_val, max_val + 1):
                for y in range(min_val, max_val + 1):
                    for z in range(min_val, max_val + 1):
                        test_v = vector(ZZ, [x, y, z])
                        if test_v == 0 or test_v == w or test_v == -w:
                            continue
                            
                        # Calculate the angle between u and this test vector
                        try:
                            cos_sim = (w * test_v) / (w.norm() * test_v.norm())
                            # Clip cos_sim slightly to prevent floating point domain errors
                            cos_sim = max(-1.0, min(1.0, float(cos_sim)))
                            test_angle = acos(cos_sim)
                            
                            # Check how close it is to our target angle
                            error = abs(test_angle - target_angle)
                            if error < min_error:
                                min_error = error
                                best_v = test_v
                        except ZeroDivisionError:
                            continue

            # Assign the winner
            v = best_v

            # 4. Simplify v by dividing by its GCD to keep components as small as possible
            g = gcd(v)
            if g > 1:
                v = vector(ZZ, [x // g for x in v])
        
        
            v_pres=column_matrix(v)
            w_pres=column_matrix(w)
            vw=v*w
            vv=v*v
            ww=w*w
            theta=N(arccos(vw/(sqrt(vv)*sqrt(ww))))
            uv=randint(1,15)
            uw=randint(1,15)
            while uv == uw:
                uw = randint(1, 100)
            k=randint(1,15)*choice([-1,1])
            a = randint(1, 20)
            b = randint(1, 20)
            while a == b:
                b = randint(1, 20) 
            ans3=a*uv-b*uw
            orth=choice(['v','w'])
            if orth=='v':
                other='w'
                ans4=-k*(vw/vv)
            else:
                ans4=-k*(vw/ww)
                other='v'
            




            return {
            "v": v_pres,
            "w":w_pres,
            "vv": vv,
            "ww": ww,
            "vw": vw,
            "theta": theta,
            "uv": uv,
            "uw": uw,
            "k": k,
            "a": a,
            "b":b,
            "orthog": orth,
            "other": other,
            "ans3":ans3,
            "ans4":ans4,



        }