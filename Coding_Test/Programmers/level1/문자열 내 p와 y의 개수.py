def solution(s):
    c_s=list(s.lower()).count('p')
    c_y=list(s.lower()).count('y')

    if c_s == c_y :
        return True
    else :
        return False
