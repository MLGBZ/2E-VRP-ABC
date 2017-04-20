function [result_pool,fitness_pool]=run_abc(coord_dep,coord_sat,coord_cus,fleet,demand,food_num,max_iter_num)
    %--------------------------��ʼ���׶�---------------------------%
    W = zeros(1,food_num);%ʳ��Դ�޸��ƵĴ���
    W_limit = 50;
    theta = 1.3;
    result_pool = cell(1,food_num);%ʳ��Դ��
%     s2s_dist ����֮��ľ���
%     s2d_dist ������ֿ�֮��ľ���
%     c2s_dist �ͻ�������֮��ľ���
%     c2c_dist �ͻ���ͻ�֮��ľ���

    [s2s_dist,s2d_dist,c2s_dist,c2c_dist] =compute_dist2(coord_dep,coord_sat,coord_cus);%�������
    %��ʼ��ʳ��Դ
    fitness_pool = zeros(1,food_num);
    for i= 1:food_num
        result_pool{i} = Initize(coord_dep,coord_sat,coord_cus,fleet,demand,c2s_dist);
       % disp(result_pool{i});
         fitness_pool(i) = fitness(result_pool{i},coord_sat,demand,s2d_dist,c2s_dist,c2c_dist,s2s_dist,fleet);
    end
    iter_num = 0;
    
    while iter_num < max_iter_num
        
        %%--------------------------��������׶�---------------------------------
        for i = 1:food_num;
            result = result_pool{i};
            fitness_old = fitness_pool(i);
            %-----�������------% %-----������Ӧֵ-----%ֻ�Եڶ�������˽������������ƻ����޸�
           [result_new]= NeighborOperator(result,coord_sat,demand,s2d_dist,c2s_dist,c2c_dist,s2s_dist,fleet);
           fitness_new = fitness(result_new,coord_sat,demand,s2d_dist,c2s_dist,c2c_dist,s2s_dist,fleet);
           if (fitness_old <fitness_new)
               W(i) = W(i)+1;
           else
                result_pool{i} = result_new;
                fitness_pool(i) = fitness_new;
           end;
          %  fitness(result,coord_sat,demand,s2d_dist,c2s_dist,c2c_dist,s2s_dist,fleet);
        end
        %--------------��Ӷ��׶�---------------------------------------------%
        fitness_sum = sum(1./(fitness_pool+1));
        fx = double(1./(fitness_pool+1)/double(fitness_sum));
       % disp(fitness_pool);
        select =zeros(1,food_num);
        %���̶�
        for i = 1:food_num
            sel = rand;
            sumPs = 0;
            j =1;
            while(sumPs<sel)
                sumPs = sumPs+fx(j);
                j = j+1;
            end;
            select(i) = j-1;
        end;
        %-----------------------------------�������--------------------------% 
       for i = 1:food_num
           id= select(i);
           result = result_pool{id};
            fitness_old = fitness_pool(id);
            %-----�������------% %-----������Ӧֵ-----%ֻ�Եڶ�������˽������������ƻ����޸�
           [result_new]= NeighborOperator(result,coord_sat,demand,s2d_dist,c2s_dist,c2c_dist,s2s_dist,fleet);
           fitness_new = fitness(result_new,coord_sat,demand,s2d_dist,c2s_dist,c2c_dist,s2s_dist,fleet);
           W(id) = W(id)+1;
           if (fitness_old <fitness_new)
               W(id) = W(id)+1;
           else
                result_pool{id} = result_new;
                fitness_pool(id) = fitness_new;
           end;
       end;
       %-----------------------------------�Ե�һ��͵ڶ��㳵�������ƻ����޸�����-------------------------%
      %����1����õĽ�����е�һ����������Ƕ����Ĳ������е�һ�����
       for i = 1:food_num
           if(W(i)>W_limit)
             % ����ƻ���̰���޸�
           %  disp('000000000000000000000000000000000000000000');
               result_new = NeighborOperatorLay1(result_pool{i},coord_sat,demand,s2d_dist,c2s_dist,c2c_dist,s2s_dist,fleet,coord_dep);
               [result_new]= NeighborOperator(result_new,coord_sat,demand,s2d_dist,c2s_dist,c2c_dist,s2s_dist,fleet);
               fitness_old = fitness_pool(i);
               fitness_new = fitness(result_new,coord_sat,demand,s2d_dist,c2s_dist,c2c_dist,s2s_dist,fleet);
               if(fitness_old>fitness_new)
                   fitness_pool(i) = fitness_new;
                   result_pool{i}= result_new;
                   W(i) = 0;
               else
                   minval = min(fitness_pool);
                   cur_min =find(fitness_pool==minval);
                   if(fitness_old<=(theta*minval)&&(size(cur_min,2)<= (food_num/3)+1));
                       W(i) = (W(i)-W_limit/2);
                   else
                       result_new =Initize(coord_dep,coord_sat,coord_cus,fleet,demand,c2s_dist);
                       fitness_new = fitness(result_new,coord_sat,demand,s2d_dist,c2s_dist,c2c_dist,s2s_dist,fleet);
                       fitness_pool(i) = fitness_new;
                       result_pool{i} = result_new;
                   end;
               end;
           end;
        end;
        
   %   -----------------------------------��ʳ����нϺõ�������Դ������ͬ�������------------------------%
      iter_num = iter_num +1;
      % disp(min(fitness_pool));   
        
    
   end;
   %disp(fitness_pool);
  % save result_pool result_pool; 
end