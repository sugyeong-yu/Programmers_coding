

def solution(n, m):
    answer = []
    # 최대공약수
    for i in range(n,0,-1):
        if n%i==0 and m%i==0:
            answer.append(i)
            break
    
    #최소공배수
    for i in range(max(n,m),n*m+1):
        if i%n==0 and i%m==0:
            answer.append(i)
            break
    return answer

#다른사람 풀이
# 최대공약수-유클리드 호제법 / 최소공배수-input 2개를 곱하고 최대 공약수로 나눔
# 유클리드호제법: 2개의 자연수 a, b에 대해서 a를 b로 나눈 나머지를 r이라 하면(단, a>b), a와 b의 최대공약수는 b와 r의 최대공약수와 같다.
function solution(n, m) {
    return [ gcd(n,m), (n*m) / gcd(n,m)]
}

function gcd(a, b) { // 단, a가 b보다 커야함.
        let R;
        while ((a % b) > 0)  {
             R = a % b; //나머지
                a = b;
                b = R;
        }
         return b;
        }
