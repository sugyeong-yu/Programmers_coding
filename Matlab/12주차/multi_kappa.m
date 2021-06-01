function [result, table]=multi_kappa(r_data, e_data, table_value)

tot_len=length(r_data);

table=zeros(length(table_value)+1, length(table_value)+1);
% 
% for i=1:tot_len
%    if (e_data(i)==table_value(1)) & (r_data(i)==table_value(1))
%        table(1, 1)=table(1, 1)+1;
%         
%    elseif (e_data(i)==table_value(1)) & (r_data(i)==table_value(1))
%        
%        tn=tn+1;
%    end
%    
% end
% 
% p0=diag/100;


for i=1:length(table_value)
    idx=find(e_data==table_value(i));    
    row{i}=r_data(idx);    
    
    tot_row=length(row{i});
    
    table(i, end)=tot_row;
end


for i=1:length(table_value)
    for j=1:length(table_value)
        idx=find(row{i}==table_value(j));
    
        table(i, table_value(j))=length(idx);
    end
end        

po=0;
pe=0;
for i=1:length(table_value)
    tot_col=sum(table(:, i));
    
    table(end, i)=tot_col;    
    
    pe=pe+(table(end, i)/tot_len*table(i, end)/tot_len);
    po=po+table(i, i)/tot_len;
end

result.kappa=(po-pe)/(1-pe);
% result.pe=pe;
result.agree=po;


table(end, end)=tot_len;




