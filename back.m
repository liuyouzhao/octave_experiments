## test
load w.mat
x;
A = x;

 ## load samples
global t = [];
global F = [];

global x1;
global x2;

global num_positive = 10
global num_negative = 10

### positive samples
for i = 1:num_positive
  file = strcat("data/samples/test2/vec-desc", num2str(i - 1));
  x1 = textread (file, "%f", 100);
  x1 = [x1', 1];
  t(i) = (num_positive + 1) / (num_positive + 2);
  F(i ,:) = x1;
endfor

### negative samples
for i = 1:num_negative
  file = strcat("data/samples/test2/vec-desc-ivt", num2str(i - 1));
  x2 = textread (file, "%f", 100);
  x2 = [x2', 1];
  t(i + num_positive) = 1 / (num_negative + 2);
  F(i + num_positive,:) = x2;
endfor

## x = |A|
##     |B|
## cross-entropy error function
function obj = cee (x)
  global t;
  global F;

  global num_positive;
  global num_negative;

  sigma = 0;
  for i = 1 : (num_positive + num_negative)
    p = 1 / (1 + exp (x' * F(i,:)'));
    sigma += t(i)*log(p) + (1-t(i))*(1-log(p));
  endfor
  obj = -sigma;
endfunction

function r = g (x)
  r = 0 * x;
endfunction

F
F(1, :)
sd = length(F(1, :));
x0 = zeros(sd, 1);

[x, obj, info, iter, nf, lambda] = sqp (x0, @cee, @g, [])

for i = 1:num_positive
  reg = x' * F(i ,:)';
  rate = 1 / (1 + exp(reg))
endfor

for i = 1:num_negative
  reg = x' * F(i + num_positive ,:)';
  rate = 1 / (1 + exp(reg))
endfor