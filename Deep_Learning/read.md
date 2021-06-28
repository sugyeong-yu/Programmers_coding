- 딥러닝 헷갈리는 개념들
## Image load
1. Open cv
2. PILLOW
```
file_path='D:\prlab\class\\2020-1(machin_learning)\data\\train\\real\\*.jpg'
file_list=glob.glob(os.path.join(file_path))
img= Image.open(self.imgs[index])
```
## 모델 파라미터
- batch_Normalization : Gradient Vanishing/Gradient Exploding 을 방지하기 위한 방법 중 하나.
  - 불안정한 학습의 원인 -> Internal Covariance Shift 라고 주장. : 이는 각 층, Activation마다 input의 distribution이 달라지는 현상
  - 이를 막기 위해 각 층의 input의 distribution을 평균 0, 표준편차 1인 input으로 norm해주는 것.
  - 보통 학습 시 미니배치 단위로 데이터를 가져오는데 각 feature별로 평균,표준편차를 구한다음 norm해주고 scale factor와 shift factor를 이용해 새로운 값을 만들어준다.
  - 실제 적용에서는 특정 은닉층에 들어가기전 batch norm layer를 더해주어 input을 modify해준 뒤 새로운 값을 activation function으로 넣어준다.
  
## keras의 validation split / sklearn의 train_test_split() 차이점
- sklearn
```
from sklearn.model_selection import train_test_split
X_train, X_test, y_train, y_test = train_test_split(X, y,
                                                    test_size = 0.2,
                                                    random_state = 1)
```
  - 랜덤가능
- train_test_split()
  - 랜덤 불가능

## keras와 torch의 학습방식
- keras
  - model.compile(optimizer, loss_function ...)
  - model.fit(epoch,validation_data,metrics=[accuracy]...) > 알아서 validation loss까지 계산
  - model.eval() > 알아서 성능평가 loss와 acc
  - 조기종료, checkpoint 모듈 사용가능
- torch
  - loss=f()
  - optimizer=Adam()
  - model.train()
  - optimizer=zero_grad()
  - loss.backward()
  - optimizer.step()
  - val_loss=loss(pred,target)> validation loss알아서 계산해야함.
  - model.eval()
  - 조기종료, checkpoint 모듈 사용불가능 > 알아서 함수로 짜야함. 
  - val_loss=loss(pred,target)> 알아서 계산해야함.
