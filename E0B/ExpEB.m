% Aplicações de Processamento Digital de Sinais - 4456S-04
% Experiência EB: Utilização do MATLAB em processamento de sinais:
%   geracao e visualizaçao de sinais
% Prof. Denis Fernandes 
% Ultima atualizacao: 22/02/2019

%% Item a
n = 0:100;
w = pi/20;
xn = 5*exp(j*w*n);
subplot(1,2,1);
plot(n,real(xn'),n,imag(-xn'));
axis([0 100 -6 6]);
title('x[n] - partes real e imaginaria');
xlabel('n');
ylabel('amplitude');
subplot(1,2,2);
plot(n,abs(xn'),n,angle(xn)');
axis([0 100 -6 6]);
title('x[n] - modulo e fase');
xlabel('n');
rms = sqrt(sum(xn.*conj(xn))/length(xn));
disp(['rms = ' num2str(rms)]);

%% Item b
n = 0:100;
w = pi/20;
r = 0.95;
xn = 5*r.^n.*exp(j*w*n);
subplot(1,2,1);
plot(n,real(xn'),n,imag(-xn'));
axis([0 100 -6 6]);
title('x[n] - partes real e imaginaria');
xlabel('n');
ylabel('amplitude');
subplot(1,2,2);
plot(n,abs(xn'),n,angle(xn)');
axis([0 100 -6 6]);
title('x[n] - modulo e fase');
xlabel('n');
rms = sqrt(sum(xn.*conj(xn))/length(xn));
disp(['rms = ' num2str(rms)]);

%% Item c
NP = 8;
map = zeros(256,3);
map(1:256,1)=((0:255)/255)';
map(1:256,2)=((0:255)/255)';
map(1:256,3)=((0:255)/255)';
x = zeros([NP NP 3]);
for n = 1:NP,
    for m = 1:NP,
        x(n,m,:) = (n+m-2)/(NP+NP-2);
    end;
end;  
imwrite(x,map,'img.bmp');
[y, map] = imread('img.bmp');
subplot(2,2,1);
imshow(y);
y(:,:,[2 3])=0;
subplot(2,2,2);
imshow(y);
y = x;
y(:,:,[1 3])=0;
subplot(2,2,3);
imshow(y);
y = x;
y(:,:,[1 2])=0;
subplot(2,2,4);
imshow(y);

%% Item d
[x, map] = imread('lena.bmp');
size(x)
subplot(2,3,1);
imshow(x);
y = uint8(255-double(x));
subplot(2,3,2);
imshow(y);
y = 0.2989*x(:,:,[1])+0.5870*x(:,:,[2])+0.1140*x(:,:,[3]);
subplot(2,3,3);
imshow(y);
y = x;
y(:,:,[2 3])=0;
subplot(2,3,4);
imshow(y);
y = x;
y(:,:,[1 3])=0;
subplot(2,3,5);
imshow(y);
y = x;
y(:,:,[1 2])=0;
subplot(2,3,6);
imshow(y);


