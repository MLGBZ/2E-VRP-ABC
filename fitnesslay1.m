function fitness_lay1= fitnesslay1(result,cap_lay1,demand,s2d_dist,s2s_dist)
    fitness_lay1 =0;
    M1 = 10000;%���سͷ�ϵ��
    M2 = 0;
    demand_path =0;
    len = size(result,2);
    for i =1:len-1
        idx = result(i);
        next = result(i+1);
        %��������ж�
        if(idx ==0)
            demand_path =0;
        else
            demand_path = demand_path+demand(i);
        end;
        if(demand_path>cap_lay1)
            fitness_lay1 = fitness_lay1+M1;
        end;
        %·�������ж�
        if(idx==0||next==0)
            %01�����
            if(idx ==0&&next~=0)
                fitness_lay1 = fitness_lay1+s2d_dist(1,next);
            end
            %10�����
            if(idx~=0&&next==0)
                fitness_lay1 = fitness_lay1+s2d_dist(1,idx);
            end
            %00�������˵����·��û���ã�����轱��
            if(idx==0&&next==0)
                fitness_lay1 = fitness_lay1-M2;
            end
        else
            fitness_lay1 = fitness_lay1+s2s_dist(idx,next);
        end
    end
%      disp('-----lay1--------')
%      disp(fitness_lay1);
end