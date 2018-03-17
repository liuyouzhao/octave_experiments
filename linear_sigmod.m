## test
load w.mat
x
A = x 

 ## load samples
global t = [];
global f = [];

global x1;
global x2;

global num_positive = 50
global num_negative = 50

### positive samples
for i = 1:num_positive
  file = strcat("data/samples/test-dnn/vec-desc-", num2str(i - 1));
  x1 = textread (file, "%f", 100);
  x1 = [x1', 1];
  t(i) = (num_positive + 1) / (num_positive + 2);
  f(i) = A' * x1';
endfor

### negative samples
for i = 1:num_negative
  file = strcat("data/samples/test-dnn/vec-desc-ivt-", num2str(i - 1));
  x2 = textread (file, "%f", 100);
  x2 = [x2', 1];
  t(i + num_positive) = 1 / (num_negative + 2);
  f(i + num_positive) = A' * x2';
endfor

## x = |A|
##     |B|
## cross-entropy error function
function obj = cee (x)
  global t;
  global f;

  global num_positive;
  global num_negative;

  error = 0;
  for i = 1 : (num_positive + num_negative)
    p = 1 / (1 + exp (x' * [f(i), 1]'));
    p1 = log(p);
    p2 = log(1-p);
    t1 = t(i);
    t2 = 1 - t(i);
    q = (t1 * p1 + t2 * p2);
    error -= q;
  endfor
  obj = error
endfunction

function r = g (x)
  r = 0 * x;
endfunction

function r2 = h (x)
  m = x(1,1) * x(2,1);
  r2 = ones(1,1);
  r2(1,1) = m;
endfunction

x0 = [-1.8; 1.7;];
[x, obj, info, iter, nf, lambda] = sqp (x0, @cee, @g)


save AB.mat x

for i = 1:num_positive
  reg = x' * [f(i), 1]';
  rate = 1 / (1 + exp(reg))
  plot(i, rate, 'x');
  hold on;
endfor

for i = 1:num_negative
  reg = x' * [f(i + num_positive), 1]';
  rate = 1 / (1 + exp(reg))
  plot(i + num_positive, rate, 'o');
  hold on;
endfor
hold off;


## result
## x =
## -0.97971
## -0.27920
  