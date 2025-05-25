clc; clear; close all;

% Definir rangos para lambda y alpha
lambda = linspace(0,1,50);
alpha = linspace(0,1,50);
[L, A] = meshgrid(lambda, alpha); % Crear malla

% Resolver R usando fsolve en lugar de fzero
R = zeros(size(L)); % Inicializar R con ceros
options = optimset('Display', 'off'); % Configuración para suprimir mensajes

for i = 1:numel(R)
    fun = @(R) R - (1 - exp(- (L(i) + A(i)) ./ A(i)) .* R);
    R(i) = fsolve(fun, 0.5, options); % 0.5 es la estimación inicial
end

% Graficar la superficie
figure;
surf(A, L, R, 'EdgeColor', 'none'); % Gráfica de superficie sin bordes
colormap jet;
xlabel('\alpha');
ylabel('\lambda');
zlabel('R');
title('Final size of the rumor R as a function of \lambda and \alpha');
colorbar;
grid on;

% Guardar la gráfica como EPS para LaTeX
print -depsc2 'grafica2_SIHR.eps'
