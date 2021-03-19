def solution(n, lost, reserve):
    borrow=len(lost)
    for j in range(borrow):
        if lost[j] in reserve:
            lost.remove(lost[j])
            reserve.remove(lost[j])
            print("Find! -> ",reserve)
    for i in range(borrow):
        print("Not Find! -> ",reserve)
        if lost[i]-1 in reserve :
            print(lost[i],"에게 ", lost[i]-1,"가 체육복을 빌려준다.")
            lost.remove(lost[i])
            reserve.remove(lost[i]-1)
        elif lost[i]+1 in reserve:
            print(lost[i],"에게 ", lost[i]+1,"가 체육복을 빌려준다.")
            lost.remove(lost[i])
            reserve.remove(lost[i]+1)
    print(borrow)
    answer=n-len(lost)
    return answer
