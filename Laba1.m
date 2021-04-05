clear
clc

%Выборка равномерного распределения
N=10000;
X=2+(4-2)*rand(N,1);

%Выборочное среднее, дисперсия и среднеквадратичное отклонение
Mean = mean(X);
Var = var(X);
SrOtkl = sqrt(Var);

%Среднее
X_mean_array = 0:1:1000;
X_var_array = 0:1:1000;

for i=1:1000
    X=2+(4-2)*rand(10000,1);
    X_mean = mean(X);
    X_var = var(X);
    X_mean_array(i) = X_mean;
    X_var_array(i) = X_var;
end
clear X_mean;
clear X_var;

M = mean(X_mean_array);
V = mean(X_var_array);

%Кол-во интервалов
r=floor(log2(N))+1;

%Min и Max значения выборки
X_max = max(X);
X_min = min(X);

%Ширина каждого интервала групировки
h=(X_max-X_min)/r;

%Создание интервалов
for i=0:r
    Z(i+1)=X_min+i*h;
end
clear 'i'


for i=1:r
    Zmean(i) = Z(i+1)-h/2;
end
clear 'i';
%Построение гистограмы
U= hist(X,Zmean);
H=U/(h*N);

%Набор точек для вычисления и плотность вероятности
x = [0:0.001:5];
y = [2:0.001:4];
pdf_uni = pdf('Uniform',x,2,4);

%Эмпирическая функция распределения
%Несгруппированные данные
X_sort = sort(X);
T=1/N:1/N:1;
% %Сгруппированные данные
current = 0;
% S=2:2/r:4;
for i=1:r
    S1(i) = current/N;
    current = current + U(i);
end
S1(r+1)=1;


uni_cdf = cdf('Uniform',y,2,4);
figure;
subplot(2,1,1);
bar(Zmean,H,1);
hold on;
plot(x,pdf_uni);
hold off;
subplot(2,1,2);
stairs(X_sort,T);
hold on;
stairs(Z-h,S1);
hold on;
plot(y,uni_cdf);

