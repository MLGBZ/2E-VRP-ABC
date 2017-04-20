%% -----------------------------��Ϣ��ȡ����-----------------------------
clear all; close all; clc; rand('state', sum(100*clock)); format bank;
%----4���ļ��µĲ���������Ŀ----
seq_dataset = [21,18,54,18]; %dataset�ļ��µ�4���ļ�Set2-Set5�в���������Ŀ

%----��������----
runs        = 20;                 %�ظ�ʵ�����
max_iter    = 500000;             %ÿ��ʵ������������500k

%���ļ��������������ֱ�Ϊ��21,18,54,18; %�ļ��е���ţ�1-4->Set2-Set5;
%----Start----
tic
for num_folder = 1:4%1:4                    %�ļ��е���ţ�1-4�ֱ��Ӧ�ļ���Set2-Set5;
    seq_data = seq_dataset(num_folder);      %��num_folder���ļ��еĲ�����������
    nn = seq_data;                                  %set2�еĵ�2������
    result.name=0;
    result.val=0;
    all_result_pool=cell(1,nn);
    for seq = 1:seq_data  %1:seq_data
       %----��ȡ�ļ��Ĳֿ⡢���ǡ��ͻ����ꡢ������Ϣ�Ϳͻ�����----
        %coord_dep���ֿ������
        %coord_sat�����ǣ���תվ������
        %coord_cus���ͻ�������
        %fleet��������Ϣ��fleet(1,1)Ϊ��һ�㳵�������������  fleet(1,2)Ϊ��һ���ʹ�õĳ�����Ŀ  fleet(2,1)Ϊ�ڶ��㳵�������������  fleet(2,2)Ϊ�ڶ����ʹ�õĳ�����Ŀ
        %demand���ͻ�����
        [coord_dep,coord_sat,coord_cus,fleet,demand,name] = extractdata(num_folder,seq);
        [result_pool,fitness_pool]=run_abc(coord_dep,coord_sat,coord_cus,fleet,demand,50,100);
        minval = min(fitness_pool);
        id = find(minval==fitness_pool);
        result_best = result_pool{id(1)};
        %��ͼ����
        draw_plot(result_best,coord_dep,coord_sat,coord_cus,name);
        [s2s_dist,s2d_dist,c2s_dist,c2c_dist] =compute_dist2(coord_dep,coord_sat,coord_cus);
        result.name = name;
        result.val = minval;
        result.path = result_best;
        all_result_pool{seq} = result;
        %%�����ʽҪ��
        lay_out(result_best,name,demand,c2c_dist,c2s_dist,s2d_dist,s2s_dist,minval,fleet);
    end
    save all_result_pool all_result_pool;
end
toc