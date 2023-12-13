load test1.txt
load test2.txt

test_sample = input("Choose the test sample (1 or 2): ");

if test_sample == 1
    test = test1;
else
    test = test2;
end

fprintf("1. Polynomial \n2. Exponential \n3. Saturation \n");
choice = input("Choose your regression model (pick a number): ");

if choice == 1 
    degree = input("Choose the degree of the polynomial: ");
    polynomial (test, degree);
end

if choice == 2
    exponential(test);
end

if choice == 3  
    saturation (test);
end