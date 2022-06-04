% witten by HoangTN

function [fitness,U] = FCM(center,df,d,c)


n = size(df,1);
m = 2;
D = zeros(c,n); % ma tran khoang cach
U = zeros(c,n); % ma tran ham thuoc

max_iter = 2; % tuy theo yeu cau bai toan
min_impro = 1e-5;
npo = [];

    
    cent = reshape(center, d,c)';
    
        for i=1:c
            for j=1:n
                D(i,j)=pdist([cent(i,:); df(j,:)],'euclidean');
        
            end
        end
        rev_distmx_initial=1./D;

        rev_dmsq_initial=rev_distmx_initial.^(2/(m-1));
        for j=1:n
            sum2=sum(rev_dmsq_initial(:,j),1);
    
            for i=1:c
                U(i,j)=rev_dmsq_initial(i,j)/sum2;
            end
        end

        tmp = U.^2;

        % tinh ham chi phi
        D2 = D.^2;
        J = sum(sum(tmp.*D2));
        fitness=1/J;
        

   
