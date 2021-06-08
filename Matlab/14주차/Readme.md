## code inform
- code1 : clustering (계수적 클러스터링, 덴드로그램, cutoff 설정)
- code2 : K-means clustering
- code3 : PCA
- code4 : REM과 NON REM HRV지표를 가지고 분류해보기 > PCA사용

## HRV지표로 REM과 NonREM 분류하기 (PCA사용)
### PCA 
- 다변량 분석기법
- 주성분이라고 불리는 선형조합으로 표현하는 기법
- 차원을 축소할 때 사용
- 데이터를 가장 잘 표현하는 (분산이 큰) 축을 찾겠다는것.
- 데이터의 정보를 가장 많이 담고있는 축만 골라내서 사용함으로 차원을 줄일 수 있음
- 분류모델, 회귀모델에 모두 활용이 가능하다.

- 첫번째 주성분(PC1) : 독립변수들의 분산을 가장 많이 설명하는 성분
  - 데이터를 축으로 Projection 했을 때 분산이 가장 큰 축
- 두번째 주성분(PC2) : PC1과 수직인 주성분
  - PC1과 선형독립적인(othogonal) 축으로 PC1이 설명하지 못하는 성분들을 표현하는 축이다.
  - PC1과 PC2는 선형독립적. 

```
[coeff,score,latent,tsquared,explained,mu] = pca(nX_tr);
```
- coeff : 선형변환 metrix
  - var1 * PC1_1 + var2 * PC1_2 = PC1
  - var1 * PC2_1 + var2 * PC2_2 = PC2\
  ![image](https://user-images.githubusercontent.com/70633080/121180234-98901e80-c89b-11eb-9349-4e0d443fdd7b.png)
- score : 주성분 PC1, PC2
- latent : 분산
- tsquared : 변수에 대한 평균거리 , 얼마나 차이가 나는지 거리를 나타냄 (많이사용하지않는 지표)
- explained : PC1, 2가 Data를 얼마나 사용 가능한가.\
![image](https://user-images.githubusercontent.com/70633080/121180249-9c23a580-c89b-11eb-9410-1df6b84bf353.png)

- PCA 결과 예시 
  - 왼 : 원래 data , 오 : PCA 결과 (가로축 : PC1, 세로축: PC2)
  - 위에서 PC1의 explained가 98 > 98% 데이터 설명 가능 이므로 PC1만 사용해도 Data를 분류할 수 있음.
  - PC2로 projection해보면 Data 분류가 불가능 > explained가 1.8%이기 떄문
![image](https://user-images.githubusercontent.com/70633080/121180298-ac3b8500-c89b-11eb-8b18-d1cb898e9401.png)

