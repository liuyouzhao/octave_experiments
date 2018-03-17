num=300;
Z=1:1:num; %观測值  
noise=randn(1,num)*20; %方差为1的高斯噪声  
Z=Z+noise;
  
X=[0; 0]; %状态  
Sigma = [1 0; 0 1]; %状态协方差矩阵  
F=[1 1; 0 1]; %状态转移矩阵  
Q=[0.0001, 0; 0 0.0001]; %状态转移协方差矩阵  
H=[1 0]; %观測矩阵  
R=1; %观測噪声方差  
  
figure;  
hold on;  
  
for i=1:num  
  
  ## predict
  X_ = F*X;
  Sigma_ = F*Sigma*F'+Q;
  
  ## update
  K = Sigma_*H'/(H*Sigma_*H'+R);
  X = X_+K*(Z(i)-H*X_);
  Sigma = (eye(2)-K*H)*Sigma_;
  
  plot(X(1), X(2), '.','MarkerSize',10); %画点，横轴表示位置。纵轴表示速度
end


plot([0,num],[1,1],'r-');