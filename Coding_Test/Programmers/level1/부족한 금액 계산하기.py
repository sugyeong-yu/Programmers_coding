def solution(price, money, count):
    answer = -1
    fee=0
    for n in range(1, count+1):
        fee=fee+(price*n)
    return 0 if (money-fee)>=0 else abs(money-fee)
