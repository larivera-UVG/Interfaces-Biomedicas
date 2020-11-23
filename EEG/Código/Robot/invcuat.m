function qi = invcuat(q)
% Funcion auxiliar para el calculo de la cinematica del manipulador
    qi = -q;
    qi(1) = q(1);
end