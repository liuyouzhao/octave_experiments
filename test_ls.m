## test
load w.mat
x
A = x 

load AB.mat
x

 ## load samples
global f = [];

x1 = [];
x2 = [];

num_positive = 100
num_negative = 100
bars = []
### positive samples
for i = 1:num_positive
  file = strcat("data/samples/test-dnn-t/vec-desc-", num2str(i - 1));
  x1 = textread (file, "%f", 100);
  x1 = [x1', 1]
  f(i) = A' * x1'
  bars(i) = f(i);
endfor

### negative samples
for i = 1:num_negative
  file = strcat("data/samples/test-dnn-n/vec-desc-", num2str(i - 1));
  x2 = textread (file, "%f", 100);
  x2 = [x2', 1]
  f(i + num_positive) = A' * x2'
  bars(i + num_positive) = f(i + num_positive);
endfor

lines = []

for i = 1:num_positive
  reg = x' * [f(i), 1]';
 
  rate = 1 / (1 + exp(reg))
  lines(i) = rate;
  hold on;
endfor

for i = 1:num_negative
  reg = x' * [f(i + num_positive), 1]'
  
  rate = 1 / (1 + exp(reg))
  lines(i + num_positive) = rate;
  hold on;
endfor

lines

plot(1:1:(num_negative + num_positive), lines);
#hold off;

#bar(1:1:(num_negative + num_positive), bars);

