def solution(n):
    answer = ''    
    for i in range(n):
        if i%2==0:
            answer+='수'
        else :
            answer+='박'
    return answer

# 다른사람풀이
def water_melon(n):
    s = "수박" * n
    return s[:n]
# 다른사람풀이2
def water_melon(n):
    return "수박"*(n//2) + "수"*(n%2)
