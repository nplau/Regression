function exponential(data)
  % Load data
  x = data(:,1);
  y = data(:,2);
  n = length(x);

  % Calculate a1 and a0
  % a1 = n * sum of (x * ln(y)) - sum of (x) * sum of (log(y) all divided by n * sum of (x^2) - (sum of (x))^2
  % a0 = sum of (log(y)) - a1 * sum of (x) all divided by n
  a1 = (n * sum(x .* log(y)) - sum(x) * sum(log(y))) / (n * sum(x .^ 2) - (sum(x)) ^ 2);
  a0 = (sum(log(y)) - a1 * sum(x)) / n;

  % Calculate a and b
  % a = e^(a0)
  % b = a1
  a = exp(a0);
  b = a1;

  % Calculate y
  x_reg = linspace(min(x), max(x), 100);
  y_reg = a * exp(b * x_reg);

  % Calculate R^2
  y_res = a * exp(b * x);
  r2 = (sum((y - mean(y)).^2) - sum((y - y_res).^2)) / sum((y - mean(y)).^2);

  % Plot
  % Scatter plot the data
  scatter(x, y, 'filled', 'MarkerFaceColor', 'blue');
  hold on;

  % Draw the exponential regression fit
  plot(x_reg, y_reg, 'r-');
  hold off;

  % Label the graph
  legend('Data', 'Exponential Fit');
  title('Exponential Fit');
  xlabel('x');
  ylabel('y');

  % Put function and R^2 value in the graph
  model = sprintf('y = %f e^{%fx}', a, b);
  r2 = sprintf('R^2 = %f', r2);

  text(0.05, 0.95, model, 'Units', 'normalized');
  text(0.05, 0.9, r2, 'Units', 'normalized');
  
end