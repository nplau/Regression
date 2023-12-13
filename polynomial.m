function polynomial(data, degree)
  % Load data 
  x = data(:,1);
  y = data(:,2);
  n = length(x);
  
  %initializing arrays that will hold the sum of the xi values
  sum_x = zeros(degree*2);
  sum_xy = zeros(degree+1);
  
  % Getting the xi values depending on the degree of the polynomial
  for i=2:(degree*2)+1
      sum_x(i) = sum(x.^(i-1));    % hold an array of xi of different degrees
  end
  
  sum_x(1) = n;    % [1,1] of the matrix
  
  % Getting xiyi values depending on the degree of the polynomial 
  for i = 0: degree
      for j = 1: n
         sum_xy(i+1) = sum_xy(i+1) + (x(j)^i)*(y(j));
      end
  end

  y_not = sum_xy(1)/n;
  
  % Setting up and Calculating the system of equations to solve for ai
  
  size = degree +1;  % the size of the matrix 
  A = zeros(size, size);   % creating an empty matrix of the desired size based on the degree number
  B = zeros(size, 1);
      
  for i = 1: size
      for j = 1: size
          A(i, j) = sum_x(j+i-1);
      end
  end
  
  for i = 1: size
      B(i, 1) = sum_xy(i);
  end
  
  % Solving the matrix
   % Forward Elimination
    dim1 = degree +1;
    dim2 = degree +1;

    for i = 1:(dim1-1)
        for j = i+1:dim1
            mul_a = A(j,i) * A(i,:); % Constant of Row n (current column) * Row n-1
            mul_b = A(j,i) * B(i,:); % Same as mul_a but changing the b vector values

            A(j,:) = A(j,:) - mul_a / A(i,i); % Row n - (mul_a / Row n (diagonal value))
            B(j) = B(j) - mul_b / A(i,i); % Same as mul_a but changing the b vector values
        end
    end


    % Backward Substitution
    B(dim1) = B(dim1) / A(dim1, dim2); % solve the very last variable
    for i = dim1-1:-1:1
        sum1 = 0;
        for j = i+1:dim1
            sum1 = sum1 + (A(i,j)*B(j)); % Move all the knowns to the b vector and add it all up
        end
        B(i) = (B(i) - sum1) / A(i,i); % Divide by the unknown x coefficient to find x
    end
  
  % Concatenating the equation for the regression model
  y_reg = 0;
  
  for i = 1:degree+1
    y_reg = y_reg + B(i)*(x.^(i-1));
  end
  
  
  
  % Initializing the two sum values required to calculate R^2
  St = 0;
  Sr = 0;
  
  
  % Calculating Sr and St 
  for i = 1: n
      
     y_y = y(i) - y_not;
     e = y(i);
     
     for j = 1: degree+1
        e = e - B(j)*(x(i)^(j-1));
     end
        
     St = St + y_y^2;
     Sr = Sr + e^2;
  end
  
  %Calculate R^2
  R2 = (St - Sr)/St;
 
  % Plot
  % Scatter plot the data
  scatter(x, y, 'filled', 'MarkerFaceColor', 'blue');
  hold on;

  % Draw the exponential regression fit
  plot(x, y_reg, 'r-');
  hold off;

  % Label the graph
  title_label = sprintf('Polynomial Fit Degree %f', degree);
  legend('Data', 'Polynomial Fit');
  title(title_label);
  xlabel('x');
  ylabel('y');
  
  % Print y regression equation
  
  y_print = B(1);
  
  for i = 1: degree
      if (B(i+1) > 0)
          y_print = y_print + "+" + B(i+1) +"x^"+(i);
      elseif (B(i+1)< 0)
          y_print = y_print + "" + B(i+1) +"x^"+(i);
      end
  end
  
  text(0.05, 0.95, "y = " + y_print, 'Units', 'normalized');
  
  % Print R^2 equation
  r2 = sprintf('R^2 = %f', R2);
  text(0.05, 0.9, r2, 'Units', 'normalized');

end