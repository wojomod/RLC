clear all
clc
close all

    R = 10;               
    L = 100e-3;           
    C = 50e-6;            
    Vi = 10;
    T = 0.1;           % Czas symulacji
    x0 =  [0; 0];      % warunki początkowe 
    tspan = [0, T];
    
    [t, x] = ode45(@(t,x) RLC(t,x,R,L,C,Vi), tspan, x0); 
    
    Ii = x(:,1);    Vc = x(:,2);
    
    figure (1); plot(t, Vc, 'r', 'linewidth',0.75); grid on;
    title('Napięcie na kondensatorze'); 
    xlabel('T(s)'); ylabel('U(V)');
    
    figure (2); plot(t, Ii, 'r', 'linewidth',0.75); grid on;
    title('Prąd w odwodzie'); 
    xlabel('T(s)'); ylabel('I(A)');
    
    figure (3); plot(t, Ii.*R, 'r', 'linewidth',0.75); grid on;
    title('Napięcie na Rezystorze'); 
    xlabel('T(s)'); ylabel('U(V)');
    
    figure (4); plot(t, -Ii.*R-Vc+Vi, 'r', 'linewidth',0.75); grid on;
    title('Napięcie na Cewce'); 
    xlabel('T(s)'); ylabel('U(V)');
   

    f=0:0.01:3;
    XL = 2*pi*f*L;
    XC = 1./(2*pi*f*C);
    X = XL - XC;
    figure (5); plot(f, XL, 'linewidth',0.75);
    hold on; 
    plot(f, XC, 'linewidth',0.75);
    plot(f, X, 'linewidth',0.75);
    title('Charakterystyka częstotliwościowa'); 
    xlabel('f [Hz]'); ylabel('X [Ohm]');
    legend('XL','XC','X');
    

function y = RLC(t,x,R,L,C,Vi)
    % y(1) = d (Ii);    y(2) = d (Vc);
    %        /dt               /dt
    y = [-R/L, -1/L; 1/C, 0]*x + [1/L; 0]*Vi;
end

