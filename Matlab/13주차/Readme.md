# HRV predict NonREM or REN
- decision tree, Random Forest, SVM 

## 결과분석

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
  - 더 좋아지지 않았음.\
  ![image](https://user-images.githubusercontent.com/70633080/120321136-e649db80-c31d-11eb-8c5d-0f312ec747d3.png)
 
