# HRV pred Non-REM or REM

## Protocol
1. HRV지표값 (Time / Freq) 계산
2. Knn 사용하여 학습 
    1. 하이퍼파라미터 최적화
3. 나이브베이즈로 학습
    1. 하이퍼파라미터 최적화
    2. qua
4. Linear(판별분석)으로 학습
5. 사전확률 조정 ( 일반적으로 전체수면중 Non-REM일 확률과 REM일 확률)
## 결과분석
- multi-kappa() : 교수님이 직접 만든 함수, distance 계산
  - agreement, kappa : 일치도 볼 때 많이 보는 지표, 둘다 높아야 좋다. (agreement는 비교적 잘 안봄)
  - table : confusion matrix
  - kappa는 보통 0.7~0.8이면 best performance
  - agreement의 경우 REM이 아닌 모든 수면단계를 Non-REM으로 묶게 되면 최소 80%이상 나온다. 따라서 의미가 없어짐. > kappa위주로 확인해야한다.

### 1. Knn
- 하이퍼파라미터 최적화 결과
  - agreement / kappa : 0.8645 / 0.3502
  - kappa가 낮음.\
![image](https://user-images.githubusercontent.com/70633080/120194051-1038ca80-c258-11eb-9b75-7b316d0e7516.png)

### 2. 나이브베이즈
- 하이퍼파라미터 최적화 결과
  - agreement / kappa : 0.8513 / 0.0
  - kappa가 0 매우낮음\
![image](https://user-images.githubusercontent.com/70633080/120194922-2bf0a080-c259-11eb-8f5b-225ffff69bfa.png)
- qua로 지정결과
  - agreement / kappa : 0.8369 / 0.3515
  - 여전히 kappa 낮음

- **분석해보아야 할 점**
  - qua가 비교적 linear(판별분석)보다 잘맞음 > 사실 qua가 잘 맞으려면 linear 역시 잘 맞아야함.
  - 그러나 linear방식은 kappa가 0.0  이였다.
  - 1. 하이퍼파라미터 자동조정 방식에서 문제가 발생했을 것 > 파라미터를 하나하나 보며 진행해야함
  - 2. 사전확률을 지정하여보자.

### 3. 판별분석
- 하이퍼파라미터 최적화 결과
  - agreement / kappa : 0.8513 / 0.0
  - 나이브베이즈와 마찬가지\
 ![image](https://user-images.githubusercontent.com/70633080/120195213-7245ff80-c259-11eb-8ea9-072d08179a8b.png)

### 4. 사전확률 조정
- [0.9 , 0.1] 
  - agreement / kappa : 0.8489 / 0.4541
  - 전보다는 높아지긴 했지만 여전히 낮은 kappa값을 보임

- 따라서 만든 feature가 얼마나 어떻게 이상하길래 이상한데서 feature를 찾는것인가를 봐야함.
- 훈련의 방향성이 컨퓨전매트릭스 , 우리는 모든단계를 논램수면이라해도 정확도가 85%가 나오는것,,, 정답을 맞추느니 모든걸
% 논램이라고 하는게 최적이라고 판단하고 훈련된것,,,
% 다시 원점으로돌아와서 우리는 feature의 모습을 확인해봐야함! 

## Low data 분석
- M_HR, LFHF, 수면 stage Data확인
![image](https://user-images.githubusercontent.com/70633080/120193464-6d804c00-c257-11eb-9110-fe39240ad94f.png)
- 전반적으로 증가하는 추세를 보임. 
- 그러나 REM일때와 NonREM일때 값의 차이가 별로 없음
- 또한, REM일때와 NonREM일때 데이터의 y값(높이)에 균일성, 규칙성이 없음 
- 해결책
  - 1. smoothing
  - 2. smoothing 크기를 300 등 크게 하면 높이가 울렁이는 트렌드를 뺄 수 있음

## After smoothing
- smoothing 50 수행결과
  - 빨간선이 smoothing결과\
 ![image](https://user-images.githubusercontent.com/70633080/120301741-230ad800-c308-11eb-9819-b90cf817a5d0.png)
- smoothing 300 수행결과
  - 빨간선이 smoothing 결과\
 ![image](https://user-images.githubusercontent.com/70633080/120301838-3cac1f80-c308-11eb-8144-188db7af3204.png)

### 1. Knn 
- 하이퍼파라미터 최적화 결과
  - agreement / kappa : 0.8297 / 0.3491
  - 스무딩전과  결과 유사\
![image](https://user-images.githubusercontent.com/70633080/120306542-eab9c880-c30c-11eb-947f-d8041a76cb24.png)
 
### 2. 나이브베이즈
- 하이퍼파라미터 최적화 결과
  - agreement / kappa : 0.8118 / 0.3570
  - 스무딩 전보다 훨씬 좋아짐
- qua 지정 결과
  - agreement / kappa : 0.8129 / -0.0352
### 3. 판별분석
- 하이퍼파라미터 최적화 결과
  - agreement / kappa : 0.8477 / 0.2258
  - 스무딩 전보다 좋아짐
### 4. 사전확률
- **[0.9 , 0.1]**
  - agreement / kappa : 0.8789 / 0.6347 
- [0.8 , 0.2]
  - agreement / kappa : 0.8189 / 0.5219
  
## [추가] 성능 높일 수 있는 방법
- HRV 10개를 이동평균을 계산
- Non REM과 REM에 대해 각 지표들의 통계분석을 해봄.
  - 유의하지 않은 지표는 빼버림
  - 10 개중엔 수면단계를 잘 반영하지 않은 케이스가 분명 있을것.
