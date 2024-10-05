clc
close all;
clear all;
Im = imread('deer1920.jpg');
Im1=Im(1:512,1:512);
Img= im2gray(Im1);
Img1=im2double(Img);
Img2=round(Img1.*255);
[row1 col1]=size(Img2);
blocksize=8;
%writematrix(Im, '001_befordct.csv');

PSNR1=0;

BR=0;
Z=zeros(row1, col1);
for i=1:blocksize:row1
  for j=1:blocksize:col1

W1=Img2(i:i+blocksize-1,j:j+blocksize-1);

[row col]=size(W1);

DCT=dct2(W1);

q=8;

B1q=round(DCT/q);
absB1q= abs(B1q);
Max=max(max(absB1q));
MN=min(min(absB1q));

%writematrix(absB1q, 'airport5302_afterdct_8.csv');


%[x y z]=find(absB1q);
%dectoBin=dec2bin(z,8);
%dectoBina=uint16(dectoBin);
%dectoBina=dectoBina-48;
%numone=nnz(dectoBina);

%rowb=dec2bin(x,9);
%urowb=uint32(rowb);
%arowb=rowb-48;
%erowb=numel(arowb);
%colb=dec2bin(y,9);
%ucolb=uint32(colb);
%aucolb=ucolb-48;
%ecolb=numel(aucolb);
%statebit=erowb+ecolb;
%sbit=numel(z);

%auxbit=numone;
%pbit=(log2(512)+log2(512))*numone;

%pbit=statebit;

%BR=BR+(numone+sbit+pbit)/(1000*1000);

[u v w]=find(absB1q);
sbit=nnz(w);
rowu=dec2bin(u,9);
urowu=uint16(rowu);
aurowu=urowu-48;
erowu=nnz(aurowu);
erowuall=numel(erowu);


rowv=dec2bin(v,9);
urowv=uint16(rowv);
aurowv=urowv-48;
erowv=nnz(aurowv);
ecolvall=numel(aurowv);

statebit_one=erowu+erowv;



%statebit_zero=statebit_U_V_all-statebit_one;

%statebit_one=statebit_U_V_all-statebit_zero;

%sbit=nnz(w);
dectoBin=dec2bin(w,8);
dectoBina=uint16(dectoBin);
dectoBina=dectoBina-48;

numone_b=nnz(dectoBina);
auxbit_b=numone_b;

%tofolli=(statebit+1+1)*sbit;

%tofolli=((log2(4)+log2(4)+1+1)*sbit);

%tofolli=tofolli-statebit_zero;


BR=BR+(numone_b+statebit_one+auxbit_b)/(1000*1000);



B2=B1q.*q;


RI1=idct2(B2);


%figure 
%I1=imshow(RI1,[0, 255]);

Z(i:i+7,j:j+7)=RI1;

  end
end


PSNR1=CalculatePSNR(Img2, Z);

%writematrix(Z, '001_afterdct.csv');


numofblockr=row1/blocksize;
numofblockc=col1/blocksize;

rposioflastblock=row1-blocksize;
cposioflastblock=col1-blocksize;

numofcolbit=numel(dec2bin(rposioflastblock))-numel(dec2bin(8));
numofrowbit=numel(dec2bin(cposioflastblock))-numel(dec2bin(8));
tbitr=numofblockr*numofblockc*(numofcolbit+numofrowbit)/(1000*1000);

BR=BR+tbitr

PSNR1