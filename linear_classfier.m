## min(c*x) s.t. A*x<=b 

##
##      (y)|c c c c| |a1|    |1|
## min  (y)|c c c c| |a2| <= |1|
##      (y)|c c c c| |a3|    |1|
##         |1 1 1 1| |b |    |1|
##                   
##
##  min 0.5 x'*H*x + x'*q
##
##  A*x = b
##  lb <= x <= ub
##  A_lb <= A_in*x <= A_ub
##  qp(H,q,A,b)
##  
## For data format changing, replace ',' to ' '
## cd ./data/samples
## ls |xargs sed -i "s/,/ /g"

read_data = 1
num_positive = 200
num_negative = 200
Samples = []
Labels = []
if (read_data == 1)
  ## load samples
  Samples = [];

  ### positive samples
  for i = 1:num_positive
    f = strcat("data/samples/test-dnn/vec-desc-", num2str(i - 1));
    vd = textread (f, "%f", 100);
    Samples(i ,:) = vd';
    Labels(i) = 1;
  endfor

  ### negative samples
  for i = 1:num_negative
    f = strcat("data/samples/test-dnn/vec-desc-ivt-", num2str(i - 1));
    vd = textread (f, "%f", 100);
    Samples(i + num_positive,:) = vd';
    Labels(i + num_positive) = -1;
  endfor
else
Samples = [
  1, 2;
  2, 2;
  3, 2;
  6, 4;
  7, 4;
  
  1, 4;
  2, 4;
  3, 4;
  6, 2;
  7, 2;
];

Labels = [
  1,
  1,
  1,
  1,
  1,
  -1,
  -1,
  -1,
  -1,
  -1
];
endif

sl = num_positive + num_negative;
sd = length(Samples(1, :));

H= eye(sd + 1);

q = zeros(sd + 1, 1);

A_in = [];
A_ub = -1 * ones(sl, 1);

for i = 1:sl
  A_in(i, :) = [[Samples(i, :)], 1] * (-1) * Labels(i);
endfor

#qp (x0, H, q, A, b, lb, ub, A_lb, A_in, A_ub)
#[X, OBJ, INFO, LAMBDA] = qp([], H,f, [], [], lb, [], [], A, b) 
[x, obj, info, lambda] = qp([], H, q, [], [], [], [], [], A_in, A_ub)

save w.mat x


##printf(ytest);

dbg_show = 0
if (dbg_show == 1)
  for i = 1:sl
    if (Labels(i) == 1)
      plot(Samples(i, 1), Samples(i, 2), 'x');
      hold on;
    else
      plot(Samples(i, 1), Samples(i, 2), 'o');
      hold on;
    endif   
  endfor
  hold on;

  theta = -x(1) / x(2)
  beta = -x(3) / x(2)

  xt = 0:1:30
  plot(xt, xt*theta + beta, '-') 
  hold off;
endif

