function demand_sat = computeSatDemand(result,demand)
%����ÿ������·���ϵ���������
%������ܵĺ����Ҿ�Ȼд�����飬��Ȼд����ͷ��
len = size(result,2);
demand_sat = 0;
for i =1:len-1
    idx = result(i);
    if(idx==0)
    else
        demand_sat = demand_sat+demand(idx);
    end
end
end