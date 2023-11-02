%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Forfatter: Mikkel N. Schmidt, kode taget fra
% link: https://www.youtube.com/watch?v=zLb4ZHFfbO0
% Medforfatter : Ulrik Dan Hansen, s195091 
% Dato: 14. januar 2022
% Sted: Dansk Tekniske Univeristet
% Kursus: 02633 Introduktion til programmering og databehandling
% Dokument navn: inputNumber.m
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function num = inputNumber(prompt)

while true 
    num = str2double(input(prompt, 's'));
    if ~isnan(num)
        break;
    else
        fprintf('Invalid input. Try again.\n'); % Giv bruger besked om ugyldigt input.
    end
end
