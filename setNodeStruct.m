function node = setNodeStruct(in)
% first 2 dimension of node matrix stands for location
% third dimension is for storing extra information
% 1-8 for linkCost
% 9 for pixel information

[X, Y, RGB] = size(in);
in = double(in);
node = zeros(X, Y, 8);

%node(:,:,9)= sum(in(:,:,:),3)/RGB;

%=================== Assign D(link) =================== 
% Notice that now D(link) is stored in linkCost
for i = 1:X
    for j = 1:Y
        if j-1>=1 && i+1<=X           % 1
            cost=zeros(RGB,1);
            cost(1:RGB)=abs(in(i+1,j,:)-in(i,j-1,:))/sqrt(2);
            node(i,j,1)=sqrt(cost'*cost/RGB);
        end
        
        if i-1>=1 && j-1>=1 && i+1<=X % 2
            cost=zeros(RGB,1);
            cost(1:RGB)=abs((in(i-1,j,:)+in(i-1,j-1,:))/2-(in(i+1,j,:)+in(i+1,j-1,:))/2)/2;
            node(i,j,2)=sqrt(cost'*cost/RGB);
        end
        
        if i-1>=1 && j-1>=1           % 3
            cost=zeros(RGB,1);
            cost(1:RGB)=abs(in(i-1,j,:)-in(i,j-1,:))/sqrt(2);
            node(i,j,3)=sqrt(cost'*cost/RGB);
        end
        
        if i-1>=1 && j-1>=1 && j+1<=Y % 4
            cost=zeros(RGB,1);
            cost(1:RGB)=abs((in(i-1,j-1,:)+in(i,j-1,:))/2-(in(i-1,j+1,:)+in(i,j+1,:))/2)/2;
            node(i,j,4)=sqrt(cost'*cost/RGB);
        end
        
        if i-1>=1 && j+1<=Y           % 5
            cost=zeros(RGB,1);
            cost(1:RGB)=abs(in(i-1,j,:)-in(i,j+1,:))/sqrt(2);
            node(i,j,5)=sqrt(cost'*cost/RGB);
        end
        
        if i-1>=1 && j+1<=Y && i+1<=X % 6
            cost=zeros(RGB,1);
            cost(1:RGB)=abs((in(i-1,j,:)+in(i-1,j+1,:))/2-(in(i+1,j,:)+in(i+1,j+1,:))/2)/2;
            node(i,j,6)=sqrt(cost'*cost/RGB);
        end
        
        if i+1<=X && j+1<=Y           % 7
            cost=zeros(RGB,1);
            cost(1:RGB)=abs(in(i+1,j,:)-in(i,j+1,:))/sqrt(2);
            node(i,j,7)=sqrt(cost'*cost/RGB);
        end
        
        if i+1<=X && j-1>=1 && j+1<=Y % 8
            cost=zeros(RGB,1);
            cost(1:RGB)=abs((in(i,j-1,:)+in(i+1,j-1,:))/2-(in(i,j+1,:)+in(i+1,j+1,:))/2)/2;
            node(i,j,8)=sqrt(cost'*cost/RGB);
        end
    end
end

%=================== Find maxD ===================
maxD = 0;
for i = 1:X
    for j = 1:Y
        for k = 1:8
            if node(i,j,k)>maxD
                maxD=node(i,j,k);
            end
        end
    end
end

%=================== Calculate cost(link) ===================
for i = 1:X
    for j = 1:Y
        for k = 1:8
            if mod(k,2)==0
                node(i,j,k)=maxD-node(i,j,k);
            else
                node(i,j,k)=(maxD-node(i,j,k))*sqrt(2);
            end
        end
    end
end

end