## test
load w.mat
x

num_positive = 100
## load samples
Tests = [];
Results = [];
### positive samples
for i = 1:num_positive
  f = strcat("data/samples/test4-i/vec-desc-", num2str(i - 1));
  vd = textread (f, "%f", 100);
  Tests(i ,:) = vd';
endfor

sum = 0;
for i = 1:num_positive
  t1 = [Tests(i,:),1];
  y1 = t1 * x;
  Results(i) = y1;
  sum = sum + y1;
endfor
avg = sum / num_positive
var = 0;
for i = 1:num_positive
  var = var + realpow(Results(i) - avg, 2);
endfor

var = var / num_positive

sorted = sort(Results, "descend");

bar(1:num_positive, sorted)