
% Steps
% 1. Declare/Initialize Variables 
% 2. Do forward elimination by going through each row and column until you reach all 0s below the diagonal
% 3. Do backward substitution to get each x value
% 4. Print out the solution vector

function matrix_solve(A, B)

    % Forward Elimination
    dim1 = size(A, 1);
    dim2 = size(A, 2);

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
        sum = 0;
        for j = i+1:dim1
            sum = sum + (A(i,j)*B(j)); % Move all the knowns to the b vector and add it all up
        end
        B(i) = (B(i) - sum) / A(i,i); % Divide by the unknown x coefficient to find x
    end

    a = B;
    
end
