def solution(n):
    num=pow(n,0.5)
    if num>0 and int(num)**2==n:
        return pow(num+1,2)
    return -1
  
 
#다른사람풀이
def nextSqure(n):
    sqrt = n ** (1/2)

    if sqrt % 1 == 0:
        return (sqrt + 1) ** 2
    return -1
