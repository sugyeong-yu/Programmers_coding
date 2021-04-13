
def solution(n):
    r=""
    while True:
        n, re=divmod(n,3)
        r+=str(re)
        if n ==0 :
            break
    answer=int(r,3)
    return answer
