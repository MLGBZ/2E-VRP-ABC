function result_new = Lay2NeighborOperator(result)
   %�������ظ����ֵ�����������������ʼ��ͬ
   %ԭ������������ظ�ʱ�ͻ�������⣡������(�ѽ��)
    len = size(result,2);
    %rand_vector = randi([2,len-1],1,4);
    %������������ɵķ���
    if(len-2<4)
        result_new = result;
    else
        rand_vector = randperm(len-2,4)+1;
        rand_vector = sort(rand_vector);
        
        % disp(rand_vector);
        %%���
        ser1 = result(1,rand_vector(1):rand_vector(2));
        ser1 = fliplr(ser1);
        ser2 = result(1,rand_vector(3):rand_vector(4));
        ser2 = fliplr(ser2);
        %%ƴ��
        result_new = result(1,1:rand_vector(1)-1);
        result_new = [result_new,ser2];
        result_new = [result_new,result(1,rand_vector(2)+1:rand_vector(3)-1)];
        result_new = [result_new,ser1];
        result_new = [result_new,result(1,rand_vector(4)+1:len)];
    end;
   % size(result_new)==size(result);
end