function result = Initize(coord_dep,coord_sat,coord_cus,fleet,demand,c2s_dist)
%----��ȡ�ļ��Ĳֿ⡢���ǡ��ͻ����ꡢ������Ϣ�Ϳͻ�����----
        %coord_dep���ֿ������
        %coord_sat�����ǣ���תվ������
        %coord_cus���ͻ�������
        %fleet��������Ϣ��fleet(1,1)Ϊ��һ�㳵�������������  fleet(1,2)Ϊ��һ���ʹ�õĳ�����Ŀ  fleet(2,1)Ϊ�ڶ��㳵�������������  fleet(2,2)Ϊ�ڶ����ʹ�õĳ�����Ŀ
        %demand���ͻ�����
        %dist ��һ�㳵��������֮��ľ���
        %cluster ̰�Ĺ���ķ���
        %demand ������ÿ���������
        
        %C_dist=compute_dist2(coord_dep,coord_sat,coord_cus);
       [cluster,sat_demand]=compute_dist(demand,c2s_dist);
       [sat_num,a] = size(coord_sat);
       [cur_num,b] = size(coord_cus);
       result{1} = Lay1Initize(coord_sat,coord_dep,fleet);
       for i = 1:sat_num
           cluster_sat{i} = find(cluster(:,2)==i);
           cluster_cur= cluster_sat{i} ;
           result{i+1} = Lay2Initize(cluster_cur,i,fleet);
       end
      demand_pool= lay1_path_demand(result,coord_sat,demand);
      %������ÿһ����0��λ����Ӷ�Ӧ��demand
      demand_path =zeros(size(result{1}));
      %·���з�0��λ��
      result_lay1 = result{1};
      cur_1 = find(result_lay1~=0);
      %cur_idx ��ʾ��0λ��cur_1��result_lay1������Ŀͻ���λ��
      cur_idx = result_lay1(cur_1);
      demand_path(cur_1) = demand_pool(cur_idx);
      result{sat_num+2} = demand_path;
      demand_path ;
end