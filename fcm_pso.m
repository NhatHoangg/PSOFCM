clc
clear all
close all
% fcm- pso
%[133]-2016

%% parameter
n=100; % number of records
%d=19; % number of dimension
c=5; % number of cluster
N=50; %population
max_iteration=20;
w = 0.8; % he so quan tinh

c1 = 2; % he so gia toc
c2 = 2; 
VarMin =  -50;  % Lower Bound of Decision Variables
VarMax =  50;
MaxVelocity = 0.2*(VarMax-VarMin);
MinVelocity = -MaxVelocity;
%create data
%data=randi([-50 50],n,d);
data=readtable('X_train.csv');
data = table2array(data);

d=size(data,2);



%% khoi tao ca the
particle.position=[]; %vi tri
particle.velocity=[]; % van toc
particle.fitness=[];
particle.pbest_pos=[];
particle.U=[];
particle.pbest_fitness=0;
pop=repmat(particle,N,1);


Gbest.position=[];
Gbest.fitness=0;
Gbest.U=[];

for i=1:N
    % pop(i).position=randi([-50,50],1,d*c);
    pop(i).position=unifrnd(-50,50,1,d*c);
    pop(i).velocity=zeros(1,d*c);
    [ pop(i).fitness pop(i).U]=FCM(pop(i).position,data,d,c);
    if pop(i).fitness>pop(i).pbest_fitness
        pop(i).pbest_fitness=pop(i).fitness;
        pop(i).pbest_pos=pop(i).position;
    end
    if pop(i).fitness>Gbest.fitness
        Gbest.fitness=pop(i).fitness;
        Gbest.position=pop(i).position;
        Gbest.U=pop(i).U;
    end
end

for r=1:max_iteration
    r
    
    for j=1:N
        pop(j).velocity=w*pop(j).velocity+ c1*rand(1,d*c).*(pop(j).pbest_pos-pop(j).position) + c2*rand(1,d*c).*(Gbest.position-pop(j).position);
        % Apply Velocity Limits
        pop(j).velocity = max(pop(j).velocity, MinVelocity);
        pop(j).velocity = min(pop(j).velocity, MaxVelocity);
        
        pop(j).position=pop(j).position+pop(j).velocity;
        % Apply Lower and Upper Bound Limits
        pop(j).position = max(pop(j).position, VarMin);
        pop(j).position = min(pop(j).position, VarMax);
        
        [pop(j).position pop(j).fitness pop(j).U]=FCMv2(pop(j).position,data,d,c);
        
        if pop(j).fitness>pop(j).pbest_fitness
            pop(j).pbest_fitness=pop(j).fitness;
            pop(j).pbest_pos=pop(j).position;
        end
        if pop(j).fitness>Gbest.fitness
            Gbest.fitness=pop(j).fitness;
            Gbest.position=pop(j).position;
            Gbest.U=pop(j).U;
        end
    end
    best_fitness(r)=Gbest.fitness;
    
end

out_pop=[];
for i=1:N
    out_pop=[out_pop;pop(i).position];
end

U_train=Gbest.U;
save U_train.csv U_train -ascii;
best_center = reshape(Gbest.position,d,c)';

data_test=readtable('X_test.csv');
data_test=table2array(data_test);
U_test=Convert_data(data_test,best_center);
save U_test.csv U_test -ascii;





