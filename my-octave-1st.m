fx = []
for i = 1:21
  fx(i) = i - 11
endfor
fy = [0,0,0,1,1,0,0,-1,0,0,-2,-2,-4,-4,-4,-3,-2,-2,1,2,2,3,3,3,-2,2,2,0,0,3,0,0,0,-1,0,0,0,0,0,-1,1,1,1,1,1,-1,-3,-3,-3,0,0,0,0,0,0,1,2,1,0,0,1,1,1,1,0,0,0,1,0,0,1,0,-3,1,0,1,1,-1,-1,-2,-2,0,0]
sum = []
for s = 1:21
  sum(s) = 0
endfor
for y = fy
  sum(y + 11) = sum(y + 11) + 1
endfor

for s = sum
  s = s / 10
endfor

disp(fx)
disp(sum)

bar (fx, sum, 0.8);

xlabel ("offsets");
ylabel ("integrate");
daspect ("manual");
xlim([-10,10]);
#axis("square")