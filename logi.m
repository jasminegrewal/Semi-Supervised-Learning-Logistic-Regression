function theta = logi(x,y)

m = length(y);             %length of y vector (with class labels)
theta = zeros(size(x(1,:)))'; %taking theta values zero and transposing
MAX = 2000;           %number of iterations
alpha = 0.000001;

for n =1:MAX
    %calculating sigmoid function
    hyp=x*theta;
    g = 1 ./(1+exp(-hyp));
    
    %calculating theta using stochastic gradient descent
    for i = 1:m
        p = (y(i)-g(i))*x(i,:)';
        theta = theta + ((alpha) * p);
    end
   
    %checking cost to keep track of right direction
    cost = (-1/m) * sum( y .* log(g) + (1 - y) .* log(1 - g) );
    %disp(cost)
end


end