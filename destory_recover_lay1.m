function [result_new] = destory_recover_lay1(result,coord_sat,demand,s2d_dist,c2s_dist,c2c_dist,s2s_dist,fleet)
    result_lay1 = result{1};
    %%-----------���ȥ���ڶ����е�һЩ�ͻ���-----------
    %1��ȥ���ͻ���ɲ�����ѡ��ÿ�������о�������λ����Զ��λ�ã������Ժ�������
    result_new = cell(size(result));
    result_new{1} = result_lay1;
    sat_num = size(coord_sat,1);
    q = 2;
    cur_pool_all=[];
    for i = 1:sat_num
        result_lay2 = result{i+1};
        [cur_pool,result_des] = destory(result_lay2,q);
       
        cur_0=[];
        %������ȥ������0�����0Ԫ�ط����µĿͻ����У����лָ�
        j = q;
        while(j>0)
            if(cur_pool(j)==0)
                cur_0=[cur_0,0];
                %ȥ���ͻ����е�0
                cur_pool(j) =[];
            end
            j = j-1;
        end;
        %�ָ�ȥ����0�ڵ�
        if(size(cur_0,2)==0)
            result_rec = result_des;
        else
            [result_rec]=recovery(result_des,cur_0,fleet,demand,c2s_dist(i,:),c2c_dist);
        end
        %�Ѹÿͻ��ط����ܿͻ�����
        cur_pool_all = [cur_pool_all,cur_pool];
        %���½�
        result_new{i+1} = result_rec;
    end;
    %�ܵĿͻ����еĿͻ�����
    %2��ͨ��ȥ���Ŀͻ��㵽����֮��ľ��룬���̶Ĳ���ĳһ�����У������λ�û����ø�������Ӧֵ��С��λ��
    left_cur_num = size(cur_pool_all,2);
    insert2sat_pool = zeros(1,left_cur_num);%ÿ���ͻ�Ӧ�÷����Ǹ�����
    %���̶�
    if(numel(cur_pool_all)==0)
           
    else
        for i = 1:left_cur_num
            cur = cur_pool_all(i);
            dist = c2s_dist(:,cur);%�������ǣ����ǿͻ�
            dist_sum =double(sum(1./(dist+1)));
            fx = double((1./(dist+1))/dist_sum);
            insert2sat_pool(i) = roulette(fx);
        end
        for i = 1:sat_num
            anss = find(insert2sat_pool==i);%���ﾹȻд���ˣ���iд��sat_num�ˣ����Ǵ���
            result_lay2 = result_new{i+1};
            if(isempty(anss))
            else
                cur_pool_rec =cur_pool_all(anss);
                result_lay2 = recovery(result_lay2,cur_pool_rec,fleet,demand,c2s_dist(i,:),c2c_dist);
            end
            result_new{i+1} = result_lay2;
        end;
    end;
    
end