%Code for HW 1.2
%Plots 3 functions: g2, g3, and g3 on linear and log scaless

x = linspace(0.1, 1, 100);
%Set parameters
par.A2 = 1
par.A3 = 1
par.A4 = 1

%Call functions
y2 = g2(par.A2, x);
y3 = g3(par.A3, x);
y4 = g4(par.A4, x);

%Plot linear
figure('visible', 'off')
subplot(2, 1, 1)
plot(x, y2, 'r')
hold on
plot(x, y3, 'b')
plot(x, y4, 'g')
hold off
legend('g2', 'g3', 'g4')
xlabel('x-axis')
ylabel('y-axis')
title('Problem 1.2 plot with linear axes')

%Plot log
subplot(2, 1, 2)
loglog(x, y2, 'r')
hold on
loglog(x, y3, 'b')
loglog(x, y4, 'g')
hold off
legend('g2', 'g3', 'g4')
xlabel('x-axis')
ylabel('y-axis')
title('Problem 1.2 plot with log axes')
set(gca, 'XTick', linspace(0.1, 1, 10))
set(gca, 'XTickLabel', linspace(0.1, 1, 10))

%Save figure
print ('problem1.2.png','-dpng')