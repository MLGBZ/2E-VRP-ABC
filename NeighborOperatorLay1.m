function result_new = NeighborOperatorLay1(result,coord_sat,demand,s2d_dist,c2s_dist,c2c_dist,s2s_dist,fleet,coord_dep)
    %%��Ҫ���ƻ����޸�Ϊԭ��
    result_new_w = result;
    sat_num = size(coord_sat,1);
    %��ʼ����һ��·��
    result_new_w{1} =  Lay1Initize(coord_sat,coord_dep,fleet); 
%     len = size(result_new_w{1})
%     if(len<=6)
%         result_new_lay1 =  Lay1Initize(coord_sat,coord_dep,fleet);
%     else
%         result_new_lay1 = Lay2NeighborOperator(result_lay1);
%     end;
    result_new = destory_recover_lay1(result_new_w,coord_sat,demand,s2d_dist,c2s_dist,c2c_dist,s2s_dist,fleet);
    %%����demand_path;
    result_new{1} = result_new_w{1} ;
    demand_pool= lay1_path_demand(result_new,coord_sat,demand);
    %������ÿһ����0��λ����Ӷ�Ӧ��demand
    demand_path =zeros(size(result_new{1}));
    %·���з�0��λ��
    result_lay1 = result_new{1};
    cur_1 = find(result_lay1~=0);
    %cur_idx ��ʾ��0λ��cur_1��result_lay1������Ŀͻ���λ��
    cur_idx = result_lay1(cur_1);
    demand_path(cur_1) = demand_pool(cur_idx);
    result_new{sat_num+2} = demand_path;
    
    %size(result_new)==size(result);
   
%     fitness_lay1 = fitnesslay1(result_lay1,fleet(1,1),demand_path,s2d_dist,s2s_dist);
%     if(fitness_lay1<10000)
%         [result_res,demand_res] = lay1_demand_div(result_lay1,demand_path,fleet,s2d_dist,s2s_dist)
%         % result_new = result;
%         %%��һ��·���Ľ���仯
%         %%��һ·���ɲ������
%         %result_new = result;
%         fitness_lay1_res = fitnesslay1(result_res,fleet(1,1),demand_res,s2d_dist,s2s_dist);
%         if(fitness_lay1_res<fitness_lay1)
%             result_new{1} = result_res;
%             result_new{end} = demand_res;
%         end;
%     end;
end