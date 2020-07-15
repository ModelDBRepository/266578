%Developer Fabio Simoes de Souza, 
%University Federal of ABC and 
%University of Colorado Anschutz Medical Campus, 2020


function Plot_results

color1 ='or';
color2 ='-r';

load data_spkt_PC_soma.dat
load data_spkt_SC0_soma.dat
load data_spkt_SC1_soma.dat

tmax = 5000; %ms
dt = 1e-3;

[tempo,binned] = binando(data_spkt_PC_soma, tmax);

figure(2)
subplot(411)
hold on
S = PSTH_gaussiana(binned);
plot(tempo*1e-3,S + abs(min(S)),color2,'LineWidth',2);
ylabel('Lick Strength (a.u.)', 'FontSize',14)
set(gca, 'FontSize',14)

bin=60;
subplot(412)
hold on
[n1,c1]=hist(data_spkt_PC_soma,0:bin:tmax);
plot(c1*1e-3,n1/(bin*1e-3),color2,'LineWidth',2);
ylabel('PC (Hz)', 'FontSize',14)
set(gca, 'FontSize',14)
subplot(413)
hold on
[n2,c2]=hist(data_spkt_SC0_soma,0:bin:tmax);
plot(c2*1e-3,n2/(bin*1e-3),color2,'LineWidth',2);
ylabel('SC supp(Hz)', 'FontSize',14)
set(gca, 'FontSize',14)
subplot(414)
hold on
[n3,c3]=hist(data_spkt_SC1_soma,0:bin:tmax);
plot(c3*1e-3,n3/(bin*1e-3),color2,'LineWidth',2);
ylabel('SC deep (Hz)', 'FontSize',14);
xlabel('Time (s)', 'FontSize',14);
set(gca, 'FontSize',14)

%Gaussian kernel to create PSTH
function s = PSTH_gaussiana(binned)
[n m] = size(binned);
sigma = 100e-3; % Standard deviation of the kernel
edges=[-3*sigma:1e-3:3*sigma]; %Time ranges form -3*st. dev. to 3*st. dev.
kernel = normpdf(edges,0,sigma); %Evaluate the Gaussian kernel
kernel = -kernel*1e-3; %Multiply by bin width so the probabilities sum to 1
s=conv(binned,kernel); %Convolve spike data with the kernel
center = ceil(length(edges)/2); %Find the index of the kernel center
s=s(center:m+center-1); %Trim out the relevant portion of the spike density

function [tempo,binned] = binando(spiketimes, tmax)
tamanho = tmax;
tempo = linspace(0,tmax, tamanho);
binned = linspace(0,tmax, tamanho)*0;
for p = 1: length(spiketimes)
indice = find(tempo>=spiketimes(p));
binned(indice(1)) = 1;
end




