# HRV predict NonREM or REN
- decision tree, Random Forest, SVM 

## 결과분석
- agreement와 kappa값이 높을 수록 좋음. (acc와 유사)
- REM이 아닌 것은 모두 NonREM이므로 agreement는 최소 80이상 나올 것. > 의미가 없어짐 
- 따라서 이 예제에서는 agreement값이아닌 kappa값을 높여야함.
### 1. Decision Tree
- 하이퍼파라미터 자동화 결과
  - agreement / kappa : 0.8621 / 0.3926
  - 비교적 잘 맞추었음.\
  ![image](https://user-images.githubusercontent.com/70633080/120320556-4a1fd480-c31d-11eb-83e6-c6179151286e.png)
- 10 fold cross validation
  - base error / cross val error : 0.0053 / 0.0356 
  - cross val에서 에러가 증가함 >> 이는 과적합이라고 볼 수 있음.\
  ![image](https://user-images.githubusercontent.com/70633080/120320983-bbf81e00-c31d-11eb-830f-09db76048b28.png)
- 과적합 방지 pruning 
  - agreement / kappa : 0.8381 / 0.3498
  - best level =2
  - 더 좋아지지 않았음.\
  ![image](https://user-images.githubusercontent.com/70633080/120321136-e649db80-c31d-11eb-8c5d-0f312ec747d3.png)
  - 가지가 너무 무수하게 많음을 확인할 수 있음 > 가지수를 직접 지정해서 optimize를 해보자!
- MaxNumSplits (가지 수 지정) 
  - 가지 수를 1~50까지 돌려보면서 최소의 error를 가진 가지 수를 사용
  - agreement / kappa : 0.8741 / 0.4241
  - kappa조금 올라갔으며 REM조금 더 잘 맞춤\
  ![image](https://user-images.githubusercontent.com/70633080/120321705-961f4900-c31e-11eb-8707-33075118fdb1.png)
  - REM은 보통 연속적으로 나오기 때문에 잠깐 REM이였다 아닌것들은 decision level로 제거해줄 수 있음
  
### 2. Random Forest
- agreement / kappa : 0.8525 / 0.1397\
![image](https://user-images.githubusercontent.com/70633080/120342750-0c2dab00-c333-11eb-824d-8f25bb4adc9f.png)

### 3. SVM
- linear 결과
  - agreement / kappa : 0.8441/ 0.4896
  - kappa값이 올라갔음\
  ![image](https://user-images.githubusercontent.com/70633080/120343052-56169100-c333-11eb-9834-107602509836.png)
- 하이퍼파라미터 최적화 결과
  - agreement / kappa : 0.8189 /0.2965\
  ![image](https://user-images.githubusercontent.com/70633080/120344998-0df86e00-c335-11eb-9225-1aedfba3cbd4.png)

### [추가] 성능향상 방법
- HRV지표를 각각 통계분석을 해서 유의한 지표만 가지고 수행
- HRV지표를 각각 모델링 한 후 loss가 가장 적은 지표만 가지고 수행 
- 모든 HRV지표가 유의한것은 아니기 때문에 성능에 악영향을 미칠 수 있는 지표를 제거하고 진행할 수 있다.
