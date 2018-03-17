a = 1/sqrt(2*3.1415926)
u = 0;
  
function ret = _gaussian (a, u, x)
  ret = 1/(sqrt(2*3.1415926) * a) * exp(-(x-u)^2/(2*a));
endfunction

x = -5:0.1:5;
y = [];
for i = 1:length(x)
  y(i) = 1/(sqrt(2*3.1415926) * a) * exp(-(x(i)-u)^2/(2*a));
endfor

plot(x, y, "-k");
hold on;

a = 1;
u = 0;
for i = 1:length(x)
  y(i) = 1/(sqrt(2*3.1415926) * a) * exp(-(x(i)-u)^2/(2*a));
endfor
plot(x, y, "-r");
hold on;


a = 0.25;
u = 0;
max = 1/(sqrt(2*3.1415926) * a) * exp(0);
for i = 1:length(x)
  y(i) = 1/(sqrt(2*3.1415926) * a) * exp(-(x(i)-u)^2/(2*a));
  #y(i) /= max;
endfor
plot(x, y, "-b");
hold on;

a = 3;
u = 0;
max = 1/(sqrt(2*3.1415926) * a) * exp(0);
for i = 1:length(x)
  y(i) = 1/(sqrt(2*3.1415926) * a) * exp(-(x(i)-u)^2/(2*a));
  y(i) /= max;
endfor
plot(x, y, "-m");
hold on;