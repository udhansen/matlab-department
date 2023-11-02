%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Forfatter: Mikkel N. Schmidt, kode taget fra
% link: https://www.youtube.com/watch?v=zLb4ZHFfbO0
% Medforfatter : Ulrik Dan Hansen, s195091 
% Dato: 20. januar 2022
% Sted: Dansk Tekniske Univeristet
% Kursus: 02633 Introduktion til programmering og databehandling
% Dokument navn: displayMenu.m
% Projekt 2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function userInput = displayMenu(options)

for i = 1:length(options)
    fprintf('%d. %s\n', i, options{i}); % Udskriver menuen og mulighederne 
end

userInput = 0; % default
while ~any(userInput == 1:length(options))
    if userInput < length(options)       
        userInput = inputNumber('Vælg en handling: '); % tjekker om tallet er indenfor menu-intervallet
    else
        fprintf('Ugyldig input. Prøv igen.\n'); % hvis ikke: bruger får besked.
        break
    end
end
