- 딥러닝 헷갈리는 개념들
## Pickle file
- list나 class 같은 text가 아닌 자료형데이터는 일반적인 파일입출력 방법으로는 데이터를 불러올 수 없다.
- python에서는 이와 같은 자료형의 데이터를 파일로 저장하기 위해 pickle모듈을 사용한다.

- ```import pickle``` 로 모듈임포트가 필요함
- 원하는 데이터를 자료형의 변경없이 파일로 저장하여 그대로 로드할수있다.
  - (open('text.txt','w')방식으로 데이터를 입력하면 string자료형으로 저장된다.)
- pickle로 데이터를 저장하거나 불러올때는 파일을 BYTE형식으로 읽거나 써야한다.(wb,rb)
- wb로 데이터를 입력하는 경우 .bin확장자를 사용하는 것이 좋다.
- 모든 파이썬데이터객체를 저장하고 읽을 수 있다.
### 입력
- ```pickle.dump(data,file)```
```
import pickle
list = ['a', 'b', 'c']
with open('list.txt', 'wb') as f:
  pickle.dump(list, f)
```
### LOAD
- val=pickle.load(file)
- 한줄씩 파일을 읽어오며 더이상 로드할 데이터가 없으면 EOFError가 발생
```
with open('list.txt', 'rb') as f:
  data = pickle.load(f) # 단 한줄씩 읽어옴

data
#['a', 'b', 'c']
```
- pickle.load(file)을 통해 파일을 읽기위해서는 pickle.dump로 입력된 파일이어야 한다.

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

## Keras와 Torch 차이
### keras와 torch의 학습방식
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

### Loss function
- torch
  - torch.nn.BCEloss

### model save & load
- torch ``` torch.save()```
  - 모델전체저장
    - 모델 파라미터 뿐만아니라 optimizer, epoch, score 모두 저장 
    - 나중에 이어서 학습 or 권한이없는 사용자가 모델을 사용할 수 있도록 할때
    ```
    torch.save(model, 'model.pt')
    torch.load('model.pt')
    ```
  - 모델의 state_dict()만 저장 
    - 학습가능한 매개변수가 담겨있는 dictionary 
    - 가중치와 편향을 저장. 
    - 코드상으로 모델이 구현되어 있는 경우에만 로드하는 방법을 통해 사용
    - 용량이 가벼움
    ```
    torch.save(model.state_dict(), 'model.pt')
    torch.load_state_dict(torch.load('model.pt'))
    ```
### tensorboard 사용법
```
import torch
from torch.utils.tensorboard import SummaryWriter
writer=SummaryWriter()
```
- SumarryWriter instance를 생성해야한다.
- Writer는 기본적으로 ```./runs/ ``` dir에 생성됨

#### scalar 기록하기
- 스칼라는 각 학습단계에서 손실 값, 각 에폭의 정확도를 저장하는데 도움을 준다.
- 스칼라값 기록은 ``` add scalar(tag,scalar_value,global_step=None,walltime=None) ```을 사용한다.
```
for epoch in range(iter):
  y1=model(x)
  loss=criterion(y1,y)
  writer.add_scalar("Loss/train",loss,epoch)
  optimizer.zero_grad()
  loss.backward()
  optimizer.step()
 writer.flush()
 ```
 - 모든 보류중인 이벤트가 디스크에 기록되었는지 확인하려면 flush()를 호출한다.
 - Summary writer가 더이상 필요하지 않으면 close()를 호출한다. ```writer.close()```
 #### TensorBoard 실행하기
 ``` pip install tensorboard ```
 - 위에서 설정한 루트로그dir을 지정하여 tensorboard를 시작한다. 
 - logdir에는 tensorboard가 출력할 수 있는 이벤트 파일을 찾을  dir을 가르킨다.
 ``` tensorboard --logdir=runs```
 - 제공하는 url로 이동하거나 http://localhost:6006/ 으로 이동한다.
 - 이 대시보드는 매 에폭마다 손실과 정확도가 어떻게 변화하는지 보여준다.
