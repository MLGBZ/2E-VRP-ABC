function [a] = cow(n,k) %�������Ⱦɫ��
a = zeros(1,n+k+1);
a(1,:) = [0,randperm(n+k+1-2),0];%��֤����0��ͷ�ͽ�β��
for i = 1:k-1
    b = find(a(1,:)==n+i);
    a(1,b) = 0;
end
end