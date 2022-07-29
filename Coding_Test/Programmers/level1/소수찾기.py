# 에라토스테네스의 체: 어떤 수의 소수의 여부를 확인 할 때는, 특정한 숫자의 제곱근 까지만 약수의 여부를 검증하면 O(N^1/2)의 시간 복잡도로 빠르게 구할 수 있다.
# 1. 배열을 생성하여 초기화한다.
# 2. 2부터 시작해서 특정 수의 배수에 해당하는 수를 모두 지운다.(지울 때 자기자신은 지우지 않고, 이미 지워진 수는 건너뛴다.)
# 3. 2부터 시작하여 남아있는 수를 모두 출력한다.

def solution(n):
    answer=0
    isPrime=[True]*n
    
    m=int(n**0.5)
    for i in range(2,m+1):
        if isPrime[i-1]==True:
            for j in range(i*2,n+1,i):
                isPrime[j-1]=False
    return len([i for i in range(2,n+1) if isPrime[i-1]== True])
  
  
# 다른사람풀이
def solution(n):
    num=set(range(2,n+1))

    for i in range(2,n+1):
        if i in num:
            num-=set(range(2*i,n+1,i))
    return len(num)
