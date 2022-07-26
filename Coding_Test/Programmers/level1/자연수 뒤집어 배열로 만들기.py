def solution(n):
    answer=[int(s) for s in str(n)[::-1]]
    return answer

#다른사람풀이
def solution(n):
    return list(map(int,reversed(str(n))))
