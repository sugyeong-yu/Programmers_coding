def solution(strings, n):
    answer=sorted(sorted(strings),key= lambda string:string[n])
    return answer
