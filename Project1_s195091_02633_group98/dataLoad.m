%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Forfatter: Ulrik Dan Hansen, s195091
% Dato: 14. januar 2022
% Sted: Dansk Tekniske Univeristet
% Kursus: 02633 Introduktion til programmering og databehandling
% Dokument navn: dataLoad.m
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function data = dataLoad(filename)
    % Indlæser filen
    dataFileRead = readtable(filename);

    % Vektor for hver kolonne, for henholdvis temperatur, growth rate og bacteria
    Temperature = reshape(dataFileRead{:,1},1,length(dataFileRead{:,1}));

    GrowthRate = reshape(dataFileRead{:,2},1,length(dataFileRead{:,2}));

    Bacteria = reshape(dataFileRead{:,3},1,length(dataFileRead{:,3}));

    % Sætter output til default
    data = zeros(length(dataFileRead{:,1}),3);

    %% Kolonne 1 - Temperature
    for i = 1:length(dataFileRead{:,1})
        if (10 <= Temperature(i)) && (Temperature(i) <= 60) % temperatur mellem 10 og 60
            data(i,1) = Temperature(i);
        else
            data(i,1) = NaN; % Indsæt NaN hvis betingelse ikke er opfyldt.
            fprintf('Invalid line. Temperature is out of the specified range (line: %.0f)\n', i); %Giver bruger besked hvilken række, hvis betingelsen ikke er opfyldt
        end  
    end

    %% Kolonne 2 - Growth Rate
    for i = 1:length(dataFileRead{:,2})
            if GrowthRate(i) > 0            % Growth rate større end nul
            data(i,2) = GrowthRate(i);
            else
            data(i,2) = NaN; % Indsæt NaN hvis betingelse ikke er opfyldt.
            fprintf('Invalid line. Growth Rate out of range. Value must be positive (line: %.0f)\n', i); %Giver bruger besked hvilken række, hvis betingelsen ikke er opfyldt
            end
    end

    %% Kolonne 3 - Bacteria
    % Tjekker at bakterie-typen er angivet efter de 4
    % muligheder/bakterietyper
    for i = 1:length(dataFileRead{:,3})

        if Bacteria(i) == 1          % Salmonella enterica
            data(i,3) = Bacteria(i);
        elseif Bacteria(i) == 2      % Bacillus cereus
            data(i,3) = Bacteria(i);
        elseif Bacteria(i) == 3      % Listeria
            data(i,3) = Bacteria(i);
        elseif Bacteria(i) == 4      % Brochothrix thermosphacta
            data(i,3) = Bacteria(i);
        else
            data(i,3) = NaN; % Indsæt NaN hvis betingelserne ikke er opfyldt.
            fprintf('Invalid line. Undefined bacteria (line: %.0f)\n', i); %Giver bruger besked hvilken række, hvis betingelserne ikke er opfyldt
        end
    end

    %% Filbehandling
    % Denne kode er fundet på nedstående hjemmeside:
    % https://se.mathworks.com/matlabcentral/answers/31971-delete-rows-with-nan-records

    data(any(isnan(data), 2), :) = []; % Linjer med NaN i slettes, any() tjekker for tal der ikke er 0 samt ignorerer NaN.

