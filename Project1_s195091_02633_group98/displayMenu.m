%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Forfatter: Mikkel N. Schmidt, kode taget fra
% link: https://www.youtube.com/watch?v=zLb4ZHFfbO0
% Medforfatter : Ulrik Dan Hansen, s195091 
% Dato: 14. januar 2022
% Sted: Dansk Tekniske Univeristet
% Kursus: 02633 Introduktion til programmering og databehandling
% Dokument navn: displayMenu.m
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function userInput = displayMenu(options, filterSwitch)

for i = 1:length(options)
    fprintf('%d. %s\n', i, options{i}); % Udskriver menuen og mulighederne 
end

if strcmp(filterSwitch, 'activated')
    fprintf('Filter is: %s\n', filterSwitch); % Udskriver at filter er påsat
end

userInput = 0; % default
while ~any(userInput == 1:length(options))
    if userInput < length(options)       
        userInput = inputNumber('Please choose a menu item: '); % tjekker om tallet er indenfor menu-intervallet
    else
        fprintf('Invalid input. Try again.\n'); % hvis ikke: bruger får besked.
        break
    end
end
