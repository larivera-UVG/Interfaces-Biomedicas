%% Execise 5.8 - oxygen concentration and temperature


% Define the function whose root we want to approximate
arr = [8, 10, 14];
func = @(x) (- log(o_sf) -139.34411 + 1.575701*1e5/(x+273.15)-6.642308*1e7 /((x+273.15)^2) + 1.243800*1e10/ ((x+273.15)^3) - 8.621949*1e11/((x+273.15)^4) ); 
% Define the upper and lower guesses
xu = 35;
xl = 0;

Ead = 0.05;

%% using the bisect method

for i=1:3
  o_sf = arr(i);
  func = @(x) (- log(o_sf) -139.34411 + 1.575701*1e5/(x+273.15)-6.642308*1e7 /((x+273.15)^2) + 1.243800*1e10/ ((x+273.15)^3) - 8.621949*1e11/((x+273.15)^4) ); 
  [root, n] = bisectnew(func,xl,xu);

  fprintf("\n\nFor oxygen concentration %d\n", arr(i));
  fprintf("Number of iterations needed: %d", n);
  fprintf("\nRoot approximation: %g", root);
end