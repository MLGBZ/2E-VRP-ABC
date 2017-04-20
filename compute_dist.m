function [cluster,sat_demand]=compute_dist(demand,c2s_dist)
%sat_num ��ʾ���ǵ�����
%cus_num ��ʾ�ͻ�������
    [sat_num,cur_num] = size(c2s_dist);
    cluster = ones(cur_num,2);
    sat_demand = zeros(sat_num,1);
    for i = 1:cur_num;
        minval = min(c2s_dist(:,i));
        minidx = find(c2s_dist(:,i) == minval);
        cluster(i,1) = i;
        cluster(i,2) = minidx(1);
        sat_demand(minidx,1)= demand(i,1)+sat_demand(minidx,1);
%         if(sat_demand>fleet(1,1))%������ڵ�һ�㳵���������,��������ǲ����������ͻ�������һ�����⣬�����������ʱ������������ô�죩
%             coord_sat2= [-1,-1];
%         end
    end          
  %  disp(dist);
   % disp(cluster);
   % disp(sat_demand);
end
