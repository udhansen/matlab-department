%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Forfatter: Ulrik Dan Hansen, s195091
% Dato: 14. januar 2022
% Sted: Dansk Tekniske Univeristet
% Kursus: 02633 Introduktion til programmering og databehandling
% Dokument navn: dataStatistics.m
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Funktion der retunere en værdi for den valgte statistik
% strcmpi sørger for at brugeren kan skrive med store og små bogstaver
function result = dataStatistics(data, statistic)

if strcmpi(statistic, 'Mean temperature')
    result = mean(data(:,1));                        % Middelværdi af temperatur
elseif strcmpi(statistic, 'Mean growth rate')
    result = mean(data(:,2));                        % Middelværdi af growth rate
elseif strcmpi(statistic, 'Std temperature')
    result = std(data(:,1));                         % Standard-afvigelse af temperatur
elseif strcmpi(statistic, 'Std growth rate')
    result = std(data(:,2));                         % Standard-afvigelse af growth rate
elseif strcmpi(statistic, 'Rows')
    result = length(data(:, 1));                     % Antal rækker i data-fil
elseif strcmpi(statistic, 'Mean Cold Growth rate')
    result = mean(data(data(:,1) < 20));             % Middelværdi for temperature under 20
elseif strcmpi(statistic, 'Mean Hot Growth rate')
    result = mean(data(data(:,1) > 50));             % Middelværdi for temperature over 50
else
    result = NaN;
end

