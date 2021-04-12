def solution(arr):
    answer = []
    for i in range(len(arr)):
        if i>0 and arr[i] == arr[i-1]:
            continue
        answer.append(arr[i])
    return answer
