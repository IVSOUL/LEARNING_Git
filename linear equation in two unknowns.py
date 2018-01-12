import math

a = float(raw_input('Enter coefficient a: '))
b = float(raw_input('Enter coefficient b: '))
c = float(raw_input('Enter coefficient c: '))
if a != 0:
    delta = b ** 2 - 4 * a * c
    if delta < 0:
        print 'No solution'
    elif delta == 0:
        s = -b/(2 * a)
        print 's:',s
    else:
        root = math.sqrt(delta)
        s1 = (-b + root)/(2 * a)
        s2 = (-b - root)/(2 * a)
        print 'Two distinct solutions are:',s1, s2
else:
    print 'False Number'