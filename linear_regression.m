x = [1,2,2.5,2.1,2,3.1,3.5,1,18,19,21,22,23,24,25,26]'
y = [-10,-10,-10,-10,-10,-10,-10,-10,10,10,10,10,10,10,10,10]'

function plotData(x,y)
  plot(x,y,'rx','MarkerSize',8);
end

plotData(x,y)

# Count how many data points we have
m = length(x);
# Add a column of all ones (intercept term) to x
X = [ones(m, 1) x];

# Calculate theta
theta = (pinv(X'*X))*X'*y

# Plot the fitted equation we got from the regression
hold on; # this keeps our previous plot of the training data visible
plot(X(:,2), X*theta, '-')
legend('Training data', 'Linear regression')


tx = [9]
TX = [ones(length(tx), 1) tx]
TY = TX*theta

plot(TX(:,2), TY, 'x')

hold off # Don't put any more plots on this figure