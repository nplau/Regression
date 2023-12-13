function saturation (data)

  % Load data
  x = data(:,1);
  y = data(:,2);
  n = length(x);

  % Find a0 and a1
  recipX = 1 ./ x;
  recipY = 1 ./ y;
  
  % a1 = (n * sum of (recipX .* recipY) - sum of recipX * sum of recipY) / (n * sum of (recipX .^ 2) - (sum of recipX) ^ 2)
  % a0 = sum of recipY / n - a1 * sum of recipX / n
  a1 = (n * sum(recipX .* recipY) - sum(recipX) * sum(recipY)) / (n * sum(recipX .^ 2) - (sum(recipX)) ^ 2);
  a0 = sum(recipY) / n - a1 * sum(recipX) / n;

  % Find a and b
  a = 1 / a0;
  b = a * a1;

  % Find the regression line
  x_reg = linspace(min(x), max(x), 100);
  y_reg = a * x_reg ./ (b + x_reg);

  % Calculate R^2
  y_res = a * x ./ (b + x);
  r2 = (sum((y - mean(y)).^2) - sum((y - y_res).^2)) / sum((y - mean(y)).^2);

  % Plot
  % Scatter plot the data
  scatter(x, y, 'filled', 'MarkerFaceColor', 'blue');
  hold on;

  % Draw the exponential regression fit
  plot(x_reg, y_reg, 'r-');
  hold off;

  % Label the graph
  legend('Data', 'Saturation Fit');
  title('Saturation Fit');
  xlabel('x');
  ylabel('y');

  % Put function and R^2 value in the graph
  model = sprintf('y = (%fx) / (%f+x)', a, b);
  r2 = sprintf('R^2 = %f', r2);

  text(0.05, 0.95, model, 'Units', 'normalized');
  text(0.05, 0.9, r2, 'Units', 'normalized');
end