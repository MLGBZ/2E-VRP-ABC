function [cur_pool,result_des] = destory(result,q)
    %1.���ȡ��q���ͻ������Ƴ�����1��0,11����0Ҳ�����Ƴ���,�Ƴ�ʱ���մ�С���С��˳���Ƴ�����Ϊ���ܻ��Ҳ���Ŀ�꣬����ȷ�������Ƴ����һ��
    %����������� 14,14�����ܻ��Ƴ����һ��0��
    %������ȷ������ÿ�θ��ݵ�ǰ�Ľ�ĳ������ɡ�2��len-1�������������������
    %q = 3;
    len = size(result,2);
   % rand_M = randi([2,len-1],1,q);
    result_des= result;
  %  rand_M = sort(rand_M,'descend');
    cur_pool = zeros(1,q);
    for i = 1:q
        loc  = randi([2,len-1],1,1);%ÿ��ֻ���ɡ�2��len-1��֮���һ��ֵ�����Ա�֤���˵�0���ᱻ�Ƴ�
        cur_pool(i) = result_des(1,loc);
        result_des(:,loc)=[];%�Ƴ�
        len = len-1;%ÿ�Ƴ�һ���ͻ��ⳤ�ȼ�һ
    end;
end