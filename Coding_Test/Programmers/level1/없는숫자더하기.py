# set은 교집합,차집합,합집합을 구할 수 있음 intersection, union, difference
def solution(numbers):
    check=[i for i in range(0,10)]
    diff=set(check).difference(set(numbers))
    return sum(diff)

#다른사람풀이
def solution(numbers):
    return 45 - sum(numbers)
