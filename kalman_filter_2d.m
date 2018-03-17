
num=200;
e = 20;
Z = [];
Zr = [];

## load data
_Z = textread ("data/samples/points_track", "%f", num*2);
len = length(_Z);
_Z = _Z';
for i = 1:num
  Z(i, 1) = _Z((i-1) * 2 + 1) + randn(1)*e;
  Z(i, 2) = _Z((i-1) * 2 + 2) + randn(1)*e;
  Zr(i, 1) = _Z((i-1) * 2 + 1);
  Zr(i, 2) = _Z((i-1) * 2 + 2);
    #if (i < 50)
    #  Z(i,1)=i + randn(1)*e;
    #  Z(i,2)=5 + randn(1)*e;
    #endif
    #if (50 < i < 100)
    #  Z(i,1)=i + randn(1)*e;
    #  Z(i,2)=i + randn(1)*e;
    #endif
endfor
  
X=[0 0; 0 0]; %状态  
Sigma = [1 0; 0 1]; %状态协方差矩阵  
F=[1 1; 0 1]; %状态转移矩阵  
Q=[0.0001, 0; 0 0.0001]; %状态转移协方差矩阵  
H=[1 0]; %观測矩阵  
R=1; %观測噪声方差  
  
figure;  
hold on;  

for i=1:num
  plot(Z(i,1), Z(i,2), 'x');
  hold on;  
end

hold on;

for i=1:num
  plot(Zr(i,1), Zr(i,2), 'o');
  hold on;  
end
hold on;  

for i=1:num  
  
  ## predict
  X_ = F*X;
  
  X_
            #4x4      #4x4
  Sigma_ = F*Sigma*F'+Q;
  Sigma_
  
  ## update        
  K = Sigma_*H'/(H*Sigma_*H'+R);
  #K*(Z(i)-H*X_)
  #2x1
  K
  #1x2
  Z(i,:)
  d = (Z(i,:)-H*X_)
  #2x2
  dx_ = K * d
  
  X = X_ + dx_;
  X
  Sigma = (eye(2)-K*H)*Sigma_;
  Sigma
  
  plot(X(1,1), X(1,2), '.','MarkerSize',10); %画点，横轴表示位置。纵轴表示速度
end


#plot([0,num],[1,1],'r-');