function result_rec =destory_recover_lay2(result,coord_sat,demand,s2d_dist,c2s_dist,c2c_dist,s2s_dist,fleet)
    %%----------------------�ƻ����޸�----------------
%     %1.���ȡ��q���ͻ������Ƴ�����1��0,11����0Ҳ�����Ƴ���,�Ƴ�ʱ���մ�С���С��˳���Ƴ�����Ϊ���ܻ��Ҳ���Ŀ�꣬����ȷ�������Ƴ����һ��
%     %����������� 14,14�����ܻ��Ƴ����һ��0��
%     %������ȷ������ÿ�θ��ݵ�ǰ�Ľ�ĳ������ɡ�2��len-1�������������������
%     %2.���ͻ�����ȥ���뵽��1~len����λ���ϣ����������ˣ���fitnessֵ��С��λ�ã����в���
      q = 4;
     % len = size(result,2);
%    % rand_M = randi([2,len-1],1,q);
%     result_des= result;
%   %  rand_M = sort(rand_M,'descend');
%     cur_pool = zeros(1,q);
%     for i = 1:q
%         loc  = randi([2,len-1],1,1);%ÿ��ֻ���ɡ�2��len-1��֮���һ��ֵ�����Ա�֤���˵�0���ᱻ�Ƴ�
%         cur_pool(i) = result_des(1,loc)
%         result_des(:,loc)=[];%�Ƴ�
%         len = len-1;%ÿ�Ƴ�һ���ͻ��ⳤ�ȼ�һ
%     end;
    [cur_pool,result_des] = destory(result,q);
    result_rec=recovery(result_des,cur_pool,fleet,demand,c2s_dist,c2c_dist);
    
%     %------------------̰�Ļָ��׶�------------------%
%     for i = 1:q
%        cur_idx = cur_pool(i);
%        fitness_pool =zeros(1,len_new-1); %����ÿ��λ�ò�������Ӧֵ
%        for j = 1:len_new-1
%            result_j = [result_des(1,1:j),cur_idx,result_des(1,j+1:end)];
%            fitness_pool(j) = fitnesslay2(result_j,fleet(2,1),demand,c2s_dist,c2c_dist);
%        end
%        minval = min(fitness_pool);
%        %%idj�п�����һ������
%        idj = find(fitness_pool == minval);
%        if(size(idj,2)>1)
%            idj = idj(1);
%        end
%        result_des(1,1:idj);
%        result_des =[result_des(1,1:idj),cur_idx,result_des(1,idj+1:end)];
%        len_new = len_new+1;
%     end;
    %size(result_des)==size(result)
end