def solution(n, lost, reserve):
    borrow=[]
    #print(borrow)
    for j in range(1,n+1):
        #print(lost[j])
        if j in reserve and j in lost:
            lost.remove(j)
            reserve.remove(j)
            print("Find! -> ",reserve)
    for i in range(len(lost)):
        print("Not Find! -> ",reserve)
        if lost[i]-1 in reserve :
            print(lost[i],"에게 ", lost[i]-1,"가 체육복을 빌려준다.")
            borrow.append(lost[i])
            print(borrow)
            reserve.remove(lost[i]-1)
        elif lost[i]+1 in reserve:
            print(lost[i],"에게 ", lost[i]+1,"가 체육복을 빌려준다.")
            borrow.append(lost[i])
            print(borrow)
            reserve.remove(lost[i]+1)
    answer=n-len(lost)+len(borrow)
    return answer

##다른사람 풀이
def solution(n, lost, reserve):
    _reserve = [r for r in reserve if r not in lost]
    _lost = [l for l in lost if l not in reserve]
    for r in _reserve:
        f = r - 1
        b = r + 1
        if f in _lost:
            _lost.remove(f)
        elif b in _lost:
            _lost.remove(b)
    return n - len(_lost)
