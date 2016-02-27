filename = 'labeled_data.xlsx';     %reading the file with labeled data
h = xlsread(filename,'A:A');        %reading height, weight and age of training data
w = xlsread(filename,'B:B');
a = xlsread(filename,'C:C');
x = [h w a];
y = xlsread(filename,'D:D');

m = length(y);
x0=ones(m,1);       %adding first column of ones
x = [x0,x];

finaltheta=logi(x,y);            % calling logistic classifier to run on the labeled data i.e Ds
disp('theta with labeled data')
disp(finaltheta)                 % will display the theta values for Ds

file2='unlab_data.xlsx';          %reading the file containg unlabeled data
h1 = xlsread(file2,'A:A');        %reading height, weight and age of training data
w1 = xlsread(file2,'B:B');
a1 = xlsread(file2,'C:C');
ul = [h1 w1 a1];
num=size(ul,1);
ul0=ones(num,1);          % adding column of ones
ul=[ul0,ul];
for k=1:3                 % loop for different thresholds on the probability calulated for unlabeled data 
                          % i.e first add data with probabaility more than
                          % 0.75 to M class and less than 0.25 to W and
                          % so on
                          
    num=size(ul,1);       %number of rows left in unlabeled data to control the loop for calulating probability
    if(num ~= 0)          % continue if data is left in unlabeled matrix
        s=[];             % to keep track of data which has been added to labeled matrix
        
        for i=1:num       %loop on unlabeled data
            predict = ul([i],:) *finaltheta;   %predict probability
            g1 = 1 ./(1+exp(-predict));
            %disp(g1)
            if k==1                          %check the threshold value and correspondingly add to labeled matrix
                if g1>0.75 | g1 == 0.75
                    disp('adding to Male class as probability is >=0.75')
                    disp(ul([i],:))            
                    x=[x;ul([i],:)];
                    y=[y;1];
                    s=[s,i];
                %ul([i],:)=[];
            
                elseif g1<0.25 | g1 == 0.25
                    disp('adding to FeMale class as probability is <=0.2')
                    disp(ul([i],:))                 
                    x=[x;ul([i],:)];
                    y=[y;0];
                    s=[s,i];
                end
            elseif k==2
                if g1>0.6 | g1 == 0.6
                    disp('adding to Male class as probability is >=0.6')
                    disp(ul([i],:))
                    x=[x;ul([i],:)];
                    y=[y;1];
                    s=[s,i];
                elseif g1<0.4 | g1 == 0.4
                    disp('adding to FeMale class as probability is <=0.4')
                    disp(ul([i],:))                    
                    x=[x;ul([i],:)];
                    y=[y;0];
                    s=[s,i];
                
                end
            elseif k==3
                if g1>0.5 | g1==0.5
                    disp('adding to Male class as probability is >=0.5')
                    disp(ul([i],:))
                    x=[x;ul([i],:)];
                    y=[y;1];
                    s=[s,i];
                elseif g1<0.5
                    disp('adding to FeMale class as probability is <=0.5')
                    disp(ul([i],:))
                    x=[x;ul([i],:)];
                    y=[y;0];
                    s=[s,i];
                end            
            end
        end
        disp('train logistic classifier with new values')
        finaltheta=logi(x,y);         % after some data has been moved from unlabeled to labeled, 
                                      %call the logistic classifier again
        ul([s],:)=[];                 %remove that data from unlabeled data-matrix
    end
end
disp('theta after all unlabeled data has been labeled')
disp(finaltheta)                      % theta after all data has been added to labeled matrix






 
