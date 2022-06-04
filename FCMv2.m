% witten by HoangTN

function [centers, fit, U] = FCMv2(cent,df,d,c)

% N = size(po,1);
n = size(df,1);
m = 2;
D = zeros(c,n); % ma tran khoang cach
U = zeros(c,n); % ma tran ham thuoc

max_iter = 2; % tuy theo yeu cau bai toan
min_impro = 1e-5;
npo = [];

 
    cent = reshape(cent, d,c)';
    
    for s = 1:max_iter
    
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

        if s==2
            % tinh ham chi phi
            D2 = D.^2;
            J = sum(sum(tmp.*D2));
            fit = 1/J;
            break;
        end

        % cap nhat tam
        cent=tmp*df;
        for i=1:c
            sum1=sum(tmp(i,:),2);
            cent(i,:)=cent(i,:)./sum1;
        end

    end
    
    centers = reshape(cent', 1, d*c);