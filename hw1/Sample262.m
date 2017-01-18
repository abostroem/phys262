% Top level sample Matlab program for Phys 262
% The point of this sample program is to help you quickly learn the aspects
% of Matlab you will need to do the Phys 262 homework.
% This sample plots some simple curves

% the data structure "par" contains all the fixed paramters
% I reccomend using data structures so that all paramters can easily be
% passed to functions.
par.m = 1; % Note: If you do not put a semicolon at the end of a line the result will appear on the command line
par.b = 4;  

par2.m = 2;
par2.b = 8;

par.a = 3;
par.c = -1;

par2.a = 6;
par2.c = -2;

par.A = 1; %matlab is case sensitive
par.f = 2*pi; % Note that pi is predifined in Matlab;

par2.A = 2;
par2.f = 4*pi; 

x = linspace(0,1) % define a vector x to be the x coordinates
y1 = f1(x,par); % define vector of y coordinates
y2 = f2(x,par); % define another vector of y coordinates
y3 = fSin(x,par); % define another vector of y coordinates

z1 = f1(x, par2)
z2 = f2(x, par2)
z3 = fSin(x, par2)

figure('visible', 'off')
subplot(2, 1, 1)
plot(x,y1,'r--');  % type "help plot" at the command line for more info
hold on % this command causes the next plot to appear in the same figure
plot(x,y2,'b');
plot(x,y3,'k-.');
xlim([0,1]); % set axis limits
ylim([-3, 11]);
xlabel('x axis')
ylabel('y axis')
title('Original Parameters')
legend('linear','quadratic','sine')

subplot(2, 1, 2)
plot(x, z1, 'm--');
hold on
plot(x, z2, 'c');
plot(x, z3, 'g-.')
hold off
xlim([0,1]); % set axis limits
ylim([-3, 11]);
xlabel('x axis')
ylabel('y axis')
title('2 Times Original Parameters')
l=legend('linear','quadratic','sine')
l.Location='east'

print ('sample_plot','-dpng')
close()