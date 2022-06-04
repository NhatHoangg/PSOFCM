function U=test(c,center,df)

n = size(df,1);
m = 2;
D = zeros(c,n); % ma tran khoang cach
U = zeros(c,n); % ma tran ham thuoc


min_impro = 1e-7;
npo = [];

    
        for i=1:c
            for j=1:n
                D(i,j)=pdist([center(i,:); df(j,:)],'euclidean');
        
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
    
